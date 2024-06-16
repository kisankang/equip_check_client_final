// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/new_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:equip_check_client/app/routes/app_pages.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ProjectListController extends GetxController {
  final AppService _appService;
  final LocalMachineDataService _localMachineDataService;
  final LocalGalleryDataService _localGalleryDataService;
  ProjectListController({
    required AppService appService,
    required LocalMachineDataService localMachineDataService,
    required LocalGalleryDataService localGalleryDataService,
  })  : _appService = appService,
        _localMachineDataService = localMachineDataService,
        _localGalleryDataService = localGalleryDataService;

  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  Rx<List<Project>> projectList = Rx([]);
  Rx<List<bool?>> needUpdateCheckList = Rx([]);

  bool isOfflineMode = false;
  @override
  Future<void> onInit() async {
    searchFocusNode = FocusNode();
    searchController = TextEditingController();
    // ..addListener(onSearch);
    isOfflineMode = bool.parse(Get.parameters['isOfflineMode'] ?? 'false');
    if (isOfflineMode) {
      await _appService.initOfflineMode();
      projectList.value = _appService.projectList.value;
    } else {
      await fetchData();
    }
    initUpdateCheckList();
    // temp_change_directory();
    super.onInit();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  Rx<bool?> isSearchResultExist = Rx(null);

  onSearch() async {
    String keyword = searchController.text;
    if (isOfflineMode) {
      List<Project> all = _appService.projectList.value;
      if (keyword == '') {
        projectList.value = all;
      } else {
        projectList.value = all.where((element) => element.name?.contains(keyword) == true).toList();
      }
    } else {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      projectList.value = await _appService.getProjectList(q: keyword) ?? [];
      await EasyLoading.dismiss();
    }
    if (projectList.value.isNotEmpty) {
      isSearchResultExist.value = true;
    } else {
      isSearchResultExist.value = false;
    }
    searchFocusNode.unfocus();
    initUpdateCheckList();
  }

  Future fetchData() async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    projectList.value = await _appService.getProjectList() ?? [];
    // for (Project project in projectList.value) {
    //   await _appService.fetchMachineList(project_seq: project.seq!);
    //   _appService.reflectAllChangesInProject(project.seq!);
    // }

    await EasyLoading.dismiss();
  }

  initUpdateCheckList() {
    List<bool?> result = [];
    for (Project project in projectList.value) {
      result.add(_checkNeedUpdate(project));
    }
    needUpdateCheckList.value = result;
  }

  bool? _checkNeedUpdate(Project project) {
    bool? needUpdate;

    needUpdate = _localMachineDataService.getNewMachineInProject(project.seq!).isNotEmpty ||
        _localMachineDataService.getEditedMachineInProject(project.seq!).isNotEmpty ||
        _localMachineDataService.getDeletedMachineInProject(project.seq!).isNotEmpty ||
        _localGalleryDataService.getNewGalleryInProject(project.seq!).isNotEmpty ||
        _localGalleryDataService.getEditedGalleryInProject(project.seq!).isNotEmpty ||
        _localGalleryDataService.getDeletedGalleryInProject(project.seq!).isNotEmpty;
    if (project.app_submit_time == null && !needUpdate) {
      return null;
    }
    return needUpdate;
  }

  onTapProjectItem(String? seq) {
    if (seq == null) return;
    Get.toNamed(Routes.PROJECT_INFO, parameters: {'project_seq': seq})?.then((value) => initUpdateCheckList());
  }

  temp_change_directory() async {
    LocalGalleryDataService localGalleryDataService = Get.find<LocalGalleryDataService>();
    List<NewGalleryPicture> newGalleryList = localGalleryDataService.newGalleryList;
    for (NewGalleryPicture gallery in newGalleryList) {
      String? file_path = gallery.file_path;
      if (isFilePath(file_path)) {
        Project project = _appService.projectList.value.singleWhere((element) => element.seq == gallery.project_seq);
        Machine machine =
            _appService.machineList.value[project.seq]!.singleWhere((element) => element.mid == gallery.mid);
        File file = File(file_path!);

        Directory? rootDir = findRoot(await getExternalStorageDirectory());
        rootDir ??= await getApplicationDocumentsDirectory();
        Directory newDir =
            await Directory('${rootDir.path}/Pictures/Elim/${project.name ?? '현장명'}/${machine.name ?? '설비명'}')
                .create(recursive: true);

        String currentPath = pathWithoutName(file.path);
        bool needUpdate = currentPath != newDir.path;
        if (needUpdate) {
          await file.rename('${newDir.path}/${gallery.file_name}');
          _localGalleryDataService.updateNewGalleryWithNewFilePath(pid: gallery.pid, new_file_path: file.path);
        }
      }
    }
  }
}

// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equip_check_client/app/data/models/deleted_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/deleted_machine.dart';
import 'package:equip_check_client/app/data/models/edited_gallery_item.dart';
import 'package:equip_check_client/app/data/models/edited_machine.dart';
import 'package:equip_check_client/app/data/models/new_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/new_machine.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:equip_check_client/app/modules/project_info/views/delete_dialog.dart';
import 'package:equip_check_client/app/routes/app_pages.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/utils/log.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ProjectInfoController extends GetxController {
  final AppService _appService;
  final LocalGalleryDataService _localGalleryDataService;
  final LocalMachineDataService _localMachineDataService;
  ProjectInfoController({
    required AppService appService,
    required LocalGalleryDataService localGalleryDataService,
    required LocalMachineDataService localMachineDataService,
  })  : _appService = appService,
        _localGalleryDataService = localGalleryDataService,
        _localMachineDataService = localMachineDataService;
  late String project_seq;
  late Rx<Project> project;
  @override
  onInit() {
    project_seq = Get.parameters['project_seq']!;
    initProject();
    initialCheck();
    super.onInit();
  }

  initProject() {
    project = Rx(_appService.projectList.value.singleWhere((element) => isSameSeq(element.seq, project_seq)));
    _appService.projectList.listen((p0) {
      Project updatedAppSubmitProject =
          _appService.projectList.value.singleWhere((element) => isSameSeq(element.seq, project_seq));
      project.value = updatedAppSubmitProject;
    });
  }

  Rx<List<NewMachine>> newMachineList = Rx([]);
  void checkNewMachine() {
    newMachineList.value = _localMachineDataService.getNewMachineInProject(project_seq);
  }

  Rx<List<EditedMachine>> editedMachineList = Rx([]);
  void checkEditedMachine() {
    editedMachineList.value = _localMachineDataService.getEditedMachineInProject(project_seq);
  }

  Rx<List<DeletedMachine>> deletedMachineList = Rx([]);
  void checkDeletedMachine() async {
    deletedMachineList.value = _localMachineDataService.getDeletedMachineInProject(project_seq);
  }

  Rx<List<NewGalleryPicture>> newGalleryList = Rx([]);
  void checkNewGallery() {
    newGalleryList.value = _localGalleryDataService.getNewGalleryInProject(project_seq);
  }

  Rx<List<NewGalleryPicture>> newGalleryWithUpdatedList = Rx([]);
  void checkNewGalleryWithUpdated() {
    newGalleryWithUpdatedList.value =
        _localGalleryDataService.getNewGalleryInProject(project_seq, onlyNotUpdated: false);
  }

  Rx<List<EditedGalleryItem>> editedGalleryList = Rx([]);
  void checkEditedGallery() {
    editedGalleryList.value = _localGalleryDataService.getEditedGalleryInProject(project_seq);
  }

  Rx<List<DeletedGalleryPicture>> deletedGalleryList = Rx([]);
  void checkDeletedGallery() {
    deletedGalleryList.value = _localGalleryDataService.getDeletedGalleryInProject(project_seq);
  }

  checkAll() {
    checkNewMachine();
    checkEditedMachine();
    checkDeletedMachine();
    checkNewGallery();
    checkNewGalleryWithUpdated();
    checkEditedGallery();
    checkDeletedGallery();
    String needUpdateCount = '\n' +
        'newMachineList:${newMachineList.value.length}' +
        '\n' +
        'editedMachineList:${editedMachineList.value.length}' +
        '\n' +
        'deletdMachineList:${deletedMachineList.value.length}' +
        '\n' +
        'newGalleryList:${newGalleryList.value.length}' +
        '\n' +
        'editedGalleryList:${editedGalleryList.value.length}' +
        '\n' +
        'deletedGalleryList:${deletedGalleryList.value.length}';
    logInfo(needUpdateCount, des: 'need update');
  }

  Rx<bool> get isActiveUpdateButton {
    bool result = newMachineList.value.isNotEmpty ||
        editedMachineList.value.isNotEmpty ||
        deletedMachineList.value.isNotEmpty ||
        newGalleryList.value.isNotEmpty ||
        editedGalleryList.value.isNotEmpty ||
        deletedGalleryList.value.isNotEmpty;
    return Rx(result);
  }

  Rx<bool> get isActiveDeleteLocalButton {
    bool result = newGalleryWithUpdatedList.value.isNotEmpty;
    return Rx(result);
  }

  initialCheck() async {
    try {
      checkAll();
    } catch (e) {
      Get.snackbar('init', e.toString());
    }
  }

  onTapMachineList() async {
    await EasyLoading.show();
    await _appService.fetchMachineList(project_seq: project.value.seq!);
    _appService.reflectAllChangesInProject(project.value.seq!);
    await EasyLoading.dismiss();

    Get.toNamed(Routes.MACHINE_LIST, parameters: {'project_seq': project.value.seq!})?.then((value) {
      checkAll();
    });
  }

  onTapDeleteLocalData() async {
    showDeleteDailog(
        notUpdatedGalleryCount: newGalleryList.value.length,
        onTapConfirm: () async {
          await EasyLoading.show();
          try {
            if (newGalleryWithUpdatedList.value.isNotEmpty) {
              for (NewGalleryPicture newGallery in newGalleryWithUpdatedList.value) {
                if (newGallery.file_path != null) {
                  File file = File(newGallery.file_path!);
                  try {
                    await file.delete(recursive: true);
                  } on FileSystemException catch (_) {
                    logWarning(_, des: 'seems photo already has been deleted');
                  }
                  await _localGalleryDataService.removeNewGallery(newGallery.seq!);
                  _appService.reflectGalleryChanges(newGallery.toGalleryItem(), isDeleting: true);
                }
              }
            }
          } catch (e) {
            logError(e, des: 'ProjectInfoController.onTapDeleteLocalData()');
          }
          checkAll();
          await EasyLoading.dismiss();
        });
  }

  onTapSendDataToServer() async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      return await EasyLoading.showInfo('인터넷이 사용 가능한 곳에서\n다시 시도해주세요');
    }

    int totalCount = newMachineList.value.length +
        editedMachineList.value.length +
        deletedMachineList.value.length +
        newGalleryList.value.length +
        editedGalleryList.value.length +
        deletedGalleryList.value.length;
    int currentCount = 0;
    await EasyLoading.showProgress(
      currentCount / totalCount,
      status: '서버 전송중...\n$currentCount/$totalCount',
      maskType: EasyLoadingMaskType.black,
    );
    int updatedNewMachineCount = await _appService.updateNewMachine(
      project_seq: project_seq,
      totalCount: totalCount,
      currentCount: currentCount,
    );
    if (updatedNewMachineCount >= 0) currentCount += updatedNewMachineCount;

    int updateNewGalleryCount = await _appService.updateNewGallery(
      project_seq: project_seq,
      totalCount: totalCount,
      currentCount: updatedNewMachineCount,
    );
    if (updateNewGalleryCount >= 0) currentCount += updateNewGalleryCount;

    int updateEditedMachineCount = await _appService.updateEditedMachine(
      project_seq: project_seq,
      totalCount: totalCount,
      currentCount: updatedNewMachineCount,
    );
    if (updateEditedMachineCount >= 0) currentCount += updateEditedMachineCount;

    int updateEditedGallery = await _appService.updateEditedGallery(
      project_seq: project_seq,
      totalCount: totalCount,
      currentCount: updatedNewMachineCount,
    );
    if (updateEditedGallery >= 0) currentCount += updateEditedGallery;

    int updateDeletedGallery = await _appService.updateDeletedGallery(
      project_seq: project_seq,
      totalCount: totalCount,
      currentCount: updatedNewMachineCount,
    );
    if (updateDeletedGallery >= 0) currentCount += updateDeletedGallery;

    int updateDeletedMachineCount = await _appService.updateDeletedMachine(
      project_seq: project_seq,
      totalCount: totalCount,
      currentCount: updatedNewMachineCount,
    );
    if (updateDeletedMachineCount >= 0) currentCount += updateDeletedMachineCount;

    checkAll();
    await _appService.updateCompleted(project_seq);
    await EasyLoading.dismiss();
  }
}

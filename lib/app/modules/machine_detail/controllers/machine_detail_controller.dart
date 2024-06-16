// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:equip_check_client/app/data/models/check_list_item.dart';
import 'package:equip_check_client/app/data/models/deleted_gallery_picture.dart';
import 'package:equip_check_client/app/data/models/edited_gallery_item.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/machine_sub_cate_tree.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/models/edited_machine.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:equip_check_client/app/modules/machine_detail/views/check_list_item_dialog.dart';
import 'package:equip_check_client/app/routes/app_pages.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MachineDetailController extends GetxController {
  final AppService _appService;
  final LocalGalleryDataService _localGalleryDataService;
  final LocalMachineDataService _localMachineDataService;
  MachineDetailController({
    required AppService appService,
    required LocalGalleryDataService localGalleryDataService,
    required LocalMachineDataService localMachineDataService,
  })  : _appService = appService,
        _localGalleryDataService = localGalleryDataService,
        _localMachineDataService = localMachineDataService;

  late String mid;
  late String project_seq;
  late TextEditingController nameController;
  @override
  void onInit() {
    mid = Get.parameters['mid']!;
    project_seq = Get.parameters['project_seq']!;
    initMachineData();
    nameController = TextEditingController(text: machine.value?.name);
    nameController.addListener(() => editMachine(''));
    selectedSubCateName = Rx(initialSubCate?.name);
    selectedSubCateName.listen(editMachine);
    location = Rx(machine.value?.location ?? project.location_list?.firstOrNull);
    location.listen(editMachine);
    setup_date = Rx(machine.value?.setup_date);
    setup_date.listen(editMachine);
    check_date = Rx(machine.value?.check_date);
    check_date.listen(editMachine);
    pageController = PageController(initialPage: 1);
    pageController.addListener(pageControllerListener);

    super.onInit();
  }

  @override
  dispose() {
    nameController.dispose();
    pageController.removeListener(pageControllerListener);
    pageController.dispose();
    super.dispose();
  }

  initMachineData() {
    machine =
        Rx(_appService.machineList.value[project_seq]!.singleWhereOrNull((element) => isSameSeq(element.mid, mid)));
    _appService.machineList.listen((p0) {
      machine.update((val) {
        val = _appService.machineList.value[project_seq]!.singleWhereOrNull((element) => isSameSeq(element.mid, mid));
      });

      loadCheckListData(true);
    });
    loadCheckListData(false);
  }

  editMachine(String? p0) async {
    EditedMachine editedMachine = EditedMachine(
      user_seq: _appService.user.seq,
      machine_seq: machine.value?.seq,
      cate_seq: getCateSeq(),
      location: location.value,
      setup_date: setup_date.value,
      check_date: check_date.value,
      project_seq: project_seq,
      name: nameController.text,
      mid: machine.value!.mid,
    );
    await _localMachineDataService.addEditedMachine(editedMachine);
    _appService.reflectMachineChanges(editedMachine.toMachine());
  }

  String getCateSeq() {
    String result = _appService.machine_cate_tree
            .singleWhereOrNull((element) => isSameSeq(element.seq, machine.value?.parent_cate_seq))
            ?.sub_cate
            ?.singleWhereOrNull((element) => element.name == selectedSubCateName.value)
            ?.seq ??
        machine.value!.cate_seq!;
    return result;
  }

  loadCheckListData(bool isReload) {
    checkListItemNameList.value = checkList?.map((e) {
      return '${e?.name}';
    }).toList();
    checkListItemCountList.value = checkList?.map((e) {
      int count =
          (machine.value?.gallery?.where((element) => isSameSeq(element.check_seq, e?.seq)).toList().length ?? 0);
      return count;
    }).toList();
    int totalCount = checkListItemCountList.value?.fold(0, (sum, item) => (sum ?? 0) + (item ?? 0)) ?? 0;
    checkListItemNameList.value?.insert(0, '전체');
    checkListItemCountList.value?.insert(0, totalCount);

    if (!isReload) selectedCheckListItemName = Rx(checkListItemNameList.value?.first);
  }

  Project get project => _appService.projectList.value.singleWhere((element) => isSameSeq(element.seq, project_seq));
  late Rx<String?> location;
  late Rx<Machine?> machine;

  Future editGalleryItem({
    required String? gallery_seq,
    required String? title,
    required String? value,
    required String check_seq,
    required String? cate_seq,
    required String pid,
  }) async {
    EditedGalleryItem editedGallery = EditedGalleryItem(
      picture_seq: gallery_seq,
      title: title,
      value: value,
      check_seq: check_seq,
      cate_seq: cate_seq,
      machine_seq: machine.value?.seq,
      project_seq: project_seq,
      mid: machine.value!.mid,
      pid: pid,
    );
    await _localGalleryDataService.addEditedGallery(editedGallery);
    _appService.reflectGalleryChanges(editedGallery.toGalleryItem());
  }

  late Rx<String?> setup_date;
  late Rx<String?> check_date;

  List<MachineSubCateTree?>? get subCateList => (_appService.machine_cate_tree
          .singleWhereOrNull((element) => isSameSeq(element.seq, machine.value?.parent_cate_seq))
          ?.sub_cate)
      ?.map((e) => e)
      .toList();

  List<String?>? get subCateNameList => subCateList?.map((e) => e?.name).toList();
  late Rx<String?> selectedSubCateName;

  MachineSubCateTree? get initialSubCate {
    return subCateList?.singleWhereOrNull((element) => isSameSeq(element?.seq, machine.value?.cate_seq));
  }

  List<CheckListItem?>? get checkList => _appService.machine_cate_list
      .firstWhereOrNull((element) => isSameSeq(element.seq, machine.value?.cate_seq))
      ?.check_list;
  late Rx<String?> selectedCheckListItemName;
  Rx<List<String?>?> checkListItemNameList = Rx([]);
  Rx<List<int?>?> checkListItemCountList = Rx([]);

  CheckListItem? getCheckListItemByName(String? name) {
    return checkList?.singleWhereOrNull((element) => element?.name == name);
  }

  CheckListItem? getCheckListItemBySeq(String? check_seq) {
    return checkList?.singleWhereOrNull((element) => isSameSeq(element?.seq, check_seq));
  }

  List<GalleryItem?>? get filteredGalleryBySelecteCheckList {
    String? removedCount = selectedCheckListItemName.value?.split(' [').first;
    if (removedCount == '전체') {
      return machine.value?.gallery;
    }
    String selectedCheckSeq = getCheckListItemByName(removedCount)?.seq;
    return machine.value?.gallery?.where((element) => isSameSeq(element.check_seq, selectedCheckSeq)).toList();
  }

  onTapCheckListItem({
    required String? currentCheckListName,
    required GalleryItem galleryItem,
  }) {
    showCheckListItemDialog(
      currentCheckListName: currentCheckListName,
      onTapDelete: () async {
        await _localGalleryDataService.addDeletedGallery(
          DeletedGalleryPicture(
            seq: galleryItem.seq,
            project_seq: project_seq,
            machine_seq: machine.value?.seq,
            mid: galleryItem.mid,
            pid: galleryItem.pid,
          ),
        );
        _appService.reflectGalleryChanges(galleryItem, isDeleting: true);
        loadCheckListData(true);
      },
      galleryItem: galleryItem,
    );
  }

  onTapTakePic() {
    Get.toNamed(
      Routes.TAKE_PIC,
      parameters: {
        'mid': mid,
        'project_seq': project_seq,
      },
    );
  }

  late PageController pageController;
  pageControllerListener() {
    if (pageController.page == 0) {
      goToPrevious();
    }
    if (pageController.page == 2) {
      goToNext();
    }
  }

  int get currentMachineIndex =>
      _appService.machineList.value[project_seq]!.indexWhere((element) => element.mid == mid);
  int get lastMachineIndex => _appService.machineList.value[project_seq]!.length - 1;
  goToPrevious() {
    if (currentMachineIndex != 0) {
      String toGoMachineMid = _appService.machineList.value[project_seq]![currentMachineIndex - 1].mid;
      Get.offNamed(
        Routes.MACHINE_DETAIL,
        parameters: {
          'mid': toGoMachineMid,
          'project_seq': project_seq,
        },
      );
    } else {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  goToNext() {
    if (currentMachineIndex != lastMachineIndex) {
      String toGoMachineSeq = _appService.machineList.value[project_seq]![currentMachineIndex + 1].mid;
      Get.offNamed(
        Routes.MACHINE_DETAIL,
        parameters: {
          'mid': toGoMachineSeq,
          'project_seq': project_seq,
        },
      );
    } else {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }
}

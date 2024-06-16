// ignore_for_file: must_be_immutable

import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/models/check_list_item.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/picture_cate_item.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/modules/machine_detail/controllers/machine_detail_controller.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/widgets/custom_dialog.dart';
import 'package:equip_check_client/app/widgets/custom_dropdown_button.dart';
import 'package:equip_check_client/app/widgets/photo_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

showCheckListItemDialog({
  required void Function()? onTapDelete,
  required String? currentCheckListName,
  required GalleryItem? galleryItem,
}) {
  Get.to(
    () => CheckListItemDialog(
      onTapDelete: onTapDelete,
      currentCheckListName: currentCheckListName,
      galleryItem: galleryItem,
    ),
  );
}

class CheckListItemDialog extends StatefulWidget {
  final void Function()? onTapDelete;
  final String? currentCheckListName;
  GalleryItem? galleryItem;
  CheckListItemDialog({
    super.key,
    required this.onTapDelete,
    required this.currentCheckListName,
    required this.galleryItem,
  });

  @override
  State<CheckListItemDialog> createState() => _CheckListItemDialogState();
}

class _CheckListItemDialogState extends State<CheckListItemDialog> {
  late TextEditingController titleController;
  late TextEditingController valueController;

  late String? initialTitle;
  late String? initialValue;
  late String initialCheckListSeq;
  late String? initialPictureCateSeq;

  late MachineDetailController controller;
  late List<String?>? checkListNames;
  late List<int?>? checkListCounts;
  late Rx<String?>? selectedCheckListName;

  late CheckListItem? selecteCheckListItem;
  late List<String?>? pictureCateNames;
  late Rx<String?>? selectedPictureCateName;
  late Rx<PictureCateItem?> selectedPictureCateItem;

  late List<String> unitList;
  late Rx<String?> selectedUnit;

  List<int?>? get pictureCateCountList {
    List<int?>? countList = [];
    if (selecteCheckListItem?.picture_cate_list != null) {
      for (PictureCateItem? pictureCateItem in selecteCheckListItem!.picture_cate_list!) {
        List? gallery = controller.machine.value?.gallery
            ?.where((element) =>
                isSameSeq(element.cate_seq, pictureCateItem?.seq) &&
                isSameSeq(element.check_seq, selecteCheckListItem?.seq))
            .toList();
        int? count = gallery?.length;
        countList.add(count);
      }
    }
    return countList;
  }

  unitSelection() {
    if (selectedUnit.value != '단위') {
      String currentValue = valueController.text;
      String? foundString;
      int? foundIndex;

      for (String searchString in unitList) {
        if (currentValue.contains(searchString)) {
          if (foundString == null || foundString.length < searchString.length) {
            foundString = searchString;
            foundIndex = currentValue.indexOf(searchString);
          }
        }
      }

      if (foundString != null && foundIndex != null && selectedUnit.value != null) {
        valueController.text = '${currentValue.substring(0, foundIndex).trim()} ${selectedUnit.value!}';
      } else {
        valueController.text = selectedUnit.value ?? '';
      }
      selectedUnit.value = '단위';
    }
  }

  @override
  void initState() {
    controller = Get.find<MachineDetailController>();
    unitList = Get.find<AppService>().unit_list.toList();
    unitList.insert(0, '단위');
    selectedUnit = Rx(unitList.first);
    selectedUnit.listen((p0) {
      unitSelection();
    });

    initialTitle = widget.galleryItem?.title;
    initialValue = widget.galleryItem?.value ?? widget.galleryItem?.data;
    titleController = TextEditingController(text: initialTitle);
    valueController = TextEditingController(text: initialValue);

    checkListNames = controller.checkListItemNameList.value;
    checkListCounts = controller.checkListItemCountList.value;

    selectedCheckListName = Rx(widget.currentCheckListName);
    selectedCheckListName?.listen((p0) {
      changedCheckList = true;
      selectedUnit.value = unitList.first;
    });
    selecteCheckListItem = controller.checkList?.firstWhereOrNull((e) => e?.name == selectedCheckListName?.value);
    initialCheckListSeq = selecteCheckListItem?.seq;

    pictureCateNames = selecteCheckListItem?.picture_cate_list?.map((e) => e?.name).toList();
    selectedPictureCateItem = Rx(selecteCheckListItem?.picture_cate_list
        ?.firstWhereOrNull((e) => isSameSeq(e?.seq, widget.galleryItem?.cate_seq)));
    selectedPictureCateItem.listen((p0) {
      valueController.text = selectedPictureCateItem.value?.data ?? '';
    });
    initialPictureCateSeq = selectedPictureCateItem.value?.seq;
    selectedPictureCateName = Rx(selectedPictureCateItem.value?.name);
    selectedPictureCateName?.listen((p0) {
      changedCheckList = false;
      selectedPictureCateItem.value = selecteCheckListItem?.picture_cate_list
          ?.firstWhereOrNull((e) => isSameSeq(e?.name, selectedPictureCateName?.value));
      selectedUnit.value = unitList.first;
    });
    super.initState();
  }

  bool isInitialBuild = false;
  bool changedCheckList = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.galleryItem?.file_name?.split('.').first ?? ''),
        actions: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.size.height - kToolbarHeight * 2,
          alignment: Alignment.center,
          child: Obx(
            () {
              selecteCheckListItem =
                  controller.checkList?.firstWhereOrNull((e) => e?.name == selectedCheckListName?.value);

              pictureCateNames = selecteCheckListItem?.picture_cate_list?.map((e) => e?.name).toList();

              if (isInitialBuild) {
                isInitialBuild = true;
              } else {
                if (changedCheckList) selectedPictureCateName?.value = pictureCateNames?.first;
              }
              return Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => Scaffold(
                                    appBar: AppBar(
                                      automaticallyImplyLeading: false,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      centerTitle: true,
                                      title: Obx(
                                        () => Text(
                                          selectedPictureCateName?.value ?? selectedCheckListName?.value ?? '',
                                        ),
                                      ),
                                      actions: [
                                        IconButton(
                                          onPressed: Get.back,
                                          icon: const Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                    body: PhotoViewer(imagePath: widget.galleryItem?.file_path),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: Get.size.width * 0.6,
                                  color: AppColors.gray,
                                  child: PhotoViewer(imagePath: widget.galleryItem?.file_path),
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomDropdownButton(
                                list: checkListNames,
                                countList: checkListCounts,
                                selectedValue: selectedCheckListName!,
                                isOutlined: true,
                                borderRadius: 6,
                              ),
                              const SizedBox(height: 8),
                              CustomDropdownButton(
                                list: pictureCateNames,
                                countList: pictureCateCountList,
                                selectedValue: selectedPictureCateName!,
                                defaultValue: '-',
                                isOutlined: true,
                                borderRadius: 8,
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: '대체타이틀',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: TextField(
                                      controller: valueController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: '측정값',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            width: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            width: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    flex: 3,
                                    child: CustomDropdownButton(
                                      list: unitList,
                                      selectedValue: selectedUnit,
                                      isOutlined: false,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  Get.dialog(
                    CustomDialog(
                      title: '삭제',
                      onTapConfirm: () {
                        Get.back();
                        widget.onTapDelete!();
                        EasyLoading.showInfo('삭제되었습니다');
                      },
                      child: const Text('정말로 삭제하시겠어요?'),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.red.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text(
                  '삭제',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: () async {
                  String newTitle = titleController.text;
                  bool isEditedTitle = newTitle != initialTitle || (initialTitle == null && newTitle == '');

                  String newValue = valueController.text;
                  bool isEditedValue = newValue != initialValue || (initialValue == null && newValue == '');

                  String? newCheckListSeq = selecteCheckListItem?.seq;
                  bool isEditedCheckListSeq = newCheckListSeq != initialCheckListSeq;

                  String? newPictureCateSeq = selectedPictureCateItem.value?.seq;
                  bool isEditedPictureCateSeq = newPictureCateSeq != initialPictureCateSeq;

                  if (isEditedTitle || isEditedValue || isEditedCheckListSeq || isEditedPictureCateSeq) {
                    await controller.editGalleryItem(
                      gallery_seq: widget.galleryItem!.seq,
                      title: newTitle,
                      value: newValue,
                      check_seq: newCheckListSeq!,
                      cate_seq: newPictureCateSeq,
                      pid: widget.galleryItem!.pid,
                    );
                    await EasyLoading.showInfo('수정되었습니다');
                  }
                  Get.back();
                },
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.green.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

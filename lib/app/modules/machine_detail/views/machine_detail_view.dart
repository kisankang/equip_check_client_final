import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/data/models/check_list_item.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/modules/machine_detail/views/check_list_item_view.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:equip_check_client/app/widgets/custom_date_picker_dialog.dart';
import 'package:equip_check_client/app/widgets/custom_dropdown_button.dart';
import 'package:equip_check_client/app/widgets/custom_dropdown_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/machine_detail_controller.dart';

class MachineDetailView extends GetView<MachineDetailController> {
  const MachineDetailView({Key? key}) : super(key: key);
  final List<String> location = const ['B3F 기계실', 'B4F 기계실', 'B5F 기계실'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        title: Text(
          controller.machine.value?.name ?? '-',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageController,
        children: [
          _renderPreviousPage(),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder.all(color: Colors.black, width: 1.5),
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(7),
                      },
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(color: Colors.white),
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                child: Text('설비명'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: controller.nameController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (controller.machine.value?.parent_cate_seq != null)
                          TableRow(
                            decoration: const BoxDecoration(color: Colors.white),
                            children: [
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                  child: Text('종류'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: CustomDropdownButton(
                                  list: controller.subCateNameList,
                                  selectedValue: controller.selectedSubCateName,
                                  defaultValue: controller.machine.value!.cate_gubun,
                                  isOutlined: false,
                                ),
                              ),
                            ],
                          ),
                        TableRow(
                          decoration: const BoxDecoration(color: Colors.white),
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                child: Text('위치'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: CustomDropdownMenu(
                                options: controller.project.location_list,
                                selectedOption: controller.location,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: const BoxDecoration(color: Colors.white),
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                child: Text('설치/제조일'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => showCustomDatePickerDialog(
                                title: '설치/제조일',
                                server_date: controller.setup_date,
                                needDay: false,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(
                                  () => Text(setupDateConverter(controller.setup_date.value)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: const BoxDecoration(color: Colors.white),
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                child: Text('점검일'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => showCustomDatePickerDialog(
                                title: '점검일',
                                server_date: controller.check_date,
                                needDay: true,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() => Text(controller.check_date.value ?? DateTime.now().toYYYYMMDD())),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: FilledButton(
                  //         onPressed: controller.onTapPrevious(),
                  //         style: FilledButton.styleFrom(
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             disabledBackgroundColor: AppColors.gray,
                  //             backgroundColor: AppColors.blue,
                  //             padding: const EdgeInsets.symmetric(vertical: 16)),
                  //         child: const Text(
                  //           '이전 설비',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 16),
                  //     Expanded(
                  //       child: FilledButton(
                  //         onPressed: controller.onTapNext(),
                  //         style: FilledButton.styleFrom(
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             disabledBackgroundColor: AppColors.gray,
                  //             backgroundColor: AppColors.blue,
                  //             padding: const EdgeInsets.symmetric(vertical: 16)),
                  //         child: const Text(
                  //           '다음 설비',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Obx(() => CustomDropdownButton(
                              list: controller.checkListItemNameList.value,
                              selectedValue: controller.selectedCheckListItemName,
                              countList: controller.checkListItemCountList.value,
                              isOutlined: true,
                              borderRadius: 6,
                            )),
                        const SizedBox(height: 18),
                        Obx(() {
                          List<GalleryItem?>? filteredGalleryBySelecteCheckList;
                          Machine? machine = controller.machine.value;
                          String? selectedCheckListItemName = controller.selectedCheckListItemName.value;
                          if (selectedCheckListItemName == '전체') {
                            filteredGalleryBySelecteCheckList = machine?.gallery;
                          } else {
                            String selectedCheckSeq = controller.getCheckListItemByName(selectedCheckListItemName)?.seq;
                            filteredGalleryBySelecteCheckList = machine?.gallery
                                ?.where((element) => isSameSeq(element.check_seq, selectedCheckSeq))
                                .toList();
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: controller.filteredGalleryBySelecteCheckList?.length ?? 0,
                            itemBuilder: (context, index) {
                              GalleryItem? galleryItem = filteredGalleryBySelecteCheckList?[index];
                              CheckListItem? checkListItem = controller.getCheckListItemBySeq(galleryItem?.check_seq);
                              String? imageUrl = galleryItem?.thumb ?? galleryItem?.file_path;
                              String? title = checkListItem?.name;
                              String? subtitle = checkListItem?.picture_cate_list
                                  ?.firstWhereOrNull((element) => isSameSeq(element?.seq, galleryItem?.cate_seq))
                                  ?.name;
                              return CheckListItemView(
                                onTap: () => controller.onTapCheckListItem(
                                  currentCheckListName: checkListItem?.name,
                                  galleryItem: galleryItem!,
                                ),
                                imageUrl: imageUrl,
                                title: title,
                                subtitle: subtitle,
                              );
                            },
                          );
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          _renderNextPage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: controller.onTapTakePic,
            style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: AppColors.blue,
                padding: const EdgeInsets.symmetric(vertical: 18)),
            child: const Text(
              '사진 촬영',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _renderPreviousPage() {
    if (controller.currentMachineIndex == 0) {
      return const Center(child: Text('더이상 없습니다'));
    } else {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 10),
            Text('이전 설비로 이동'),
          ],
        ),
      );
    }
  }

  _renderNextPage() {
    if (controller.currentMachineIndex == controller.lastMachineIndex) {
      return const Center(child: Text('더이상 없습니다'));
    } else {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 10),
            Text('다음 설비로 이동'),
          ],
        ),
      );
    }
  }
}

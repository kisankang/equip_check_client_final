// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:equip_check_client/app/data/models/machine_cate_tree.dart';
import 'package:equip_check_client/app/data/models/machine_sub_cate_tree.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/widgets/custom_dialog.dart';
import 'package:equip_check_client/app/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAddMachineDialog({
  required void Function({
    required String project_seq,
    required String cate1,
    required String? cate2,
    required int qty,
  }) onTapConfirm,
  required String project_seq,
}) {
  Get.dialog(
    AddMachineDialog(
      onTapConfirm: onTapConfirm,
      project_seq: project_seq,
    ),
    barrierColor: Colors.transparent,
  );
}

class AddMachineDialog extends StatelessWidget {
  final void Function({
    required String project_seq,
    required String cate1,
    required String? cate2,
    required int qty,
  }) onTapConfirm;

  final String project_seq;
  const AddMachineDialog({
    super.key,
    required this.onTapConfirm,
    required this.project_seq,
  });

  @override
  Widget build(BuildContext context) {
    AppService appService = Get.find<AppService>();
    List<String> machineCateTree = appService.machine_cate_tree.map((e) => e.name).toList();
    Rx<String> selectedMachineCateTree = Rx(machineCateTree.first);

    return Obx(
      () {
        MachineCateTree? machinCateTreeItem =
            appService.machine_cate_tree.singleWhereOrNull((element) => element.name == selectedMachineCateTree.value);

        List<String?>? subCateNameList = machinCateTreeItem?.sub_cate?.map((e) => e.name).toList();
        Rx<String?> selectedSubCateName = Rx(subCateNameList?.firstOrNull);

        return Obx(() {
          Rx<MachineSubCateTree?> selectedSubCate = Rx(
              machinCateTreeItem?.sub_cate?.firstWhereOrNull((element) => element.name == selectedSubCateName.value));

          List<String> count = List.generate(200, (index) => (index + 1).toString());
          Rx<String> selectedCount = Rx(count.first);

          return CustomDialog(
            title: '설비추가',
            onTapConfirm: () => onTapConfirm(
              project_seq: project_seq,
              cate1: machinCateTreeItem!.seq,
              cate2: selectedSubCate.value?.seq,
              qty: int.parse(selectedCount.value),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropdownButton(
                  list: machineCateTree,
                  selectedValue: selectedMachineCateTree,
                  isOutlined: true,
                ),
                const SizedBox(height: 8),
                CustomDropdownButton(
                  list: subCateNameList,
                  selectedValue: selectedSubCateName,
                  defaultValue: selectedMachineCateTree.value,
                  isOutlined: true,
                ),
                const SizedBox(height: 8),
                CustomDropdownButton(
                  list: count,
                  selectedValue: selectedCount,
                  isOutlined: true,
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

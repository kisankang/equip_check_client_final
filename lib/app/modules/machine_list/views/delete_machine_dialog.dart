// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showdeleteMachineDialog({
  required void Function() onTapConfirm,
}) {
  Get.dialog(
    AddMachineDialog(
      onTapConfirm: onTapConfirm,
    ),
    barrierColor: Colors.transparent,
  );
}

class AddMachineDialog extends StatelessWidget {
  final void Function() onTapConfirm;

  const AddMachineDialog({
    super.key,
    required this.onTapConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '설비추가',
      onTapConfirm: () => onTapConfirm(),
      child: const Text('해당 설비를 삭제하시겠습니까?'),
    );
  }
}

import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showStartCheckingDialog({required void Function() onTapConfirm}) {
  Get.dialog(
    StartCheckingDialog(onTapConfirm: onTapConfirm),
    barrierColor: Colors.transparent,
  );
}

class StartCheckingDialog extends StatelessWidget {
  final void Function() onTapConfirm;
  const StartCheckingDialog({
    super.key,
    required this.onTapConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '확인',
      onTapConfirm: onTapConfirm,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '점검을 시작 하시겠어요?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '변경된 설비가 있을 경우 설비목록에서 추가 또는 삭제할 수 있습니다.',
            style: TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

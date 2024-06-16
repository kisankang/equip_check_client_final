import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:equip_check_client/app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showDeleteDailog({
  required void Function() onTapConfirm,
  required int notUpdatedGalleryCount,
}) {
  Get.dialog(
    DeleteDialog(onTapConfirm: onTapConfirm, notUpdatedGalleryCount: notUpdatedGalleryCount),
    barrierColor: Colors.transparent,
  );
}

class DeleteDialog extends StatelessWidget {
  final void Function() onTapConfirm;
  final int notUpdatedGalleryCount;
  const DeleteDialog({
    super.key,
    required this.onTapConfirm,
    required this.notUpdatedGalleryCount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '삭제',
      onTapConfirm: onTapConfirm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '정말 삭제하시겠어요?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (notUpdatedGalleryCount > 0)
            Text(
              '아직 $notUpdatedGalleryCount개의 사진이 서버로 전송되지 않았습니다',
              style: const TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}

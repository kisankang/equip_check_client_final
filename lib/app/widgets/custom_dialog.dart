import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final void Function() onTapConfirm;
  final void Function()? onTapDelete;
  final Widget child;
  final bool removeShadow;
  const CustomDialog({
    super.key,
    required this.title,
    required this.onTapConfirm,
    this.onTapDelete,
    required this.child,
    this.removeShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            if (!removeShadow)
              const BoxShadow(
                color: Colors.black,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  color: AppColors.gray,
                ),
              ],
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: Get.back,
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (onTapDelete != null)
                    TextButton(
                      onPressed: () {
                        Get.dialog(
                          CustomDialog(
                            title: '삭제',
                            onTapConfirm: () {
                              Get.back();
                              onTapDelete!();
                              EasyLoading.showInfo('삭제되었습니다');
                            },
                            child: Text('정말로 삭제하시겠어요?'),
                          ),
                        );
                      },
                      child: const Text(
                        '삭제',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      onTapConfirm();
                    },
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

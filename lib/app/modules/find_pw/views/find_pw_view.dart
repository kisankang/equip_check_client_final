import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/find_pw_controller.dart';

class FindPwView extends GetView<FindPwController> {
  const FindPwView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '비밀번호 찾기',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: Get.back,
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.gray,
              height: 1.0,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '이메일 주소를 입력하세요.\n비밀번호 재설정을 위한 이메일을 보내드리겠습니다.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 36),
            const Text(
              '이메일',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.emailController,
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => FilledButton(
                  onPressed: controller.isActiveButton.value ? controller.onTapConfirm : null,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.blue,
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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

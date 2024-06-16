import 'package:equip_check_client/app/constant/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: Get.size.height * 0.5,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(52),
                  bottomRight: Radius.circular(52),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Text(
              '기계설비\n성능점검',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Text(
              '엘림주식회사',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      hintText: '이메일',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColors.gray,
                      )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.isObscureText.value,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.isObscureText.toggle();
                            },
                            icon: Icon(
                              controller.isObscureText.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            )),
                        hintText: '비밀번호',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: AppColors.gray,
                        )),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.rememberPW.value,
                          onChanged: controller.onTapSavePwCheckBox,
                        ),
                      ),
                      const Text(
                        '아이디/비밀번호 기억하기',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () {
                      String? errorMsg = controller.errorText.value;
                      return errorMsg != null
                          ? Text(
                              errorMsg,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox(height: 8);
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: controller.onTapSignIn,
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: controller.onTapFindPw,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

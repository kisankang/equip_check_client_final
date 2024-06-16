import 'package:equip_check_client/app/data/models/user.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_app_data_service.dart';
import 'package:equip_check_client/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AppService _appService;
  final LocalAppDataService _localAppDataService;

  SignInController({
    required AppService appService,
    required LocalAppDataService localAppDataService,
  })  : _appService = appService,
        _localAppDataService = localAppDataService;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  Rx<bool> isObscureText = Rx(true);
  late Rx<bool> rememberPW;

  void onTapSavePwCheckBox(bool? v) {
    if (v != null) rememberPW.value = v;
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rememberPW = Rx(_localAppDataService.getUserPw != null);
    if (rememberPW.value) {
      User? savedUser = _localAppDataService.getLastLoggedInUser();
      String? savedPw = _localAppDataService.getUserPw;
      if (savedUser != null && savedPw != null) {
        emailController.text = savedUser.email;
        passwordController.text = savedPw;
      }
    }

    super.onInit();
  }

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Rx<String?> errorText = Rx(null);

  onTapSignIn() async {
    await EasyLoading.show();
    String? errorMsg = await _appService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    if (errorMsg != null) {
      errorText.value = errorMsg;
    } else {
      if (rememberPW.value) {
        _localAppDataService.saveUserPw(passwordController.text);
      } else {
        _localAppDataService.saveUserPw(null);
      }
      Get.offAllNamed(Routes.PROJECT_LIST);
    }
    await EasyLoading.dismiss();
  }

  onTapFindPw() {
    Get.toNamed(Routes.FIND_PW);
  }
}

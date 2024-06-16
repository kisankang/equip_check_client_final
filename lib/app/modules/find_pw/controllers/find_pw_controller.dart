import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/utils/log.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FindPwController extends GetxController {
  final AppService _appService;
  FindPwController({required AppService appService}) : _appService = appService;

  late TextEditingController emailController;
  Rx<bool> isActiveButton = Rx(false);
  @override
  void onInit() {
    emailController = TextEditingController();
    emailController.addListener(() {
      if (emailController.text != '') {
        isActiveButton.value = true;
      } else {
        isActiveButton.value = false;
      }
    });
    super.onInit();
  }

  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }

  onTapConfirm() async {
    await EasyLoading.show();
    String? result = await _appService.findPw(email: emailController.text);
    logInfo(result);
    await EasyLoading.dismiss();

    if (result == 'OK') {
      await EasyLoading.showInfo('이메일 발송 완료');
    } else {
      await EasyLoading.showError(result.toString());
    }
  }
}

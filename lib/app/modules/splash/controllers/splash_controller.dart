import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equip_check_client/app/data/models/base_response.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_app_data_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:equip_check_client/app/routes/app_pages.dart';
import 'package:equip_check_client/app/utils/helper.dart';
import 'package:equip_check_client/app/utils/log.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final AppService _appService;
  SplashController({required AppService appService}) : _appService = appService;

  Rx<bool> needUpdate = Rx(false);
  @override
  Future<void> onInit() async {
    await Permission.camera.request().then((value) async {
      if (await getAndroidSdkVersion() >= 33) {
        await Permission.manageExternalStorage.request().then((value) => null);
      } else {
        await Permission.storage.request().then((value) => null);
      }
    });

    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      await EasyLoading.show(status: 'offline 모드 실행 중...');
      Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
        if (Get.find<LocalAppDataService>().initialized &&
            Get.find<LocalMachineDataService>().initialized &&
            Get.find<LocalGalleryDataService>().initialized) {
          timer.cancel();
          FlutterNativeSplash.remove();
          await EasyLoading.dismiss();
          Get.offAllNamed(Routes.PROJECT_LIST, parameters: {'isOfflineMode': 'true'});
        }
      });
    } else {
      await EasyLoading.show();
      Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
        BaseResponse? response = await _appService.init();
        if (Platform.isAndroid) {
          String androidVersion = response?.data['android_version'];
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String version = packageInfo.version;
          if (androidVersion != version) {
            logError(version, des: 'need update to $androidVersion');
            needUpdate.value = true;
          } else {
            logSuccess(version, des: 'recent version');
          }
        } else {}

        if (needUpdate.value) {
          FlutterNativeSplash.remove();
          timer.cancel();
          await EasyLoading.dismiss();
        } else {
          if (Get.find<LocalAppDataService>().initialized &&
              Get.find<LocalMachineDataService>().initialized &&
              Get.find<LocalGalleryDataService>().initialized) {
            FlutterNativeSplash.remove();
            timer.cancel();
            await EasyLoading.dismiss();
            Get.offAllNamed(Routes.SIGN_IN);
          }
        }
      });
    }
    super.onInit();
  }
}

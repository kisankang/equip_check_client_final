import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(appService: Get.find<AppService>()),
    );
  }
}

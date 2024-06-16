import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_app_data_service.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(
        appService: Get.find<AppService>(),
        localAppDataService: Get.find<LocalAppDataService>(),
      ),
    );
  }
}

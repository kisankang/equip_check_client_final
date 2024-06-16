import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:get/get.dart';

import '../controllers/take_pic_controller.dart';

class TakePicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TakePicController>(
      () => TakePicController(
        appService: Get.find<AppService>(),
        localGalleryDataService: Get.find<LocalGalleryDataService>(),
      ),
    );
  }
}

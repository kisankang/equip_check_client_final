import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:get/get.dart';

import '../controllers/machine_detail_controller.dart';

class MachineDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MachineDetailController>(
      () => MachineDetailController(
        appService: Get.find<AppService>(),
        localGalleryDataService: Get.find<LocalGalleryDataService>(),
        localMachineDataService: Get.find<LocalMachineDataService>(),
      ),
    );
  }
}

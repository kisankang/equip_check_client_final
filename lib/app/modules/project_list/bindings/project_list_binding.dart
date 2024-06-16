import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_gallery_data_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:get/get.dart';

import '../controllers/project_list_controller.dart';

class ProjectListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectListController>(
      () => ProjectListController(
        appService: Get.find<AppService>(),
        localMachineDataService: Get.find<LocalMachineDataService>(),
        localGalleryDataService: Get.find<LocalGalleryDataService>(),
      ),
    );
  }
}

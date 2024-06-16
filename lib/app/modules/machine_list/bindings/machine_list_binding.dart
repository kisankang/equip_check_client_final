import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:get/get.dart';

import '../controllers/machine_list_controller.dart';

class MachineListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MachineListController>(
      MachineListController(
        appService: Get.find<AppService>(),
        localMachineDataService: Get.find<LocalMachineDataService>(),
      ),
    );
  }
}

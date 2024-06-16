// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/data/models/deleted_machine.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/new_machine.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/services/app_service.dart';
import 'package:equip_check_client/app/data/services/local_machine_data_service.dart';
import 'package:equip_check_client/app/modules/machine_list/views/add_machine_dialog.dart';
import 'package:equip_check_client/app/routes/app_pages.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MachineListController extends GetxController {
  final AppService _appService;
  final LocalMachineDataService _localMachineDataService;
  MachineListController({
    required AppService appService,
    required LocalMachineDataService localMachineDataService,
  })  : _appService = appService,
        _localMachineDataService = localMachineDataService;

  late String project_seq;
  Rx<Project?> project = Rx(null);
  List<Machine> get machine_list => _appService.machineList.value[project_seq] ?? [];
  @override
  void onInit() {
    project_seq = Get.parameters['project_seq']!;
    project.value = _appService.projectList.value.singleWhere((element) => isSameSeq(element.seq, project_seq));
    super.onInit();
  }

  onTapAddMachine() {
    showAddMachineDialog(onTapConfirm: onTapConfirmToAddMachine, project_seq: project_seq);
  }

  onTapConfirmToAddMachine({
    required String project_seq,
    required String cate1,
    required String? cate2,
    required int qty,
  }) async {
    await EasyLoading.show();
    for (var i = 0; i < qty; i++) {
      String? cate_seq_1;
      String? cate_seq_2;
      if (cate2 == null) {
        cate_seq_1 = null;
        cate_seq_2 = cate1;
      } else {
        cate_seq_1 = cate1;
        cate_seq_2 = cate2;
      }
      NewMachine newMachine = NewMachine(
        project_seq: project_seq,
        cate1: cate_seq_1,
        cate2: cate_seq_2,
        mid: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      await _localMachineDataService.addNewMachine(newMachine);
      _appService.reflectMachineChanges(newMachine.toMachine());
    }
    await EasyLoading.dismiss();
  }

  bool isDeletable(int index) {
    bool result = true;
    List<GalleryItem>? gallery = machine_list[index].gallery;
    if (gallery != null && gallery.isNotEmpty) {
      result = false;
    }
    return result;
  }

  onTapConfirmToDeleteMachine({
    required String? machine_seq,
    required String mid,
  }) async {
    await EasyLoading.show();
    DeletedMachine deletedMachine = DeletedMachine(
      seq: machine_seq,
      project_seq: project_seq,
      mid: mid,
    );
    await _localMachineDataService.addDeleteddMachine(deletedMachine);
    _appService.reflectMachineChanges(deletedMachine.toMachine(), isDeleting: true);
    await EasyLoading.dismiss();
  }

  onTapMachineItem(String mid) {
    Get.toNamed(Routes.MACHINE_DETAIL, parameters: {
      'mid': mid,
      'project_seq': project_seq,
    });
  }
}

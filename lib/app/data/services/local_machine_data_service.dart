// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:equip_check_client/app/data/models/deleted_machine.dart';
import 'package:equip_check_client/app/data/models/edited_machine.dart';
import 'package:equip_check_client/app/data/models/new_machine.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalMachineDataService extends GetxService {
  late Box<NewMachine> new_machine_box;
  late Box<EditedMachine> edited_machine_box;
  late Box<DeletedMachine> deleted_machine_box;

  @override
  Future<void> onInit() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NewMachineAdapter());
    new_machine_box = await Hive.openBox<NewMachine>('new_machine_box_1_0_3');

    Hive.registerAdapter(EditedMachineAdapter());
    edited_machine_box = await Hive.openBox<EditedMachine>('edited_machine_box_1_0_3');

    Hive.registerAdapter(DeletedMachineAdapter());
    deleted_machine_box = await Hive.openBox<DeletedMachine>('deleted_machine_box_1_0_3');

    // await new_machine_box.deleteFromDisk();
    // await edited_machine_box.deleteFromDisk();
    // await deleted_machine_box.deleteFromDisk();

    super.onInit();
  }

  List<NewMachine> get newMachineList => new_machine_box.values.cast<NewMachine>().toList();
  Future<void> addNewMachine(NewMachine newMachine) async => await new_machine_box.add(newMachine);
  List<NewMachine> getNewMachineInProject(String project_seq) =>
      newMachineList.where((element) => isSameSeq(element.project_seq, project_seq)).toList();
  Future<void> removeNewMachine(String mid) async =>
      await new_machine_box.deleteAt(newMachineList.indexWhere((element) => isSameSeq(element.mid, mid)));

  List<EditedMachine> get editedMachineList => edited_machine_box.values.cast<EditedMachine>().toList();
  Future<void> addEditedMachine(EditedMachine editedMachine) async {
    int index = editedMachineList.indexWhere((element) => isSameSeq(element.mid, editedMachine.mid));
    if (index != -1) {
      EditedMachine updatedEditedMachine = editedMachineList[index].copyWith(
        user_seq: editedMachine.user_seq,
        machine_seq: editedMachine.machine_seq,
        cate_seq: editedMachine.cate_seq,
        location: editedMachine.location,
        setup_date: editedMachine.setup_date,
        check_date: editedMachine.check_date,
        project_seq: editedMachine.project_seq,
        name: editedMachine.name,
        mid: editedMachine.mid,
      );
      await edited_machine_box.putAt(index, updatedEditedMachine);
    } else {
      await edited_machine_box.add(editedMachine);
    }
  }

  Future<void> updateEditedMachineWithNewSeq({
    required String mid,
    required String machine_seq,
  }) async {
    int index = editedMachineList.indexWhere((element) => isSameSeq(element.mid, mid));
    if (index != -1) {
      EditedMachine editedMachine = editedMachineList[index].copyWith(
        machine_seq: machine_seq,
        mid: editedMachineList[index].mid,
        user_seq: editedMachineList[index].user_seq,
        cate_seq: editedMachineList[index].cate_seq,
        project_seq: editedMachineList[index].project_seq,
      );
      await edited_machine_box.putAt(index, editedMachine);
    }
  }

  EditedMachine? getEditedMachine(String mid) =>
      editedMachineList.singleWhereOrNull((element) => isSameSeq(element.mid, mid));
  List<EditedMachine> getEditedMachineInProject(String project_seq) =>
      editedMachineList.where((element) => isSameSeq(element.project_seq, project_seq)).toList();
  Future<void> removeEditedMachine(String mid) async =>
      await edited_machine_box.deleteAt(editedMachineList.indexWhere((element) => isSameSeq(element.mid, mid)));

  List<DeletedMachine> get deletedMachineList => deleted_machine_box.values.cast<DeletedMachine>().toList();
  Future<void> addDeleteddMachine(DeletedMachine deletedMachine) async => deleted_machine_box.add(deletedMachine);
  Future<void> updateDeletedMachineWithNewSeq({
    required String mid,
    required String machine_seq,
  }) async {
    int index = deletedMachineList.indexWhere((element) => isSameSeq(element.mid, mid));
    if (index != -1) {
      DeletedMachine deletedMachine = deletedMachineList[index].copyWith(seq: machine_seq);
      await deleted_machine_box.putAt(index, deletedMachine);
    }
  }

  DeletedMachine? getDeletedMachine(String mid) =>
      deletedMachineList.singleWhereOrNull((element) => isSameSeq(element.mid, mid));
  List<DeletedMachine> getDeletedMachineInProject(String project_seq) =>
      deletedMachineList.where((element) => isSameSeq(element.project_seq, project_seq)).toList();
  Future<void> removeDeletedMachine(String mid) async =>
      await deleted_machine_box.deleteAt(deletedMachineList.indexWhere((element) => isSameSeq(element.mid, mid)));
}

// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/data/models/check_list_item.dart';
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:equip_check_client/app/data/models/machine_cate.dart';
import 'package:equip_check_client/app/data/models/machine_cate_tree.dart';
import 'package:equip_check_client/app/data/models/machine_sub_cate_tree.dart';
import 'package:equip_check_client/app/data/models/picture_cate_item.dart';
import 'package:equip_check_client/app/data/models/project.dart';
import 'package:equip_check_client/app/data/models/user.dart';
import 'package:equip_check_client/app/utils/converter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalAppDataService extends GetxService {
  late Box<User> user_box;
  late Box<String?> setting_box;
  late Box<List> template_box;
  late Box<List> project_box;
  late Box<Machine> machine_box;

  @override
  Future<void> onInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    user_box = await Hive.openBox('user_box_1_0_3');
    setting_box = await Hive.openBox<String?>('setting_box_1_0_3');

    Hive.registerAdapter(MachineCateTreeAdapter());
    Hive.registerAdapter(MachineSubCateTreeAdapter());
    Hive.registerAdapter(MachineCateAdapter());
    Hive.registerAdapter(CheckListItemAdapter());
    Hive.registerAdapter(PictureCateItemAdapter());
    Hive.registerAdapter(GalleryItemAdapter());
    template_box = await Hive.openBox('template_box_1_0_3');

    Hive.registerAdapter(ProjectAdapter());
    project_box = await Hive.openBox('project_box_1_0_3');

    Hive.registerAdapter(MachineAdapter());
    machine_box = await Hive.openBox('machine_box_1_0_3');

    super.onInit();
  }

  Future<void> writeLastUpdatedUser(User userData) async {
    await user_box.put('last_logged_in_user', userData);
  }

  User? getLastLoggedInUser() {
    return user_box.get('last_logged_in_user');
  }

  Future<void> saveUserPw(String? pw) async {
    await setting_box.put('saved_pw', pw);
  }

  String? get getUserPw {
    return setting_box.get('saved_pw');
  }

  Future<void> putMachineCateList(List<MachineCate> machine_cate_list) async {
    await template_box.put('machine_cate_list', machine_cate_list);
  }

  List<MachineCate>? getMachineCateList() {
    return template_box.get('machine_cate_list')?.cast<MachineCate>();
  }

  Future<void> putMachineCateTree(List<MachineCateTree> machine_cate_tree) async {
    await template_box.put('machine_cate_tree', machine_cate_tree);
  }

  List<MachineCateTree>? getMachineCateTree() {
    return template_box.get('machine_cate_tree')?.cast<MachineCateTree>();
  }

  Future<void> putUnitList(List<String> unit_list) async {
    await template_box.put('unit_list', unit_list);
  }

  List<String>? getUnitList() {
    return template_box.get('unit_list')?.cast<String>();
  }

  Future<void> putProject(Project prj) async {
    User? lastLoggedInUser = getLastLoggedInUser();
    List<Project> previousProjects = getLastLogginedUserProjects() ?? [];
    int? index = previousProjects.indexWhere((element) => isSameSeq(element.seq, prj.seq));
    if (index != -1) {
      previousProjects[index] = prj;
    } else {
      previousProjects.add(prj);
    }
    await project_box.put(lastLoggedInUser?.seq, previousProjects);
  }

  List<Project>? getLastLogginedUserProjects() {
    User? lastLoggedInUser = getLastLoggedInUser();
    String? user_seq = lastLoggedInUser?.seq;
    return project_box.get(user_seq)?.cast<Project>();
  }

  List<Machine> get machineList => machine_box.values.cast<Machine>().toList();

  Future<void> putMachine(Machine mch) async {
    await machine_box.put(mch.seq, mch);
  }

  Future<void> putMachines(List<Machine> machines) async {
    for (var element in machines) {
      await machine_box.put(element.seq, element);
    }
  }

  List<Machine>? getMachinesInProject(String project_seq) =>
      machineList.where((element) => isSameSeq(element.project_seq, project_seq)).toList();
}

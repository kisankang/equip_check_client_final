// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/data/models/machine_cate.dart';
import 'package:equip_check_client/app/data/models/machine_cate_tree.dart';
import 'package:equip_check_client/app/data/models/user.dart';

class SignInResponse {
  User? user;
  List<MachineCate>? machine_cate_list;
  List<MachineCateTree>? machine_cate_tree;
  List<String>? unit_List;
  SignInResponse({
    required this.user,
    required this.machine_cate_list,
    required this.machine_cate_tree,
    required this.unit_List,
  });
}

// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/machine_sub_cate_tree.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_cate_tree.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class MachineCateTree {
  @HiveField(0)
  String seq;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<MachineSubCateTree>? sub_cate;

  MachineCateTree({
    required this.seq,
    required this.name,
    required this.sub_cate,
  });

  factory MachineCateTree.fromJson(Map<String, dynamic> json) => _$MachineCateTreeFromJson(json);
  Map<String, dynamic> toJson() => _$MachineCateTreeToJson(this);
}

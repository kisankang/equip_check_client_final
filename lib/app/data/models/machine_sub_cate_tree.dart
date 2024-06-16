// ignore_for_file: non_constant_identifier_names
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_sub_cate_tree.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class MachineSubCateTree {
  @HiveField(0)
  String? seq;
  @HiveField(1)
  String? parent_seq;
  @HiveField(2)
  String? name;

  MachineSubCateTree({
    required this.seq,
    required this.parent_seq,
    required this.name,
  });
  factory MachineSubCateTree.fromJson(Map<String, dynamic> json) => _$MachineSubCateTreeFromJson(json);
  Map<String, dynamic> toJson() => _$MachineSubCateTreeToJson(this);
}

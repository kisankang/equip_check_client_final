// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/check_list_item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_cate.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class MachineCate {
  @HiveField(0)
  String seq;
  @HiveField(1)
  String name;
  @HiveField(2)
  List sub_cate;
  @HiveField(3)
  List<CheckListItem>? check_list;

  MachineCate({
    required this.seq,
    required this.name,
    required this.sub_cate,
    required this.check_list,
  });

  factory MachineCate.fromJson(Map<String, dynamic> json) => _$MachineCateFromJson(json);
  Map<String, dynamic> toJson() => _$MachineCateToJson(this);
}

// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_machine.g.dart';

@JsonSerializable()
@HiveType(typeId: 10)
class NewMachine {
  @HiveField(0)
  String project_seq;
  @HiveField(1)
  String? cate1;
  @HiveField(2)
  String? cate2;
  @HiveField(4)
  int qty = 1;
  @HiveField(5)
  String mid;

  NewMachine({
    required this.project_seq,
    required this.cate1,
    required this.cate2,
    required this.mid,
  });

  toMachine() => Machine(
        project_seq: project_seq,
        parent_cate_seq: cate1,
        cate_seq: cate2,
        mid: mid,
      );

  factory NewMachine.fromJson(Map<String, dynamic> json) => _$NewMachineFromJson(json);
  Map<String, dynamic> toJson() => _$NewMachineToJson(this);
}

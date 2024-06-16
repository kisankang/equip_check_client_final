// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deleted_machine.g.dart';

@JsonSerializable()
@HiveType(typeId: 11)
class DeletedMachine {
  @HiveField(0)
  String? seq;
  @HiveField(1)
  @JsonKey(includeToJson: false)
  String project_seq;

  @HiveField(2)
  String mid;

  DeletedMachine({
    required this.seq,
    required this.project_seq,
    required this.mid,
  });

  copyWith({
    String? seq,
    String? project_seq,
    String? mid,
  }) =>
      DeletedMachine(
        seq: seq ?? this.seq,
        project_seq: project_seq ?? this.project_seq,
        mid: mid ?? this.mid,
      );

  toMachine({String? new_seq}) => Machine(
        seq: new_seq ?? seq,
        project_seq: project_seq,
        mid: mid,
      );

  factory DeletedMachine.fromJson(Map<String, dynamic> json) => _$DeletedMachineFromJson(json);
  Map<String, dynamic> toJson() => _$DeletedMachineToJson(this);
}

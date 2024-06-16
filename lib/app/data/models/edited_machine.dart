// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/machine.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edited_machine.g.dart';

@JsonSerializable()
@HiveType(typeId: 8)
class EditedMachine {
  @HiveField(0)
  String user_seq;

  @HiveField(1)
  String? machine_seq;

  @HiveField(2)
  String cate_seq;

  @HiveField(3)
  String? location;

  @HiveField(4)
  String? setup_date;

  @HiveField(5)
  String? check_date;

  @HiveField(6)
  @JsonKey(includeToJson: false)
  String project_seq;

  @HiveField(7)
  String name;

  @HiveField(8)
  String mid;

  EditedMachine({
    required this.user_seq,
    required this.machine_seq,
    required this.cate_seq,
    required this.location,
    required this.setup_date,
    required this.check_date,
    required this.project_seq,
    required this.name,
    required this.mid,
  });

  copyWith({
    required String user_seq,
    String? machine_seq,
    required String cate_seq,
    String? location,
    String? setup_date,
    String? check_date,
    required String project_seq,
    String? name,
    String? mid,
  }) =>
      EditedMachine(
        user_seq: user_seq,
        machine_seq: machine_seq,
        cate_seq: cate_seq,
        location: location ?? this.location,
        setup_date: setup_date ?? this.setup_date,
        check_date: check_date ?? this.check_date,
        project_seq: project_seq,
        name: name ?? this.name,
        mid: mid ?? this.mid,
      );

  Machine toMachine({String? new_seq}) => Machine(
        seq: new_seq ?? machine_seq,
        project_seq: project_seq,
        cate_seq: cate_seq,
        location: location,
        check_date: check_date,
        setup_date: setup_date,
        name: name,
        mid: mid,
      );

  factory EditedMachine.fromJson(Map<String, dynamic> json) => _$EditedMachineFromJson(json);
  Map<String, dynamic> toJson() => _$EditedMachineToJson(this);
}

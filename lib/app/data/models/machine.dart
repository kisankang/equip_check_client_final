// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Machine {
  @HiveField(0)
  dynamic seq;
  @HiveField(1)
  String? cate_seq;
  @HiveField(2)
  String? engineer1_seq;
  @HiveField(3)
  String? engineer2_seq;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? no;
  @HiveField(6)
  String? purpose;
  @HiveField(7)
  String? location;
  @HiveField(8)
  String? check_date;
  @HiveField(9)
  String? setup_date;
  @HiveField(10)
  String? setup_date_type;
  @HiveField(11)
  String? deficiencies;
  @HiveField(12)
  String? action_require;
  @HiveField(13)
  String? remark;
  @HiveField(14)
  dynamic values;
  @HiveField(15)
  String? reg_time;
  @HiveField(16)
  String? project_name;
  @HiveField(17)
  String? license_name;
  @HiveField(18)
  String? project_bgnDt;
  @HiveField(19)
  String? project_fieldBgnDt;
  @HiveField(20)
  String? cate_name;
  @HiveField(21)
  String? cate_gubun;
  @HiveField(22)
  String? cate_system_name;
  @HiveField(23)
  String? check_rate;
  @HiveField(24)
  String? endurance1;
  @HiveField(25)
  String? endurance2;
  @HiveField(26)
  String? parent_cate_name;
  @HiveField(27)
  String? parent_cate_seq;
  @HiveField(28)
  String? machine_cate_seq;
  @HiveField(29)
  String? engineer1_name;
  @HiveField(30)
  String? engineer1_email;
  @HiveField(31)
  String? engineer2_name;
  @HiveField(32)
  String? engineer2_email;
  @HiveField(33)
  String? engineer1_position;
  @HiveField(34)
  String? engineer2_position;
  @HiveField(35)
  String? picture_cnt;
  @HiveField(36)
  String? nocate_picture_cnt;
  @HiveField(37)
  List<GalleryItem>? gallery;
  @HiveField(38)
  String? picture;

  @HiveField(39)
  String? project_seq;
  @HiveField(40)
  String mid;

  Machine({
    this.seq,
    this.cate_seq,
    this.engineer1_seq,
    this.engineer2_seq,
    this.name,
    this.no,
    this.purpose,
    this.location,
    this.check_date,
    this.setup_date,
    this.setup_date_type,
    this.deficiencies,
    this.action_require,
    this.remark,
    this.values,
    this.reg_time,
    this.project_name,
    this.license_name,
    this.project_bgnDt,
    this.project_fieldBgnDt,
    this.cate_name,
    this.cate_gubun,
    this.cate_system_name,
    this.check_rate,
    this.endurance1,
    this.endurance2,
    this.parent_cate_name,
    this.parent_cate_seq,
    this.machine_cate_seq,
    this.engineer1_name,
    this.engineer1_email,
    this.engineer2_name,
    this.engineer2_email,
    this.engineer1_position,
    this.engineer2_position,
    this.picture_cnt,
    this.nocate_picture_cnt,
    this.gallery,
    this.picture,
    this.project_seq,
    required this.mid,
  });

  copyWith({
    dynamic seq,
    String? cate_seq,
    String? engineer1_seq,
    String? engineer2_seq,
    String? name,
    String? no,
    String? purpose,
    String? location,
    String? check_date,
    String? setup_date,
    String? setup_date_type,
    String? deficiencies,
    String? action_require,
    String? remark,
    dynamic values,
    String? reg_time,
    String? project_name,
    String? license_name,
    String? project_bgnDt,
    String? project_fieldBgnDt,
    String? cate_name,
    String? cate_gubun,
    String? cate_system_name,
    String? check_rate,
    String? endurance1,
    String? endurance2,
    String? parent_cate_name,
    String? parent_cate_seq,
    String? machine_cate_seq,
    String? engineer1_name,
    String? engineer1_email,
    String? engineer2_name,
    String? engineer2_email,
    String? engineer1_position,
    String? engineer2_position,
    String? picture_cnt,
    String? nocate_picture_cnt,
    List<GalleryItem>? gallery,
    String? picture,
    String? project_seq,
    String? mid,
  }) =>
      Machine(
        seq: seq ?? this.seq,
        cate_seq: cate_seq ?? this.cate_seq,
        engineer1_seq: engineer1_seq ?? this.engineer1_seq,
        engineer2_seq: engineer2_seq ?? this.engineer2_seq,
        name: name ?? this.name,
        no: no ?? this.no,
        purpose: purpose ?? this.purpose,
        location: location ?? this.location,
        check_date: check_date ?? this.check_date,
        setup_date: setup_date ?? this.setup_date,
        setup_date_type: setup_date_type ?? this.setup_date_type,
        deficiencies: deficiencies ?? this.deficiencies,
        action_require: action_require ?? this.action_require,
        remark: remark ?? this.remark,
        values: values ?? this.values,
        reg_time: reg_time ?? this.reg_time,
        project_name: project_name ?? this.project_name,
        license_name: license_name ?? this.license_name,
        project_bgnDt: project_bgnDt ?? this.project_bgnDt,
        project_fieldBgnDt: project_fieldBgnDt ?? this.project_fieldBgnDt,
        cate_name: cate_name ?? this.cate_name,
        cate_gubun: cate_gubun ?? this.cate_gubun,
        cate_system_name: cate_system_name ?? this.cate_system_name,
        check_rate: check_rate ?? this.check_rate,
        endurance1: endurance1 ?? this.endurance1,
        endurance2: endurance2 ?? this.endurance2,
        parent_cate_name: parent_cate_name ?? this.parent_cate_name,
        parent_cate_seq: parent_cate_seq ?? this.parent_cate_seq,
        machine_cate_seq: machine_cate_seq ?? this.machine_cate_seq,
        engineer1_name: engineer1_name ?? this.engineer1_name,
        engineer1_email: engineer1_email ?? this.engineer1_email,
        engineer2_name: engineer2_name ?? this.engineer2_name,
        engineer2_email: engineer2_email ?? this.engineer2_email,
        engineer1_position: engineer1_position ?? this.engineer1_position,
        engineer2_position: engineer2_position ?? this.engineer2_position,
        picture_cnt: picture_cnt ?? this.picture_cnt,
        nocate_picture_cnt: nocate_picture_cnt ?? this.nocate_picture_cnt,
        gallery: gallery ?? this.gallery,
        picture: picture ?? this.picture,
        project_seq: project_seq ?? this.project_seq,
        mid: mid ?? this.mid,
      );

  Machine copyWithOtherMachine(Machine machine) => Machine(
        seq: machine.seq ?? seq,
        cate_seq: machine.cate_seq ?? cate_seq,
        engineer1_seq: machine.engineer1_seq ?? engineer1_seq,
        engineer2_seq: machine.engineer2_seq ?? engineer2_seq,
        name: machine.name ?? name,
        no: machine.no ?? no,
        purpose: machine.purpose ?? purpose,
        location: machine.location ?? location,
        check_date: machine.check_date ?? check_date,
        setup_date: machine.setup_date ?? setup_date,
        setup_date_type: machine.setup_date_type ?? setup_date_type,
        deficiencies: machine.deficiencies ?? deficiencies,
        action_require: machine.action_require ?? action_require,
        remark: machine.remark ?? remark,
        values: machine.values ?? values,
        reg_time: machine.reg_time ?? reg_time,
        project_name: machine.project_name ?? project_name,
        license_name: machine.license_name ?? license_name,
        project_bgnDt: machine.project_bgnDt ?? project_bgnDt,
        project_fieldBgnDt: machine.project_fieldBgnDt ?? project_fieldBgnDt,
        cate_name: machine.cate_name ?? cate_name,
        cate_gubun: machine.cate_gubun ?? cate_gubun,
        cate_system_name: machine.cate_system_name ?? cate_system_name,
        check_rate: machine.check_rate ?? check_rate,
        endurance1: machine.endurance1 ?? endurance1,
        endurance2: machine.endurance2 ?? endurance2,
        parent_cate_name: machine.parent_cate_name ?? parent_cate_name,
        parent_cate_seq: machine.parent_cate_seq ?? parent_cate_seq,
        machine_cate_seq: machine.machine_cate_seq ?? machine_cate_seq,
        engineer1_name: machine.engineer1_name ?? engineer1_name,
        engineer1_email: machine.engineer1_email ?? engineer1_email,
        engineer2_name: machine.engineer2_name ?? engineer2_name,
        engineer2_email: machine.engineer2_email ?? engineer2_email,
        engineer1_position: machine.engineer1_position ?? engineer1_position,
        engineer2_position: machine.engineer2_position ?? engineer2_position,
        picture_cnt: machine.picture_cnt ?? picture_cnt,
        nocate_picture_cnt: machine.nocate_picture_cnt ?? nocate_picture_cnt,
        gallery: machine.gallery != null && machine.gallery?.length != 0 ? machine.gallery : gallery,
        picture: machine.picture ?? picture,
        project_seq: machine.project_seq ?? project_seq,
        mid: mid,
      );

  factory Machine.fromJson(Map<String, dynamic> json) => _$MachineFromJson(json);
  Map<String, dynamic> toJson() => _$MachineToJson(this);
}

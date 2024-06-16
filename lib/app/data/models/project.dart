// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class Project {
  @HiveField(0)
  String? seq;
  @HiveField(1)
  String? license_seq;
  @HiveField(2)
  String? name;
  @HiveField(3)
  dynamic picture1;
  @HiveField(4)
  dynamic picture2;
  @HiveField(5)
  dynamic bgnDt;
  @HiveField(6)
  dynamic endDt;
  @HiveField(7)
  dynamic fieldBgnDt;
  @HiveField(8)
  dynamic fieldEndDt;
  @HiveField(9)
  dynamic reportDt;
  @HiveField(10)
  dynamic doneDt;
  @HiveField(11)
  String? done;
  @HiveField(12)
  String? deleted;
  @HiveField(13)
  String? sido;
  @HiveField(14)
  String? sigungu;
  @HiveField(15)
  String? addr;
  @HiveField(16)
  String? ceo;
  @HiveField(17)
  dynamic bizno;
  @HiveField(18)
  String? purpose;
  @HiveField(19)
  String? structure;
  @HiveField(20)
  String? tel;
  @HiveField(21)
  dynamic gross_area;
  @HiveField(22)
  String? house_cnt;
  @HiveField(23)
  dynamic completion_date;
  @HiveField(24)
  dynamic requirement;
  @HiveField(25)
  dynamic sales_user_seq;
  @HiveField(26)
  dynamic contract_date;
  @HiveField(27)
  dynamic contract_pic;
  @HiveField(28)
  dynamic contract_pic_tel;
  @HiveField(29)
  dynamic contract_pic_email;
  @HiveField(30)
  String? contract_price;
  @HiveField(31)
  String? color;
  @HiveField(32)
  dynamic report_no;
  @HiveField(33)
  String? remark;
  @HiveField(34)
  dynamic note;
  @HiveField(35)
  dynamic pic_name;
  @HiveField(36)
  dynamic pic_tel;
  @HiveField(37)
  String? pic1_1;
  @HiveField(38)
  String? pic1_2;
  @HiveField(39)
  String? pic2_1;
  @HiveField(40)
  String? pic2_2;
  @HiveField(41)
  String? pic3_1;
  @HiveField(42)
  String? pic3_2;
  @HiveField(43)
  String? pic4_1;
  @HiveField(44)
  String? pic4_2;
  @HiveField(45)
  String? pic5_1;
  @HiveField(46)
  String? pic5_2;
  @HiveField(47)
  String? pic6_1;
  @HiveField(48)
  String? pic6_2;
  @HiveField(49)
  dynamic general_opinion;
  @HiveField(50)
  dynamic improvements;
  @HiveField(51)
  dynamic results1;
  @HiveField(52)
  dynamic old_status_result;
  @HiveField(53)
  String? old_status_type;
  @HiveField(54)
  String? energy1_columns;
  @HiveField(55)
  String? energy2_columns;
  @HiveField(56)
  String? energy3_columns;
  @HiveField(57)
  String? reg_time;
  @HiveField(58)
  String? license_name;
  @HiveField(59)
  String? license_name_abbr;
  @HiveField(60)
  dynamic sales_user_name;
  @HiveField(61)
  dynamic sales_user_email;
  @HiveField(62)
  dynamic sales_user_tel;
  @HiveField(63)
  String? engineer_names;
  @HiveField(64)
  String? machine_cnt;
  @HiveField(65)
  String? picture_cnt;
  @HiveField(66)
  String? picture;
  @HiveField(67)
  List<String?>? location_list;
  @HiveField(68)
  String? app_submit_time;

  Project({
    this.seq,
    this.license_seq,
    this.name,
    this.picture1,
    this.picture2,
    this.bgnDt,
    this.endDt,
    this.fieldBgnDt,
    this.fieldEndDt,
    this.reportDt,
    this.doneDt,
    this.done,
    this.deleted,
    this.sido,
    this.sigungu,
    this.addr,
    this.ceo,
    this.bizno,
    this.purpose,
    this.structure,
    this.tel,
    this.gross_area,
    this.house_cnt,
    this.completion_date,
    this.requirement,
    this.sales_user_seq,
    this.contract_date,
    this.contract_pic,
    this.contract_pic_tel,
    this.contract_pic_email,
    this.contract_price,
    this.color,
    this.report_no,
    this.remark,
    this.note,
    this.pic_name,
    this.pic_tel,
    this.pic1_1,
    this.pic1_2,
    this.pic2_1,
    this.pic2_2,
    this.pic3_1,
    this.pic3_2,
    this.pic4_1,
    this.pic4_2,
    this.pic5_1,
    this.pic5_2,
    this.pic6_1,
    this.pic6_2,
    this.general_opinion,
    this.improvements,
    this.results1,
    this.old_status_result,
    this.old_status_type,
    this.energy1_columns,
    this.energy2_columns,
    this.energy3_columns,
    this.reg_time,
    this.license_name,
    this.license_name_abbr,
    this.sales_user_name,
    this.sales_user_email,
    this.sales_user_tel,
    this.engineer_names,
    this.machine_cnt,
    this.picture_cnt,
    this.picture,
    this.location_list,
    this.app_submit_time,
  });

  copyWithAppSubmitTime(String? app_submit_time) => Project(
        seq: seq,
        license_seq: license_seq,
        name: name,
        picture1: picture1,
        picture2: picture2,
        bgnDt: bgnDt,
        endDt: endDt,
        fieldBgnDt: fieldBgnDt,
        fieldEndDt: fieldEndDt,
        reportDt: reportDt,
        doneDt: doneDt,
        done: done,
        deleted: deleted,
        sido: sido,
        sigungu: sigungu,
        addr: addr,
        ceo: ceo,
        bizno: bizno,
        purpose: purpose,
        structure: structure,
        tel: tel,
        gross_area: gross_area,
        house_cnt: house_cnt,
        completion_date: completion_date,
        requirement: requirement,
        sales_user_seq: sales_user_seq,
        contract_date: contract_date,
        contract_pic: contract_pic,
        contract_pic_tel: contract_pic_tel,
        contract_pic_email: contract_pic_email,
        contract_price: contract_price,
        color: color,
        report_no: report_no,
        remark: remark,
        note: note,
        pic_name: pic_name,
        pic_tel: pic_tel,
        pic1_1: pic1_1,
        pic1_2: pic1_2,
        pic2_1: pic2_1,
        pic2_2: pic2_2,
        pic3_1: pic3_1,
        pic3_2: pic3_2,
        pic4_1: pic4_1,
        pic4_2: pic4_2,
        pic5_1: pic5_1,
        pic5_2: pic5_2,
        pic6_1: pic6_1,
        pic6_2: pic6_2,
        general_opinion: general_opinion,
        improvements: improvements,
        results1: results1,
        old_status_result: old_status_result,
        old_status_type: old_status_type,
        energy1_columns: energy1_columns,
        energy2_columns: energy2_columns,
        energy3_columns: energy3_columns,
        reg_time: reg_time,
        license_name: license_name,
        license_name_abbr: license_name_abbr,
        sales_user_name: sales_user_name,
        sales_user_email: sales_user_email,
        sales_user_tel: sales_user_tel,
        engineer_names: engineer_names,
        machine_cnt: machine_cnt,
        picture_cnt: picture_cnt,
        picture: picture,
        location_list: location_list,
        app_submit_time: app_submit_time ?? app_submit_time,
      );

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

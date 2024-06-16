// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectAdapter extends TypeAdapter<Project> {
  @override
  final int typeId = 4;

  @override
  Project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Project(
      seq: fields[0] as String?,
      license_seq: fields[1] as String?,
      name: fields[2] as String?,
      picture1: fields[3] as dynamic,
      picture2: fields[4] as dynamic,
      bgnDt: fields[5] as dynamic,
      endDt: fields[6] as dynamic,
      fieldBgnDt: fields[7] as dynamic,
      fieldEndDt: fields[8] as dynamic,
      reportDt: fields[9] as dynamic,
      doneDt: fields[10] as dynamic,
      done: fields[11] as String?,
      deleted: fields[12] as String?,
      sido: fields[13] as String?,
      sigungu: fields[14] as String?,
      addr: fields[15] as String?,
      ceo: fields[16] as String?,
      bizno: fields[17] as dynamic,
      purpose: fields[18] as String?,
      structure: fields[19] as String?,
      tel: fields[20] as String?,
      gross_area: fields[21] as dynamic,
      house_cnt: fields[22] as String?,
      completion_date: fields[23] as dynamic,
      requirement: fields[24] as dynamic,
      sales_user_seq: fields[25] as dynamic,
      contract_date: fields[26] as dynamic,
      contract_pic: fields[27] as dynamic,
      contract_pic_tel: fields[28] as dynamic,
      contract_pic_email: fields[29] as dynamic,
      contract_price: fields[30] as String?,
      color: fields[31] as String?,
      report_no: fields[32] as dynamic,
      remark: fields[33] as String?,
      note: fields[34] as dynamic,
      pic_name: fields[35] as dynamic,
      pic_tel: fields[36] as dynamic,
      pic1_1: fields[37] as String?,
      pic1_2: fields[38] as String?,
      pic2_1: fields[39] as String?,
      pic2_2: fields[40] as String?,
      pic3_1: fields[41] as String?,
      pic3_2: fields[42] as String?,
      pic4_1: fields[43] as String?,
      pic4_2: fields[44] as String?,
      pic5_1: fields[45] as String?,
      pic5_2: fields[46] as String?,
      pic6_1: fields[47] as String?,
      pic6_2: fields[48] as String?,
      general_opinion: fields[49] as dynamic,
      improvements: fields[50] as dynamic,
      results1: fields[51] as dynamic,
      old_status_result: fields[52] as dynamic,
      old_status_type: fields[53] as String?,
      energy1_columns: fields[54] as String?,
      energy2_columns: fields[55] as String?,
      energy3_columns: fields[56] as String?,
      reg_time: fields[57] as String?,
      license_name: fields[58] as String?,
      license_name_abbr: fields[59] as String?,
      sales_user_name: fields[60] as dynamic,
      sales_user_email: fields[61] as dynamic,
      sales_user_tel: fields[62] as dynamic,
      engineer_names: fields[63] as String?,
      machine_cnt: fields[64] as String?,
      picture_cnt: fields[65] as String?,
      picture: fields[66] as String?,
      location_list: (fields[67] as List?)?.cast<String?>(),
      app_submit_time: fields[68] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(69)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.license_seq)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.picture1)
      ..writeByte(4)
      ..write(obj.picture2)
      ..writeByte(5)
      ..write(obj.bgnDt)
      ..writeByte(6)
      ..write(obj.endDt)
      ..writeByte(7)
      ..write(obj.fieldBgnDt)
      ..writeByte(8)
      ..write(obj.fieldEndDt)
      ..writeByte(9)
      ..write(obj.reportDt)
      ..writeByte(10)
      ..write(obj.doneDt)
      ..writeByte(11)
      ..write(obj.done)
      ..writeByte(12)
      ..write(obj.deleted)
      ..writeByte(13)
      ..write(obj.sido)
      ..writeByte(14)
      ..write(obj.sigungu)
      ..writeByte(15)
      ..write(obj.addr)
      ..writeByte(16)
      ..write(obj.ceo)
      ..writeByte(17)
      ..write(obj.bizno)
      ..writeByte(18)
      ..write(obj.purpose)
      ..writeByte(19)
      ..write(obj.structure)
      ..writeByte(20)
      ..write(obj.tel)
      ..writeByte(21)
      ..write(obj.gross_area)
      ..writeByte(22)
      ..write(obj.house_cnt)
      ..writeByte(23)
      ..write(obj.completion_date)
      ..writeByte(24)
      ..write(obj.requirement)
      ..writeByte(25)
      ..write(obj.sales_user_seq)
      ..writeByte(26)
      ..write(obj.contract_date)
      ..writeByte(27)
      ..write(obj.contract_pic)
      ..writeByte(28)
      ..write(obj.contract_pic_tel)
      ..writeByte(29)
      ..write(obj.contract_pic_email)
      ..writeByte(30)
      ..write(obj.contract_price)
      ..writeByte(31)
      ..write(obj.color)
      ..writeByte(32)
      ..write(obj.report_no)
      ..writeByte(33)
      ..write(obj.remark)
      ..writeByte(34)
      ..write(obj.note)
      ..writeByte(35)
      ..write(obj.pic_name)
      ..writeByte(36)
      ..write(obj.pic_tel)
      ..writeByte(37)
      ..write(obj.pic1_1)
      ..writeByte(38)
      ..write(obj.pic1_2)
      ..writeByte(39)
      ..write(obj.pic2_1)
      ..writeByte(40)
      ..write(obj.pic2_2)
      ..writeByte(41)
      ..write(obj.pic3_1)
      ..writeByte(42)
      ..write(obj.pic3_2)
      ..writeByte(43)
      ..write(obj.pic4_1)
      ..writeByte(44)
      ..write(obj.pic4_2)
      ..writeByte(45)
      ..write(obj.pic5_1)
      ..writeByte(46)
      ..write(obj.pic5_2)
      ..writeByte(47)
      ..write(obj.pic6_1)
      ..writeByte(48)
      ..write(obj.pic6_2)
      ..writeByte(49)
      ..write(obj.general_opinion)
      ..writeByte(50)
      ..write(obj.improvements)
      ..writeByte(51)
      ..write(obj.results1)
      ..writeByte(52)
      ..write(obj.old_status_result)
      ..writeByte(53)
      ..write(obj.old_status_type)
      ..writeByte(54)
      ..write(obj.energy1_columns)
      ..writeByte(55)
      ..write(obj.energy2_columns)
      ..writeByte(56)
      ..write(obj.energy3_columns)
      ..writeByte(57)
      ..write(obj.reg_time)
      ..writeByte(58)
      ..write(obj.license_name)
      ..writeByte(59)
      ..write(obj.license_name_abbr)
      ..writeByte(60)
      ..write(obj.sales_user_name)
      ..writeByte(61)
      ..write(obj.sales_user_email)
      ..writeByte(62)
      ..write(obj.sales_user_tel)
      ..writeByte(63)
      ..write(obj.engineer_names)
      ..writeByte(64)
      ..write(obj.machine_cnt)
      ..writeByte(65)
      ..write(obj.picture_cnt)
      ..writeByte(66)
      ..write(obj.picture)
      ..writeByte(67)
      ..write(obj.location_list)
      ..writeByte(68)
      ..write(obj.app_submit_time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      seq: json['seq'] as String?,
      license_seq: json['license_seq'] as String?,
      name: json['name'] as String?,
      picture1: json['picture1'],
      picture2: json['picture2'],
      bgnDt: json['bgnDt'],
      endDt: json['endDt'],
      fieldBgnDt: json['fieldBgnDt'],
      fieldEndDt: json['fieldEndDt'],
      reportDt: json['reportDt'],
      doneDt: json['doneDt'],
      done: json['done'] as String?,
      deleted: json['deleted'] as String?,
      sido: json['sido'] as String?,
      sigungu: json['sigungu'] as String?,
      addr: json['addr'] as String?,
      ceo: json['ceo'] as String?,
      bizno: json['bizno'],
      purpose: json['purpose'] as String?,
      structure: json['structure'] as String?,
      tel: json['tel'] as String?,
      gross_area: json['gross_area'],
      house_cnt: json['house_cnt'] as String?,
      completion_date: json['completion_date'],
      requirement: json['requirement'],
      sales_user_seq: json['sales_user_seq'],
      contract_date: json['contract_date'],
      contract_pic: json['contract_pic'],
      contract_pic_tel: json['contract_pic_tel'],
      contract_pic_email: json['contract_pic_email'],
      contract_price: json['contract_price'] as String?,
      color: json['color'] as String?,
      report_no: json['report_no'],
      remark: json['remark'] as String?,
      note: json['note'],
      pic_name: json['pic_name'],
      pic_tel: json['pic_tel'],
      pic1_1: json['pic1_1'] as String?,
      pic1_2: json['pic1_2'] as String?,
      pic2_1: json['pic2_1'] as String?,
      pic2_2: json['pic2_2'] as String?,
      pic3_1: json['pic3_1'] as String?,
      pic3_2: json['pic3_2'] as String?,
      pic4_1: json['pic4_1'] as String?,
      pic4_2: json['pic4_2'] as String?,
      pic5_1: json['pic5_1'] as String?,
      pic5_2: json['pic5_2'] as String?,
      pic6_1: json['pic6_1'] as String?,
      pic6_2: json['pic6_2'] as String?,
      general_opinion: json['general_opinion'],
      improvements: json['improvements'],
      results1: json['results1'],
      old_status_result: json['old_status_result'],
      old_status_type: json['old_status_type'] as String?,
      energy1_columns: json['energy1_columns'] as String?,
      energy2_columns: json['energy2_columns'] as String?,
      energy3_columns: json['energy3_columns'] as String?,
      reg_time: json['reg_time'] as String?,
      license_name: json['license_name'] as String?,
      license_name_abbr: json['license_name_abbr'] as String?,
      sales_user_name: json['sales_user_name'],
      sales_user_email: json['sales_user_email'],
      sales_user_tel: json['sales_user_tel'],
      engineer_names: json['engineer_names'] as String?,
      machine_cnt: json['machine_cnt'] as String?,
      picture_cnt: json['picture_cnt'] as String?,
      picture: json['picture'] as String?,
      location_list: (json['location_list'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      app_submit_time: json['app_submit_time'] as String?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'seq': instance.seq,
      'license_seq': instance.license_seq,
      'name': instance.name,
      'picture1': instance.picture1,
      'picture2': instance.picture2,
      'bgnDt': instance.bgnDt,
      'endDt': instance.endDt,
      'fieldBgnDt': instance.fieldBgnDt,
      'fieldEndDt': instance.fieldEndDt,
      'reportDt': instance.reportDt,
      'doneDt': instance.doneDt,
      'done': instance.done,
      'deleted': instance.deleted,
      'sido': instance.sido,
      'sigungu': instance.sigungu,
      'addr': instance.addr,
      'ceo': instance.ceo,
      'bizno': instance.bizno,
      'purpose': instance.purpose,
      'structure': instance.structure,
      'tel': instance.tel,
      'gross_area': instance.gross_area,
      'house_cnt': instance.house_cnt,
      'completion_date': instance.completion_date,
      'requirement': instance.requirement,
      'sales_user_seq': instance.sales_user_seq,
      'contract_date': instance.contract_date,
      'contract_pic': instance.contract_pic,
      'contract_pic_tel': instance.contract_pic_tel,
      'contract_pic_email': instance.contract_pic_email,
      'contract_price': instance.contract_price,
      'color': instance.color,
      'report_no': instance.report_no,
      'remark': instance.remark,
      'note': instance.note,
      'pic_name': instance.pic_name,
      'pic_tel': instance.pic_tel,
      'pic1_1': instance.pic1_1,
      'pic1_2': instance.pic1_2,
      'pic2_1': instance.pic2_1,
      'pic2_2': instance.pic2_2,
      'pic3_1': instance.pic3_1,
      'pic3_2': instance.pic3_2,
      'pic4_1': instance.pic4_1,
      'pic4_2': instance.pic4_2,
      'pic5_1': instance.pic5_1,
      'pic5_2': instance.pic5_2,
      'pic6_1': instance.pic6_1,
      'pic6_2': instance.pic6_2,
      'general_opinion': instance.general_opinion,
      'improvements': instance.improvements,
      'results1': instance.results1,
      'old_status_result': instance.old_status_result,
      'old_status_type': instance.old_status_type,
      'energy1_columns': instance.energy1_columns,
      'energy2_columns': instance.energy2_columns,
      'energy3_columns': instance.energy3_columns,
      'reg_time': instance.reg_time,
      'license_name': instance.license_name,
      'license_name_abbr': instance.license_name_abbr,
      'sales_user_name': instance.sales_user_name,
      'sales_user_email': instance.sales_user_email,
      'sales_user_tel': instance.sales_user_tel,
      'engineer_names': instance.engineer_names,
      'machine_cnt': instance.machine_cnt,
      'picture_cnt': instance.picture_cnt,
      'picture': instance.picture,
      'location_list': instance.location_list,
      'app_submit_time': instance.app_submit_time,
    };

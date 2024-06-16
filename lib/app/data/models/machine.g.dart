// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineAdapter extends TypeAdapter<Machine> {
  @override
  final int typeId = 5;

  @override
  Machine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Machine(
      seq: fields[0] as dynamic,
      cate_seq: fields[1] as String?,
      engineer1_seq: fields[2] as String?,
      engineer2_seq: fields[3] as String?,
      name: fields[4] as String?,
      no: fields[5] as String?,
      purpose: fields[6] as String?,
      location: fields[7] as String?,
      check_date: fields[8] as String?,
      setup_date: fields[9] as String?,
      setup_date_type: fields[10] as String?,
      deficiencies: fields[11] as String?,
      action_require: fields[12] as String?,
      remark: fields[13] as String?,
      values: fields[14] as dynamic,
      reg_time: fields[15] as String?,
      project_name: fields[16] as String?,
      license_name: fields[17] as String?,
      project_bgnDt: fields[18] as String?,
      project_fieldBgnDt: fields[19] as String?,
      cate_name: fields[20] as String?,
      cate_gubun: fields[21] as String?,
      cate_system_name: fields[22] as String?,
      check_rate: fields[23] as String?,
      endurance1: fields[24] as String?,
      endurance2: fields[25] as String?,
      parent_cate_name: fields[26] as String?,
      parent_cate_seq: fields[27] as String?,
      machine_cate_seq: fields[28] as String?,
      engineer1_name: fields[29] as String?,
      engineer1_email: fields[30] as String?,
      engineer2_name: fields[31] as String?,
      engineer2_email: fields[32] as String?,
      engineer1_position: fields[33] as String?,
      engineer2_position: fields[34] as String?,
      picture_cnt: fields[35] as String?,
      nocate_picture_cnt: fields[36] as String?,
      gallery: (fields[37] as List?)?.cast<GalleryItem>(),
      picture: fields[38] as String?,
      project_seq: fields[39] as String?,
      mid: fields[40] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Machine obj) {
    writer
      ..writeByte(41)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.cate_seq)
      ..writeByte(2)
      ..write(obj.engineer1_seq)
      ..writeByte(3)
      ..write(obj.engineer2_seq)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.no)
      ..writeByte(6)
      ..write(obj.purpose)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.check_date)
      ..writeByte(9)
      ..write(obj.setup_date)
      ..writeByte(10)
      ..write(obj.setup_date_type)
      ..writeByte(11)
      ..write(obj.deficiencies)
      ..writeByte(12)
      ..write(obj.action_require)
      ..writeByte(13)
      ..write(obj.remark)
      ..writeByte(14)
      ..write(obj.values)
      ..writeByte(15)
      ..write(obj.reg_time)
      ..writeByte(16)
      ..write(obj.project_name)
      ..writeByte(17)
      ..write(obj.license_name)
      ..writeByte(18)
      ..write(obj.project_bgnDt)
      ..writeByte(19)
      ..write(obj.project_fieldBgnDt)
      ..writeByte(20)
      ..write(obj.cate_name)
      ..writeByte(21)
      ..write(obj.cate_gubun)
      ..writeByte(22)
      ..write(obj.cate_system_name)
      ..writeByte(23)
      ..write(obj.check_rate)
      ..writeByte(24)
      ..write(obj.endurance1)
      ..writeByte(25)
      ..write(obj.endurance2)
      ..writeByte(26)
      ..write(obj.parent_cate_name)
      ..writeByte(27)
      ..write(obj.parent_cate_seq)
      ..writeByte(28)
      ..write(obj.machine_cate_seq)
      ..writeByte(29)
      ..write(obj.engineer1_name)
      ..writeByte(30)
      ..write(obj.engineer1_email)
      ..writeByte(31)
      ..write(obj.engineer2_name)
      ..writeByte(32)
      ..write(obj.engineer2_email)
      ..writeByte(33)
      ..write(obj.engineer1_position)
      ..writeByte(34)
      ..write(obj.engineer2_position)
      ..writeByte(35)
      ..write(obj.picture_cnt)
      ..writeByte(36)
      ..write(obj.nocate_picture_cnt)
      ..writeByte(37)
      ..write(obj.gallery)
      ..writeByte(38)
      ..write(obj.picture)
      ..writeByte(39)
      ..write(obj.project_seq)
      ..writeByte(40)
      ..write(obj.mid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Machine _$MachineFromJson(Map<String, dynamic> json) => Machine(
      seq: json['seq'],
      cate_seq: json['cate_seq'] as String?,
      engineer1_seq: json['engineer1_seq'] as String?,
      engineer2_seq: json['engineer2_seq'] as String?,
      name: json['name'] as String?,
      no: json['no'] as String?,
      purpose: json['purpose'] as String?,
      location: json['location'] as String?,
      check_date: json['check_date'] as String?,
      setup_date: json['setup_date'] as String?,
      setup_date_type: json['setup_date_type'] as String?,
      deficiencies: json['deficiencies'] as String?,
      action_require: json['action_require'] as String?,
      remark: json['remark'] as String?,
      values: json['values'],
      reg_time: json['reg_time'] as String?,
      project_name: json['project_name'] as String?,
      license_name: json['license_name'] as String?,
      project_bgnDt: json['project_bgnDt'] as String?,
      project_fieldBgnDt: json['project_fieldBgnDt'] as String?,
      cate_name: json['cate_name'] as String?,
      cate_gubun: json['cate_gubun'] as String?,
      cate_system_name: json['cate_system_name'] as String?,
      check_rate: json['check_rate'] as String?,
      endurance1: json['endurance1'] as String?,
      endurance2: json['endurance2'] as String?,
      parent_cate_name: json['parent_cate_name'] as String?,
      parent_cate_seq: json['parent_cate_seq'] as String?,
      machine_cate_seq: json['machine_cate_seq'] as String?,
      engineer1_name: json['engineer1_name'] as String?,
      engineer1_email: json['engineer1_email'] as String?,
      engineer2_name: json['engineer2_name'] as String?,
      engineer2_email: json['engineer2_email'] as String?,
      engineer1_position: json['engineer1_position'] as String?,
      engineer2_position: json['engineer2_position'] as String?,
      picture_cnt: json['picture_cnt'] as String?,
      nocate_picture_cnt: json['nocate_picture_cnt'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      picture: json['picture'] as String?,
      project_seq: json['project_seq'] as String?,
      mid: json['mid'] as String,
    );

Map<String, dynamic> _$MachineToJson(Machine instance) => <String, dynamic>{
      'seq': instance.seq,
      'cate_seq': instance.cate_seq,
      'engineer1_seq': instance.engineer1_seq,
      'engineer2_seq': instance.engineer2_seq,
      'name': instance.name,
      'no': instance.no,
      'purpose': instance.purpose,
      'location': instance.location,
      'check_date': instance.check_date,
      'setup_date': instance.setup_date,
      'setup_date_type': instance.setup_date_type,
      'deficiencies': instance.deficiencies,
      'action_require': instance.action_require,
      'remark': instance.remark,
      'values': instance.values,
      'reg_time': instance.reg_time,
      'project_name': instance.project_name,
      'license_name': instance.license_name,
      'project_bgnDt': instance.project_bgnDt,
      'project_fieldBgnDt': instance.project_fieldBgnDt,
      'cate_name': instance.cate_name,
      'cate_gubun': instance.cate_gubun,
      'cate_system_name': instance.cate_system_name,
      'check_rate': instance.check_rate,
      'endurance1': instance.endurance1,
      'endurance2': instance.endurance2,
      'parent_cate_name': instance.parent_cate_name,
      'parent_cate_seq': instance.parent_cate_seq,
      'machine_cate_seq': instance.machine_cate_seq,
      'engineer1_name': instance.engineer1_name,
      'engineer1_email': instance.engineer1_email,
      'engineer2_name': instance.engineer2_name,
      'engineer2_email': instance.engineer2_email,
      'engineer1_position': instance.engineer1_position,
      'engineer2_position': instance.engineer2_position,
      'picture_cnt': instance.picture_cnt,
      'nocate_picture_cnt': instance.nocate_picture_cnt,
      'gallery': instance.gallery,
      'picture': instance.picture,
      'project_seq': instance.project_seq,
      'mid': instance.mid,
    };

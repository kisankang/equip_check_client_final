// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edited_machine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EditedMachineAdapter extends TypeAdapter<EditedMachine> {
  @override
  final int typeId = 8;

  @override
  EditedMachine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EditedMachine(
      user_seq: fields[0] as String,
      machine_seq: fields[1] as String?,
      cate_seq: fields[2] as String,
      location: fields[3] as String?,
      setup_date: fields[4] as String?,
      check_date: fields[5] as String?,
      project_seq: fields[6] as String,
      name: fields[7] as String,
      mid: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EditedMachine obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.user_seq)
      ..writeByte(1)
      ..write(obj.machine_seq)
      ..writeByte(2)
      ..write(obj.cate_seq)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.setup_date)
      ..writeByte(5)
      ..write(obj.check_date)
      ..writeByte(6)
      ..write(obj.project_seq)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.mid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditedMachineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditedMachine _$EditedMachineFromJson(Map<String, dynamic> json) =>
    EditedMachine(
      user_seq: json['user_seq'] as String,
      machine_seq: json['machine_seq'] as String?,
      cate_seq: json['cate_seq'] as String,
      location: json['location'] as String?,
      setup_date: json['setup_date'] as String?,
      check_date: json['check_date'] as String?,
      project_seq: json['project_seq'] as String,
      name: json['name'] as String,
      mid: json['mid'] as String,
    );

Map<String, dynamic> _$EditedMachineToJson(EditedMachine instance) =>
    <String, dynamic>{
      'user_seq': instance.user_seq,
      'machine_seq': instance.machine_seq,
      'cate_seq': instance.cate_seq,
      'location': instance.location,
      'setup_date': instance.setup_date,
      'check_date': instance.check_date,
      'name': instance.name,
      'mid': instance.mid,
    };

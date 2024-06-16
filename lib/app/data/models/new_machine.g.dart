// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_machine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewMachineAdapter extends TypeAdapter<NewMachine> {
  @override
  final int typeId = 10;

  @override
  NewMachine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewMachine(
      project_seq: fields[0] as String,
      cate1: fields[1] as String?,
      cate2: fields[2] as String?,
      mid: fields[5] as String,
    )..qty = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, NewMachine obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.project_seq)
      ..writeByte(1)
      ..write(obj.cate1)
      ..writeByte(2)
      ..write(obj.cate2)
      ..writeByte(4)
      ..write(obj.qty)
      ..writeByte(5)
      ..write(obj.mid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewMachineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMachine _$NewMachineFromJson(Map<String, dynamic> json) => NewMachine(
      project_seq: json['project_seq'] as String,
      cate1: json['cate1'] as String?,
      cate2: json['cate2'] as String?,
      mid: json['mid'] as String,
    )..qty = json['qty'] as int;

Map<String, dynamic> _$NewMachineToJson(NewMachine instance) =>
    <String, dynamic>{
      'project_seq': instance.project_seq,
      'cate1': instance.cate1,
      'cate2': instance.cate2,
      'qty': instance.qty,
      'mid': instance.mid,
    };

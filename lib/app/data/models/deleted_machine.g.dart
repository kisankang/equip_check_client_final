// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_machine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeletedMachineAdapter extends TypeAdapter<DeletedMachine> {
  @override
  final int typeId = 11;

  @override
  DeletedMachine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeletedMachine(
      seq: fields[0] as String?,
      project_seq: fields[1] as String,
      mid: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeletedMachine obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.project_seq)
      ..writeByte(2)
      ..write(obj.mid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeletedMachineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletedMachine _$DeletedMachineFromJson(Map<String, dynamic> json) =>
    DeletedMachine(
      seq: json['seq'] as String?,
      project_seq: json['project_seq'] as String,
      mid: json['mid'] as String,
    );

Map<String, dynamic> _$DeletedMachineToJson(DeletedMachine instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'mid': instance.mid,
    };

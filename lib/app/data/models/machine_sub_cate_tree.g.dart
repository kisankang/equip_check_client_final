// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_sub_cate_tree.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineSubCateTreeAdapter extends TypeAdapter<MachineSubCateTree> {
  @override
  final int typeId = 3;

  @override
  MachineSubCateTree read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MachineSubCateTree(
      seq: fields[0] as String?,
      parent_seq: fields[1] as String?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MachineSubCateTree obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.parent_seq)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineSubCateTreeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineSubCateTree _$MachineSubCateTreeFromJson(Map<String, dynamic> json) =>
    MachineSubCateTree(
      seq: json['seq'] as String?,
      parent_seq: json['parent_seq'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MachineSubCateTreeToJson(MachineSubCateTree instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'parent_seq': instance.parent_seq,
      'name': instance.name,
    };

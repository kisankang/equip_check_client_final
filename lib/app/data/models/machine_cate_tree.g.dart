// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_cate_tree.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineCateTreeAdapter extends TypeAdapter<MachineCateTree> {
  @override
  final int typeId = 2;

  @override
  MachineCateTree read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MachineCateTree(
      seq: fields[0] as String,
      name: fields[1] as String,
      sub_cate: (fields[2] as List?)?.cast<MachineSubCateTree>(),
    );
  }

  @override
  void write(BinaryWriter writer, MachineCateTree obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sub_cate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineCateTreeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineCateTree _$MachineCateTreeFromJson(Map<String, dynamic> json) =>
    MachineCateTree(
      seq: json['seq'] as String,
      name: json['name'] as String,
      sub_cate: (json['sub_cate'] as List<dynamic>?)
          ?.map((e) => MachineSubCateTree.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MachineCateTreeToJson(MachineCateTree instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'name': instance.name,
      'sub_cate': instance.sub_cate,
    };

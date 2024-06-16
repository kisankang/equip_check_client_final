// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_cate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineCateAdapter extends TypeAdapter<MachineCate> {
  @override
  final int typeId = 1;

  @override
  MachineCate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MachineCate(
      seq: fields[0] as String,
      name: fields[1] as String,
      sub_cate: (fields[2] as List).cast<dynamic>(),
      check_list: (fields[3] as List?)?.cast<CheckListItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, MachineCate obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sub_cate)
      ..writeByte(3)
      ..write(obj.check_list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineCateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineCate _$MachineCateFromJson(Map<String, dynamic> json) => MachineCate(
      seq: json['seq'] as String,
      name: json['name'] as String,
      sub_cate: json['sub_cate'] as List<dynamic>,
      check_list: (json['check_list'] as List<dynamic>?)
          ?.map((e) => CheckListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MachineCateToJson(MachineCate instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'name': instance.name,
      'sub_cate': instance.sub_cate,
      'check_list': instance.check_list,
    };

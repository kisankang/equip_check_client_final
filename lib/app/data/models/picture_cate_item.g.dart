// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_cate_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PictureCateItemAdapter extends TypeAdapter<PictureCateItem> {
  @override
  final int typeId = 14;

  @override
  PictureCateItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PictureCateItem(
      seq: fields[0] as String?,
      name: fields[1] as String?,
      data: fields[2] as String?,
      singleYn: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PictureCateItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.singleYn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureCateItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureCateItem _$PictureCateItemFromJson(Map<String, dynamic> json) =>
    PictureCateItem(
      seq: json['seq'] as String?,
      name: json['name'] as String?,
      data: json['data'] as String?,
      singleYn: json['singleYn'] as String?,
    );

Map<String, dynamic> _$PictureCateItemToJson(PictureCateItem instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'name': instance.name,
      'data': instance.data,
      'singleYn': instance.singleYn,
    };

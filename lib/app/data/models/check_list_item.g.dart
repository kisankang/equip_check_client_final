// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListItemAdapter extends TypeAdapter<CheckListItem> {
  @override
  final int typeId = 13;

  @override
  CheckListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckListItem(
      seq: fields[0] as dynamic,
      name: fields[1] as String?,
      picture_cate_list: (fields[2] as List?)?.cast<PictureCateItem?>(),
    );
  }

  @override
  void write(BinaryWriter writer, CheckListItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.picture_cate_list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckListItem _$CheckListItemFromJson(Map<String, dynamic> json) =>
    CheckListItem(
      seq: json['seq'],
      name: json['name'] as String?,
      picture_cate_list: (json['picture_cate_list'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PictureCateItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckListItemToJson(CheckListItem instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'name': instance.name,
      'picture_cate_list': instance.picture_cate_list,
    };

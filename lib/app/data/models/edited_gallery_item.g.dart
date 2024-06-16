// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edited_gallery_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EditedGalleryItemAdapter extends TypeAdapter<EditedGalleryItem> {
  @override
  final int typeId = 12;

  @override
  EditedGalleryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EditedGalleryItem(
      picture_seq: fields[0] as String?,
      title: fields[1] as String?,
      value: fields[2] as String?,
      check_seq: fields[3] as String,
      cate_seq: fields[4] as String?,
      machine_seq: fields[5] as String?,
      project_seq: fields[7] as String,
      pid: fields[8] as String,
      mid: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EditedGalleryItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.picture_seq)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.check_seq)
      ..writeByte(4)
      ..write(obj.cate_seq)
      ..writeByte(5)
      ..write(obj.machine_seq)
      ..writeByte(7)
      ..write(obj.project_seq)
      ..writeByte(8)
      ..write(obj.pid)
      ..writeByte(9)
      ..write(obj.mid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditedGalleryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditedGalleryItem _$EditedGalleryItemFromJson(Map<String, dynamic> json) =>
    EditedGalleryItem(
      picture_seq: json['picture_seq'] as String?,
      title: json['title'] as String?,
      value: json['value'] as String?,
      check_seq: json['check_seq'] as String,
      cate_seq: json['cate_seq'] as String?,
      machine_seq: json['machine_seq'] as String?,
      project_seq: json['project_seq'] as String,
      pid: json['pid'] as String,
      mid: json['mid'] as String,
    );

Map<String, dynamic> _$EditedGalleryItemToJson(EditedGalleryItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'check_seq': instance.check_seq,
      'cate_seq': instance.cate_seq,
      'machine_seq': instance.machine_seq,
      'pid': instance.pid,
      'mid': instance.mid,
    };

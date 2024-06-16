// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryItemAdapter extends TypeAdapter<GalleryItem> {
  @override
  final int typeId = 15;

  @override
  GalleryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryItem(
      seq: fields[0] as String?,
      machine_seq: fields[1] as String?,
      check_seq: fields[2] as String?,
      cate_seq: fields[3] as String?,
      title: fields[4] as String?,
      value: fields[5] as String?,
      data: fields[6] as String?,
      file_name: fields[7] as String?,
      file_path: fields[8] as String?,
      thumb: fields[9] as String?,
      update_time: fields[10] as String?,
      pid: fields[11] as String,
      mid: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.machine_seq)
      ..writeByte(2)
      ..write(obj.check_seq)
      ..writeByte(3)
      ..write(obj.cate_seq)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.value)
      ..writeByte(6)
      ..write(obj.data)
      ..writeByte(7)
      ..write(obj.file_name)
      ..writeByte(8)
      ..write(obj.file_path)
      ..writeByte(9)
      ..write(obj.thumb)
      ..writeByte(10)
      ..write(obj.update_time)
      ..writeByte(11)
      ..write(obj.pid)
      ..writeByte(12)
      ..write(obj.mid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryItem _$GalleryItemFromJson(Map<String, dynamic> json) => GalleryItem(
      seq: json['seq'] as String?,
      machine_seq: json['machine_seq'] as String?,
      check_seq: json['check_seq'] as String?,
      cate_seq: json['cate_seq'] as String?,
      title: json['title'] as String?,
      value: json['value'] as String?,
      data: json['data'] as String?,
      file_name: json['file_name'] as String?,
      file_path: json['file_path'] as String?,
      thumb: json['thumb'] as String?,
      update_time: json['update_time'] as String?,
      pid: json['pid'] as String,
      mid: json['mid'] as String,
    );

Map<String, dynamic> _$GalleryItemToJson(GalleryItem instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'machine_seq': instance.machine_seq,
      'check_seq': instance.check_seq,
      'cate_seq': instance.cate_seq,
      'title': instance.title,
      'value': instance.value,
      'data': instance.data,
      'file_name': instance.file_name,
      'file_path': instance.file_path,
      'thumb': instance.thumb,
      'update_time': instance.update_time,
      'pid': instance.pid,
      'mid': instance.mid,
    };

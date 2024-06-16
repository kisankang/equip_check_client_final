// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_gallery_picture.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewGalleryPictureAdapter extends TypeAdapter<NewGalleryPicture> {
  @override
  final int typeId = 6;

  @override
  NewGalleryPicture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewGalleryPicture(
      project_seq: fields[0] as String,
      machine_seq: fields[1] as String?,
      check_seq: fields[2] as String,
      cate_seq: fields[3] as String?,
      title: fields[4] as String?,
      value: fields[5] as String?,
      userfile: fields[6] as String?,
      update_time: fields[7] as String?,
      seq: fields[8] as String?,
      file_path: fields[9] as String?,
      file_name: fields[10] as String?,
      mid: fields[12] as String,
      pid: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewGalleryPicture obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.project_seq)
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
      ..write(obj.userfile)
      ..writeByte(7)
      ..write(obj.update_time)
      ..writeByte(8)
      ..write(obj.seq)
      ..writeByte(9)
      ..write(obj.file_path)
      ..writeByte(10)
      ..write(obj.file_name)
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
      other is NewGalleryPictureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewGalleryPicture _$NewGalleryPictureFromJson(Map<String, dynamic> json) =>
    NewGalleryPicture(
      project_seq: json['project_seq'] as String,
      machine_seq: json['machine_seq'] as String?,
      check_seq: json['check_seq'] as String,
      cate_seq: json['cate_seq'] as String?,
      title: json['title'] as String?,
      value: json['value'] as String?,
      userfile: json['userfile'] as String?,
      update_time: json['update_time'] as String?,
      seq: json['seq'] as String?,
      file_path: json['file_path'] as String?,
      file_name: json['file_name'] as String?,
      mid: json['mid'] as String,
      pid: json['pid'] as String,
    );

Map<String, dynamic> _$NewGalleryPictureToJson(NewGalleryPicture instance) =>
    <String, dynamic>{
      'project_seq': instance.project_seq,
      'machine_seq': instance.machine_seq,
      'check_seq': instance.check_seq,
      'cate_seq': instance.cate_seq,
      'title': instance.title,
      'value': instance.value,
      'userfile': instance.userfile,
      'pid': instance.pid,
      'mid': instance.mid,
    };

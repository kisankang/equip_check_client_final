// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_gallery_picture.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeletedGalleryPictureAdapter extends TypeAdapter<DeletedGalleryPicture> {
  @override
  final int typeId = 9;

  @override
  DeletedGalleryPicture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeletedGalleryPicture(
      seq: fields[0] as String?,
      project_seq: fields[1] as String,
      machine_seq: fields[2] as String?,
      mid: fields[3] as String,
      pid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeletedGalleryPicture obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.seq)
      ..writeByte(1)
      ..write(obj.project_seq)
      ..writeByte(2)
      ..write(obj.machine_seq)
      ..writeByte(3)
      ..write(obj.mid)
      ..writeByte(4)
      ..write(obj.pid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeletedGalleryPictureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletedGalleryPicture _$DeletedGalleryPictureFromJson(
        Map<String, dynamic> json) =>
    DeletedGalleryPicture(
      seq: json['seq'] as String?,
      project_seq: json['project_seq'] as String,
      machine_seq: json['machine_seq'] as String?,
      mid: json['mid'] as String,
      pid: json['pid'] as String,
    );

Map<String, dynamic> _$DeletedGalleryPictureToJson(
        DeletedGalleryPicture instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'pid': instance.pid,
    };

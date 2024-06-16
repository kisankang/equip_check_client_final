// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deleted_gallery_picture.g.dart';

@JsonSerializable()
@HiveType(typeId: 9)
class DeletedGalleryPicture {
  @HiveField(0)
  @JsonKey(includeToJson: false)
  String? seq;

  @HiveField(1)
  @JsonKey(includeToJson: false)
  String project_seq;

  @HiveField(2)
  @JsonKey(includeToJson: false)
  String? machine_seq;

  @HiveField(3)
  String mid;

  @HiveField(4)
  String pid;

  DeletedGalleryPicture({
    required this.seq,
    required this.project_seq,
    required this.machine_seq,
    required this.mid,
    required this.pid,
  });

  copyWith({
    String? seq,
    String? project_seq,
    String? machine_seq,
    String? mid,
    String? pid,
  }) =>
      DeletedGalleryPicture(
        seq: seq ?? this.seq,
        project_seq: project_seq ?? this.project_seq,
        machine_seq: machine_seq ?? this.machine_seq,
        mid: mid ?? this.mid,
        pid: pid ?? this.pid,
      );

  GalleryItem toGalleryItem({String? new_seq}) => GalleryItem(
        seq: seq,
        machine_seq: machine_seq,
        check_seq: null,
        cate_seq: null,
        title: null,
        value: null,
        data: null,
        file_name: null,
        file_path: null,
        thumb: null,
        update_time: null,
        mid: mid,
        pid: pid,
      );

  factory DeletedGalleryPicture.fromJson(Map<String, dynamic> json) => _$DeletedGalleryPictureFromJson(json);
  Map<String, dynamic> toJson() => _$DeletedGalleryPictureToJson(this);
}

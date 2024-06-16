// ignore_for_file: non_constant_identifier_names
import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_gallery_picture.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class NewGalleryPicture {
  @HiveField(0)
  String project_seq;
  @HiveField(1)
  String? machine_seq;
  @HiveField(2)
  String check_seq;
  @HiveField(3)
  String? cate_seq;
  @HiveField(4)
  String? title;
  @HiveField(5)
  String? value;
  @HiveField(6)
  String? userfile;

  @HiveField(7)
  @JsonKey(includeToJson: false)
  String? update_time;

  @HiveField(8)
  @JsonKey(includeToJson: false)
  String? seq;

  @HiveField(9)
  @JsonKey(includeToJson: false)
  String? file_path;

  @HiveField(10)
  @JsonKey(includeToJson: false)
  String? file_name;

  @HiveField(11)
  String pid;

  @HiveField(12)
  String mid;

  NewGalleryPicture({
    required this.project_seq,
    required this.machine_seq,
    required this.check_seq,
    required this.cate_seq,
    required this.title,
    required this.value,
    required this.userfile,
    required this.update_time,
    required this.seq,
    required this.file_path,
    required this.file_name,
    required this.mid,
    required this.pid,
  });

  copyWith({
    String? project_seq,
    String? machine_seq,
    String? check_seq,
    String? cate_seq,
    String? title,
    String? value,
    String? userfile,
    String? update_time,
    String? seq,
    String? file_path,
    String? file_name,
    String? mid,
    String? pid,
  }) =>
      NewGalleryPicture(
        project_seq: project_seq ?? this.project_seq,
        machine_seq: machine_seq ?? this.machine_seq,
        check_seq: check_seq ?? this.check_seq,
        cate_seq: cate_seq ?? this.cate_seq,
        title: title ?? this.title,
        value: value ?? this.value,
        userfile: userfile ?? this.userfile,
        update_time: update_time ?? this.update_time,
        seq: seq ?? this.seq,
        file_path: file_path ?? this.file_path,
        file_name: file_name ?? this.file_name,
        mid: mid ?? this.mid,
        pid: pid ?? this.pid,
      );

  GalleryItem toGalleryItem() => GalleryItem(
        seq: seq,
        machine_seq: machine_seq,
        check_seq: check_seq,
        cate_seq: cate_seq,
        title: title,
        value: value,
        data: null,
        file_name: file_name,
        file_path: file_path,
        thumb: null,
        update_time: null,
        mid: mid,
        pid: pid,
      );

  factory NewGalleryPicture.fromJson(Map<String, dynamic> json) => _$NewGalleryPictureFromJson(json);
  Map<String, dynamic> toJson() => _$NewGalleryPictureToJson(this);
}

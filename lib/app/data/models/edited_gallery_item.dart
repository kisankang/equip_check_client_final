// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/data/models/gallery_item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edited_gallery_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 12)
class EditedGalleryItem {
  @HiveField(0)
  @JsonKey(includeToJson: false)
  String? picture_seq;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? value;

  @HiveField(3)
  String check_seq;

  @HiveField(4)
  String? cate_seq;

  @HiveField(5)
  String? machine_seq;

  @HiveField(7)
  @JsonKey(includeToJson: false)
  String project_seq;

  @HiveField(8)
  String pid;

  @HiveField(9)
  String mid;

  EditedGalleryItem({
    required this.picture_seq,
    required this.title,
    required this.value,
    required this.check_seq,
    required this.cate_seq,
    required this.machine_seq,
    required this.project_seq,
    required this.pid,
    required this.mid,
  });

  GalleryItem toGalleryItem({String? new_seq}) => GalleryItem(
        seq: new_seq ?? picture_seq,
        machine_seq: machine_seq,
        check_seq: check_seq,
        cate_seq: cate_seq,
        title: title,
        value: value,
        data: null,
        file_name: null,
        file_path: null,
        thumb: null,
        update_time: null,
        mid: mid,
        pid: pid,
      );
  EditedGalleryItem copyWith({
    String? picture_seq,
    String? title,
    String? value,
    String? check_seq,
    String? cate_seq,
    String? machine_seq,
    String? project_seq,
    String? mid,
    String? pid,
  }) =>
      EditedGalleryItem(
        picture_seq: picture_seq ?? this.picture_seq,
        title: title ?? this.title,
        value: value ?? this.value,
        check_seq: check_seq ?? this.check_seq,
        cate_seq: cate_seq ?? this.cate_seq,
        machine_seq: machine_seq ?? this.machine_seq,
        project_seq: project_seq ?? this.project_seq,
        mid: mid ?? this.mid,
        pid: pid ?? this.pid,
      );

  factory EditedGalleryItem.fromJson(Map<String, dynamic> json) => _$EditedGalleryItemFromJson(json);
  Map<String, dynamic> toJson() => _$EditedGalleryItemToJson(this);
}

// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gallery_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 15)
class GalleryItem {
  @HiveField(0)
  String? seq;
  @HiveField(1)
  String? machine_seq;
  @HiveField(2)
  String? check_seq;
  @HiveField(3)
  String? cate_seq;
  @HiveField(4)
  String? title;
  @HiveField(5)
  String? value;
  @HiveField(6)
  String? data;
  @HiveField(7)
  String? file_name;
  @HiveField(8)
  String? file_path;
  @HiveField(9)
  String? thumb;
  @HiveField(10)
  String? update_time;

  @HiveField(11)
  String pid;
  @HiveField(12)
  String mid;

  GalleryItem({
    required this.seq,
    required this.machine_seq,
    required this.check_seq,
    required this.cate_seq,
    required this.title,
    required this.value,
    required this.data,
    required this.file_name,
    required this.file_path,
    required this.thumb,
    required this.update_time,
    required this.pid,
    required this.mid,
  });

  GalleryItem copyWith({
    String? seq,
    String? machine_seq,
    String? check_seq,
    String? cate_seq,
    String? title,
    String? value,
    String? data,
    String? file_name,
    String? file_path,
    String? thumb,
    String? update_time,
    String? pid,
    String? mid,
  }) =>
      GalleryItem(
        seq: seq ?? this.seq,
        machine_seq: machine_seq ?? this.machine_seq,
        check_seq: check_seq ?? this.check_seq,
        cate_seq: cate_seq ?? this.cate_seq,
        title: title ?? this.title,
        value: value ?? this.value,
        data: data ?? this.data,
        file_name: file_name ?? this.file_name,
        file_path: file_path ?? this.file_path,
        thumb: thumb ?? this.thumb,
        update_time: update_time ?? this.update_time,
        pid: pid ?? this.pid,
        mid: mid ?? this.mid,
      );

  GalleryItem copyWithOtherGallery(GalleryItem galleryItem) => GalleryItem(
        seq: galleryItem.seq ?? seq,
        machine_seq: galleryItem.machine_seq ?? machine_seq,
        check_seq: galleryItem.check_seq ?? check_seq,
        cate_seq: galleryItem.cate_seq ?? cate_seq,
        title: galleryItem.title ?? title,
        value: galleryItem.value ?? value,
        data: galleryItem.data ?? data,
        file_name: galleryItem.file_name ?? file_name,
        file_path: galleryItem.file_path ?? file_path,
        thumb: galleryItem.thumb ?? thumb,
        update_time: galleryItem.update_time ?? update_time,
        pid: galleryItem.pid,
        mid: galleryItem.mid,
      );

  factory GalleryItem.fromJson(Map<String, dynamic> json) => _$GalleryItemFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryItemToJson(this);
}

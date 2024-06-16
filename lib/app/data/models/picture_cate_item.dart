// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'picture_cate_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 14)
class PictureCateItem {
  @HiveField(0)
  String? seq;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? data;
  @HiveField(3)
  String? singleYn;
  PictureCateItem({
    required this.seq,
    required this.name,
    required this.data,
    required this.singleYn,
  });

  factory PictureCateItem.fromJson(Map<String, dynamic> json) => _$PictureCateItemFromJson(json);
  Map<String, dynamic> toJson() => _$PictureCateItemToJson(this);
}

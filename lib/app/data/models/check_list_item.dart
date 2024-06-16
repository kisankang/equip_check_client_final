// ignore_for_file: non_constant_identifier_names

import 'package:equip_check_client/app/data/models/picture_cate_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_list_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 13)
class CheckListItem {
  @HiveField(0)
  dynamic seq;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<PictureCateItem?>? picture_cate_list;

  CheckListItem({
    required this.seq,
    required this.name,
    required this.picture_cate_list,
  });

  factory CheckListItem.fromJson(Map<String, dynamic> json) => _$CheckListItemFromJson(json);
  Map<String, dynamic> toJson() => _$CheckListItemToJson(this);
}

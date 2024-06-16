// ignore_for_file: non_constant_identifier_names
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class User {
  @HiveField(0)
  String seq;
  @HiveField(1)
  String email;
  @HiveField(2)
  String name;
  @HiveField(3)
  String company_name;
  @HiveField(4)
  String avatar_file;
  @HiveField(5)
  String role;
  @HiveField(6)
  String status;
  @HiveField(7)
  String test;
  @HiveField(8)
  String black;
  User({
    required this.seq,
    required this.email,
    required this.name,
    required this.company_name,
    required this.avatar_file,
    required this.role,
    required this.status,
    required this.test,
    required this.black,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

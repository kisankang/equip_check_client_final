import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  BaseResult? result;
  dynamic data;

  BaseResponse({this.result, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class BaseResult {
  final int code;
  final String message;
  BaseResult({
    required this.code,
    required this.message,
  });

  factory BaseResult.fromJson(Map<String, dynamic> json) => _$BaseResultFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResultToJson(this);
}

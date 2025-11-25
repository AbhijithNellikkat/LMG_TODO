import 'package:json_annotation/json_annotation.dart';

part 'success_responce.g.dart';

@JsonSerializable()
class SuccessResponce {
  String? message;
  dynamic data;

  SuccessResponce({this.message, this.data});

  factory SuccessResponce.fromJson(Map<String, dynamic> json) {
    return _$SuccessResponceFromJson(json)..data = json;
  }

  Map<String, dynamic> toJson() => _$SuccessResponceToJson(this);
}

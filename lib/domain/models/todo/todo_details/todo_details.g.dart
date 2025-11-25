// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDetails _$TodoDetailsFromJson(Map<String, dynamic> json) => TodoDetails(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  totalSeconds: (json['totalSeconds'] as num?)?.toInt(),
  remainingSeconds: (json['remainingSeconds'] as num?)?.toInt(),
  status: json['status'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TodoDetailsToJson(TodoDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'totalSeconds': instance.totalSeconds,
      'remainingSeconds': instance.remainingSeconds,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

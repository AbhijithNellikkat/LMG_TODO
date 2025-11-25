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
  isRunning: json['isRunning'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..localId = (json['localId'] as num?)?.toInt();

Map<String, dynamic> _$TodoDetailsToJson(TodoDetails instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'totalSeconds': instance.totalSeconds,
      'remainingSeconds': instance.remainingSeconds,
      'status': instance.status,
      'isRunning': instance.isRunning,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

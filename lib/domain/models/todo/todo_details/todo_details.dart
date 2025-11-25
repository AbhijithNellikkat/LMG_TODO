import 'package:json_annotation/json_annotation.dart';

part 'todo_details.g.dart';

@JsonSerializable()
class TodoDetails {
  int? id;
  String? title;
  String? description;
  int? totalSeconds;
  int? remainingSeconds;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TodoDetails({
    this.id,
    this.title,
    this.description,
    this.totalSeconds,
    this.remainingSeconds,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'TodoDetails(id: $id, title: $title, description: $description, totalSeconds: $totalSeconds, remainingSeconds: $remainingSeconds, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory TodoDetails.fromJson(Map<String, dynamic> json) {
    return _$TodoDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TodoDetailsToJson(this);

  TodoDetails copyWith({
    int? id,
    String? title,
    String? description,
    int? totalSeconds,
    int? remainingSeconds,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static const colTodoId = 'todo_id';
  static const colTodoLocalId = 'todo_local_id';
  static const colTitle = 'title';
  static const colDescription = 'description';
  static const colTotalSeconds = 'total_seconds';
  static const colRemainingSeconds = 'remaining_seconds';
  static const colStatus = 'status';
  static const colCreatedAt = 'created_at';
  static const colUpdatedAt = 'updated_at';
}

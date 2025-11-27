class TodoDetails {
  // SQLite column names
  static const String colTodoLocalId = "todo_local_id";

  static const String colTitle = "title";
  static const String colDescription = "description";
  static const String colTotalSeconds = "total_seconds";
  static const String colRemainingSeconds = "remaining_seconds";
  static const String colStatus = "status";
  static const String colIsRunning = "is_running";
  static const String colCreatedAt = "created_at";
  static const String colUpdatedAt = "updated_at";

  int? todoLocalId; // SQLite primary key

  String title;
  String description;
  int totalSeconds;
  int remainingSeconds;
  String status;
  bool isRunning;
  DateTime createdAt;
  DateTime updatedAt;

  TodoDetails({
    this.todoLocalId,

    required this.title,
    required this.description,
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.status,
    required this.isRunning,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert model → SQLite Map
  Map<String, dynamic> toMap() => {
    colTodoLocalId: todoLocalId,

    colTitle: title,
    colDescription: description,
    colTotalSeconds: totalSeconds,
    colRemainingSeconds: remainingSeconds,
    colStatus: status,
    colIsRunning: isRunning ? 1 : 0,
    colCreatedAt: createdAt.toIso8601String(),
    colUpdatedAt: updatedAt.toIso8601String(),
  };

  /// Convert SQLite Row → Model
  factory TodoDetails.fromMap(Map<String, dynamic> map) => TodoDetails(
    todoLocalId: map[colTodoLocalId],

    title: map[colTitle],
    description: map[colDescription],
    totalSeconds: map[colTotalSeconds],
    remainingSeconds: map[colRemainingSeconds],
    status: map[colStatus],
    isRunning: map[colIsRunning] == 1,
    createdAt: DateTime.parse(map[colCreatedAt]),
    updatedAt: DateTime.parse(map[colUpdatedAt]),
  );

  /// Copy with updates
  TodoDetails copyWith({
    int? todoLocalId,
    String? todoId,
    String? title,
    String? description,
    int? totalSeconds,
    int? remainingSeconds,
    String? status,
    bool? isRunning,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoDetails(
      todoLocalId: todoLocalId ?? this.todoLocalId,

      title: title ?? this.title,
      description: description ?? this.description,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      status: status ?? this.status,
      isRunning: isRunning ?? this.isRunning,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

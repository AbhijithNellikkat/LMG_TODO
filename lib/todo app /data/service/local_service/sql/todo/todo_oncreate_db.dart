import 'dart:developer';

import 'package:lmg_todo/todo%20app%20/domain/models/todo/todo_details/todo_details.dart';
import 'package:sqflite/sqflite.dart' as sql;

class TodoSql {
  static const todosTable = 'lmg_todos';

  static Future onCreate(sql.Database db) async {
    try {
      log(
        '----------------- oncreate database task module ---------------------',
      );
      await db.execute(_todosTableCreation);
    } catch (e) {
      log('onCreate ==> ${e.toString()}');
    }
  }

  /// Table for todos
  static const String _todosTableCreation =
      '''
  CREATE TABLE IF NOT EXISTS $todosTable (
    ${TodoDetails.colTodoLocalId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TodoDetails.colTitle} TEXT,
    ${TodoDetails.colDescription} TEXT,
    ${TodoDetails.colTotalSeconds} INTEGER,
    ${TodoDetails.colRemainingSeconds} INTEGER,
    ${TodoDetails.colStatus} TEXT,
    ${TodoDetails.colIsRunning} INTEGER,  -- Boolean field (1 for true, 0 for false)
    ${TodoDetails.colCreatedAt} TEXT,
    ${TodoDetails.colUpdatedAt} TEXT
  )
  ''';
}

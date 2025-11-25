import 'dart:developer';
import 'package:sqflite/sqflite.dart' as sql;

class Sql {
  static const todoTable = 'Todos';

  static Future onCreate(sql.Database db) async {
    try {
      log('----------------- onCreate database ---------------------');
      await db.execute(queryTodoTableCreation);
    } catch (e) {
      log('onCreate ==> ${e.toString()}');
    }
  }

  static const String queryTodoTableCreation =
      '''
      CREATE TABLE IF NOT EXISTS $todoTable (
        localId INTEGER PRIMARY KEY AUTOINCREMENT,

      )
    ''';
}

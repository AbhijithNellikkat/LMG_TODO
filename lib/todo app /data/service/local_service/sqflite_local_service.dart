import 'dart:developer';

import 'package:lmg_todo/data/service/local_service/sql/todo/todo_oncreate_db.dart';
import 'package:sqflite/sqflite.dart' as sql;

class LocalService {
  static const _databaseName = "lmg_todo.db";
  static const _databaseVersion = 1;
  static sql.Database? _database;

  Future<sql.Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<sql.Database?> _initDatabase() async {
    var databasesPath = await sql.getDatabasesPath();
    String path = '$databasesPath/$_databaseName';

    return await sql.openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (sql.Database db, int version) async =>
          await TodoSql.onCreate(db),
    );
  }

  /// Get data from sql
  Future<List<Map<String, Object?>>> rawQuery(
    String query, [
    List<Object?>? listParams,
  ]) async {
    try {
      final db = await database;
      return await db.rawQuery(query, listParams);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Get data from sql
  Future<List<Map<String, Object?>>> query(
    String query, {
    int? limit,
    int? offset,
    String? groupBy,
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? having,
    String? orderBy,
  }) async {
    try {
      final db = await database;
      return await db.query(
        query,
        limit: limit,
        offset: offset,
        groupBy: groupBy,
        columns: columns,
        distinct: distinct,
        having: having,
        orderBy: orderBy,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// insert data
  Future insert(String table, Map<String, dynamic> map) async {
    try {
      final db = await database;
      final id = await db.insert(table, map);
      log('inserted connecton id-> $id');
    } catch (e) {
      log('insert = > ${e.toString()}');
      rethrow;
    }
  }

  // insert data
  Future<int> rawInsert(String query, [List<Object?>? listParams]) async {
    try {
      final db = await database;
      final id = await db.rawInsert(query, listParams);
      log('inserted connecton id-> $id');
      return id;
    } catch (e) {
      log('insert = > ${e.toString()}');
      rethrow;
    }
  }

  // update data
  /// table -> 'name'
  /// map -> {'key': 'value','key': 'value'}
  /// where -> 'id = ?'
  /// whereArgs -> [1234]
  Future update(
    String table,
    Map<String, dynamic> map,
    String? where,
    List<Object?>? whereArgs,
  ) async {
    try {
      final db = await database;
      return await db.update(table, map);
    } catch (e) {
      log('update = > ${e.toString()}');
      rethrow;
    }
  }

  /// 'UPDATE Test SET name = ?, value = ? WHERE name = ?',
  ///  ['updated name', '9876', 'some name'];
  Future<int> rawUpdate(String query, [List<Object?>? listParam]) async {
    try {
      final db = await database;
      final rawAffected = await db.rawUpdate(query, listParam);
      log('no of raw affected -> $rawAffected');
      return rawAffected;
    } catch (e) {
      log('update = > ${e.toString()}');
      rethrow;
    }
  }

  Future<int> rawDelete(String query, [List<Object?>? listParams]) async {
    try {
      final db = await database;
      final rowaffected = await db.rawDelete(query, listParams);
      return rowaffected;
    } catch (e) {
      log('rawDelete = > ${e.toString()}');
      rethrow;
    }
  }

  Future<int> delete(String query) async {
    try {
      final db = await database;
      return await db.delete(query);
    } catch (e) {
      log('delete = > ${e.toString()}');
      rethrow;
    }
  }

  /// check a value is present or not in table
  /// eg query 'SELECT COUNT(*) FROM users WHERE email = ?', listParams ['example']
  Future<bool> presentOrNot(String query, List<Object?>? listParams) async {
    try {
      final db = await database;
      final count = sql.Sqflite.firstIntValue(
        await db.rawQuery(query, listParams),
      );
      if (count != null && count > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('presentOrNot = > ${e.toString()}');
      rethrow;
    }
  }
}

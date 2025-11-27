import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lmg_todo/data/service/local_service/sqflite_local_service.dart';
import 'package:lmg_todo/data/service/local_service/sql/todo/todo_oncreate_db.dart';
import 'package:lmg_todo/domain/models/commen/failure/failure.dart';
import 'package:lmg_todo/domain/models/commen/success_responce/success_responce.dart';
import 'package:lmg_todo/domain/models/todo/todo_details/todo_details.dart';
import 'package:lmg_todo/domain/repository/todo_repo.dart';

class TodoService implements TodoLocalRepo {
  final LocalService localService = LocalService();
  @override
  Future<Either<Failure, SuccessResponce>> addTodoToLocalStorage({
    required TodoDetails todoDetails,
  }) async {
    try {
      await localService.insert(TodoSql.todosTable, todoDetails.toMap());

      return Right(SuccessResponce(message: "Todo Added Successfully"));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoDetails>>> getTodoFromLocalStorage() async {
    try {
      const query =
          "SELECT * FROM ${TodoSql.todosTable} ORDER BY ${TodoDetails.colTodoLocalId} DESC";

      final data = await localService.rawQuery(query);
      log('ALL TODOS : $data');

      final todos = data.map((e) => TodoDetails.fromMap(e)).toList();

      return Right(todos);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SuccessResponce>> deleteTodo(int todoId) async {
    try {
      const query =
          '''
      DELETE FROM ${TodoSql.todosTable}
      WHERE ${TodoDetails.colTodoLocalId} = ?
      ''';

      await localService.rawDelete(query, [todoId]);

      return Right(SuccessResponce(message: "Todo Deleted Successfully"));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SuccessResponce>> updateTodoInLocalStorage(
    TodoDetails todoDetails,
  ) async {
    try {
      final map = todoDetails.toMap();
      map.remove(TodoDetails.colTodoLocalId);
      final int updated = await localService.update(
        TodoSql.todosTable,
        map,
        "${TodoDetails.colTodoLocalId} = ?",
        [todoDetails.todoLocalId],
      );

      if (updated > 0) {
        return Right(SuccessResponce(message: "Todo Updated Successfully"));
      } else {
        return Left(Failure(message: "No rows updated — Todo not found"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

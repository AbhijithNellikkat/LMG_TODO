import 'package:lmg_todo/domain/models/commen/failure/failure.dart';
import 'package:lmg_todo/domain/models/commen/success_responce/success_responce.dart';
import 'package:dartz/dartz.dart';
import 'package:lmg_todo/domain/models/todo/todo_details/todo_details.dart';

abstract class TodoLocalRepo {
  Future<Either<Failure, SuccessResponce>> addTodoToLocalStorage({
    required TodoDetails todoDetails,
  });

  Future<Either<Failure, List<TodoDetails>>> getTodoFromLocalStorage();

  Future<Either<Failure, SuccessResponce>> deleteTodo(int todoId);
  Future<Either<Failure, SuccessResponce>> updateTodoInLocalStorage(
    TodoDetails todoDetails,
  );
}

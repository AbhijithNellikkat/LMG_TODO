import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:lmg_todo/application/controller/todo_controller.dart';
import 'package:lmg_todo/domain/models/todo/todo_details/todo_details.dart';

class TodoDetailsController extends GetxController {
  final TodoController todoController = Get.find<TodoController>();

  late Rx<TodoDetails> todo;
  Timer? timer;

  // Track when to save to DB (every 5 seconds instead of every second)
  int _ticksSinceLastSave = 0;
  static const int _saveInterval = 5; // Save every 5 seconds

  @override
  void onInit() {
    super.onInit();
    // Get the todo passed as argument
    todo = (Get.arguments as TodoDetails).obs;
  }

  String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void startTimer() {
    if (todo.value.isRunning) return;

    // Update local state
    todo.update((val) {
      val?.isRunning = true;
      val?.status = 'In-Progress';
      val?.updatedAt = DateTime.now();
    });

    // Update DB immediately when starting
    todoController.updateTodo(todo.value);
    _ticksSinceLastSave = 0;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (todo.value.remainingSeconds > 0) {
        // Update local state (UI updates immediately)
        todo.update((val) {
          val?.remainingSeconds--;
          val?.updatedAt = DateTime.now();
        });

        _ticksSinceLastSave++;

        // Save to DB every 5 seconds OR on the last second
        if (_ticksSinceLastSave >= _saveInterval ||
            todo.value.remainingSeconds == 0) {
          todoController.updateTodo(todo.value);
          _ticksSinceLastSave = 0;
        }
      } else {
        t.cancel();

        // Update local state
        todo.update((val) {
          val?.isRunning = false;
          val?.status = "Completed";
          val?.updatedAt = DateTime.now();
        });

        // Update DB: completed
        todoController.updateTodo(todo.value);
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();

    // Update local state
    todo.update((val) {
      val?.isRunning = false;
      val?.updatedAt = DateTime.now();
    });

    // Save current state to DB
    todoController.updateTodo(todo.value);
    _ticksSinceLastSave = 0;
  }

  void stopTimer() {
    timer?.cancel();

    // Update local state
    todo.update((val) {
      val?.isRunning = false;
      val?.remainingSeconds = val.totalSeconds;
      val?.status = 'TODO';
      val?.updatedAt = DateTime.now();
    });

    // Update DB
    todoController.updateTodo(todo.value);
    _ticksSinceLastSave = 0;
  }

  @override
  void onClose() {
    timer?.cancel();

    // Save final state before closing if timer was running
    if (todo.value.isRunning || _ticksSinceLastSave > 0) {
      todo.update((val) {
        val?.isRunning = false;
        val?.updatedAt = DateTime.now();
      });
      todoController.updateTodo(todo.value);
    }

    super.onClose();
  }
}

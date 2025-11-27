import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:lmg_todo/todo%20app%20/application/controller/todo_controller.dart';
import 'package:lmg_todo/todo%20app%20/domain/models/todo/todo_details/todo_details.dart';

class TodoDetailsController extends GetxController {
  final TodoController todoController = Get.find<TodoController>();

  late Rx<TodoDetails> todo;
  Timer? timer;

  // Track when to save to DB (every 5 seconds)
  int _ticksSinceLastSave = 0;
  static const int _saveInterval = 5;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args == null || args is! TodoDetails) {
      log("TodoDetailsController received null/invalid arguments");
      return;
    }

    todo = args.obs;
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
      val?.status = 'In-PROGRESS';
      val?.updatedAt = DateTime.now();
    });

    // Update DB immediately when starting
    todoController.updateTodo(todo.value);
    _ticksSinceLastSave = 0;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (todo.value.remainingSeconds > 0) {
        todo.update((val) {
          val?.remainingSeconds--;
          val?.updatedAt = DateTime.now();
        });

        _ticksSinceLastSave++;

        // Save to DB
        if (_ticksSinceLastSave >= _saveInterval ||
            todo.value.remainingSeconds == 0) {
          todoController.updateTodo(todo.value);
          _ticksSinceLastSave = 0;
        }
      } else {
        t.cancel();

        todo.update((value) {
          value?.isRunning = false;
          value?.status = "COMPLETED";
          value?.updatedAt = DateTime.now();
        });

        todoController.updateTodo(todo.value);
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();

    todo.update((value) {
      value?.isRunning = false;
      value?.status = 'PAUSE';
      value?.updatedAt = DateTime.now();
    });

    // Save to DB
    todoController.updateTodo(todo.value);
    _ticksSinceLastSave = 0;
  }

  void stopTimer() {
    timer?.cancel();

    todo.update((value) {
      value?.isRunning = false;
      value?.remainingSeconds = value.totalSeconds;
      value?.status = 'TODO';
      value?.updatedAt = DateTime.now();
    });

    todoController.updateTodo(todo.value);
    _ticksSinceLastSave = 0;
  }

  @override
  void onClose() {
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

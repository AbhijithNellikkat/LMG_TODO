import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/colors.dart';
import 'package:lmg_todo/todo%20app%20/application/presentation/utils/tost/flutter_tost.dart';
import 'package:lmg_todo/todo%20app%20/data/service/todo/todo_service.dart';
import 'package:lmg_todo/todo%20app%20/domain/models/todo/todo_details/todo_details.dart';

class TodoController extends GetxController {
  final TodoService service = TodoService();

  // Reactive state variables
  final RxList<TodoDetails> todos = <TodoDetails>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;
  final RxInt deletingTodoId = 0.obs;
  final RxBool isSaving = false.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController searchCtrl = TextEditingController();
  final RxString searchQuery = ''.obs;

  // Text Controllers
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController minCtrl = TextEditingController(text: "0");
  final TextEditingController secCtrl = TextEditingController(text: "0");

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    minCtrl.dispose();
    secCtrl.dispose();
    searchCtrl.dispose();
    super.onClose();
  }

  // Load todos from local db
  Future<void> loadTodos() async {
    isLoading.value = true;

    try {
      final response = await service.getTodoFromLocalStorage();
      response.fold(
        (failure) {
          log("Error loading todos: ${failure.message}");
        },
        (success) {
          todos.value = success;
        },
      );
    } catch (e) {
      log("Exception loading todos: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<TodoDetails> get filteredTodos {
    if (searchQuery.isEmpty) return todos;

    final query = searchQuery.value.toLowerCase();

    return todos.where((t) {
      return t.title.toLowerCase().contains(query) ||
          t.description.toLowerCase().contains(query);
    }).toList();
  }

  // Save new todo to local db
  Future<void> addTodo() async {
    if (!formKey.currentState!.validate()) return;

    int minutes = int.tryParse(minCtrl.text) ?? 0;
    int seconds = int.tryParse(secCtrl.text) ?? 0;
    int totalSeconds = (minutes * 60) + seconds;

    // Validation
    if (totalSeconds == 0) {
      showCustomToast(
        message: 'Please set a timer greater than 0 seconds',
        backgroundColor: kErrorRed,
      );
      return;
    }

    if (totalSeconds > 300) {
      showCustomToast(
        message: "Maximum allowed timer is 5 minutes (5:00)",
        backgroundColor: kErrorRed,
      );
      return;
    }

    if (minutes == 5 && seconds > 0) {
      showCustomToast(
        message: 'Maximum time can only be exactly 5:00 minutes',
        backgroundColor: kErrorRed,
      );
      return;
    }

    isSaving.value = true;

    try {
      final todo = TodoDetails(
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
        totalSeconds: totalSeconds,
        remainingSeconds: totalSeconds,
        status: 'TODO',
        isRunning: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final response = await service.addTodoToLocalStorage(todoDetails: todo);

      response.fold(
        (failure) {
          log("Error adding: ${failure.message}");
          showCustomToast(
            message: "Oops! Could not add your todo. Please try again.",
            backgroundColor: kErrorRed,
          );
        },
        (success) {
          Get.back();
          clearAllTextEditingController();
          loadTodos();
          showCustomToast(message: "Todo added successfully");
        },
      );
    } catch (e) {
      log("Exception adding todo: $e");
    } finally {
      isSaving.value = false;
    }
  }

  void clearAllTextEditingController() {
    titleCtrl.clear();
    descCtrl.clear();
    minCtrl.text = "";
    secCtrl.text = "";
  }

  // Delete todo from local db
  Future<void> deleteTodo(TodoDetails todo) async {
    if (todo.todoLocalId == null) return;

    deletingTodoId.value = todo.todoLocalId ?? 0;

    try {
      final response = await service.deleteTodo(todo.todoLocalId!);

      response.fold(
        (failure) {
          log("Error deleting: ${failure.message}");

          showCustomToast(
            message: "Oops! Could not delete the todo. Please try again.",
            backgroundColor: kErrorRed,
          );
        },
        (success) {
          todos.removeWhere((t) => t.todoLocalId == todo.todoLocalId);
          showCustomToast(message: 'Todo deleted successfully');
        },
      );
    } catch (e) {
      log("Exception deleting todo: $e");
    } finally {
      deletingTodoId.value = 0;
    }
  }

  // Update todo in local db
  Future<void> updateTodo(TodoDetails todo) async {
    try {
      todo.updatedAt = DateTime.now();

      final response = await service.updateTodoInLocalStorage(todo);

      response.fold(
        (failure) {
          log("Failed to update todo: ${failure.message}");

          showCustomToast(
            message: "Oops! Could not update the todo. Please try again.",
            backgroundColor: kErrorRed,
          );
        },
        (success) {
          int index = todos.indexWhere(
            (t) => t.todoLocalId == todo.todoLocalId,
          );
          if (index != -1) {
            todos[index] = todo;
            todos.refresh();
          }
          log("Updated Todo: ${todo.title}");
        },
      );
    } catch (e) {
      log("Exception updating todo: $e");
    }
  }
}

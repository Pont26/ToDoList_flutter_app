import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/models/todo.dart';

class TaskController extends GetxController {
  // 1. Reactive state that the UI listens to
  RxList<Todo> tasks = RxList<Todo>();
  final AppDb _db = AppDb.instance;

  @override
  void onInit() {
    super.onInit();
    _db.database; // Access the getter to ensure DB is initialized
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final todos = await _db.queryAllTodos();
    tasks.assignAll(todos);
  }

  Future<void> addTask(String title) async {
    final newTodo = Todo(title: title);
    final id = await _db.insertTodo(newTodo);
    if (id > 0) {
      newTodo.id = id;
      tasks.insert(0, newTodo);

      Get.snackbar(
        "Success 🎉",
        "Task '$title' created and added to list!",
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        "DB Error 🚨",
        "Failed to save task to database.",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> toggleTaskDone(Todo task) async {
    task.isDone = !task.isDone;
    task.updatedAt = DateTime.now();
    await _db.updateTodo(task);
    tasks.refresh();
    tasks.sort((a, b) => (a.isDone == b.isDone)
        ? b.updatedAt.compareTo(a.updatedAt)
        : (a.isDone ? 1 : -1));
  }

  Future<void> deleteTask(Todo task) async {
    try {
      final rowsAffected = await _db.deleteTodo(task.id);
      if (rowsAffected > 0) {
        tasks.removeWhere((t) => t.id == task.id);
      } else {
        Get.snackbar(
          'Error',
          'Task could not be deleted.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade600,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        duration: const Duration(seconds: 2),
      );
    }
  }
}

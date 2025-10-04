import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/database.dart';
import 'package:todo_app/models/todo.dart';

class TaskEditController extends GetxController {
  final Todo originalTask;
  late TextEditingController titleTextController;

  // DB instance
  final AppDb _db = AppDb.instance;

  TaskEditController({required this.originalTask}) {
    titleTextController = TextEditingController(text: originalTask.title);
  }

  @override
  void onClose() {
    titleTextController.dispose();
    super.onClose();
  }

  Future<bool> updateTask(String newTitle) async {
    if (originalTask.id == null) return false;
    originalTask.title = newTitle.trim();
    originalTask.updatedAt = DateTime.now();
    final rowsAffected = await _db.updateTodo(originalTask);
    return rowsAffected > 0;
  }

  Future<bool> saveChanges() async {
    final newTitle = titleTextController.text.trim();

    if (newTitle.isEmpty || newTitle == originalTask.title) {
      return false; 
    }

    return await updateTask(newTitle);
  }
}

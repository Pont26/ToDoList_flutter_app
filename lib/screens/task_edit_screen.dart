import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_edit_controller.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/home_screen.dart';

class TaskEditScreen extends StatelessWidget {
  final Todo task;

  final TaskEditController controller;

  TaskEditScreen({super.key, required this.task})
      : controller = Get.put(TaskEditController(originalTask: task));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FB),
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: const Color(0xFF8FA8B5),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Task ID: ${task.id ?? 'N/A'}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: controller.titleTextController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                    hintText: "Enter the new task title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _saveTask(),
                  autofocus: true,
                ),

                const SizedBox(height: 16),

                // Save Button
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8FA8B5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveTask() async {
    final newTitle = controller.titleTextController.text.trim();

    // Validation
    if (newTitle.isEmpty) {
      Get.snackbar(
        'Validation',
        'Task title cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
      return;
    }

    if (newTitle == controller.originalTask.title) {
      Get.snackbar(
        'No Change',
        'No changes detected.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade600,
        colorText: Colors.white,
      );
      return;
    }

    bool success = await controller.saveChanges();
    if (success) {
      Get.snackbar(
        "Success ✅",
        "Task updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1000),
      );

      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.off(HomeScreen()); 
      });
    } else {
      Get.snackbar(
        "Error ❌",
        "Failed to update task.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/task_controller.dart';

class TaskCreationScreen extends StatelessWidget {
  TaskCreationScreen({super.key});

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController taskTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FB),
      appBar: AppBar(
        title: const Text("Create Task"),
        backgroundColor: const Color(0xFF8FA8B5),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: taskTextController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: "Enter task name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    String title = taskTextController.text.trim();
                    if (title.isNotEmpty) {
                      taskController.addTask(title);
                      taskTextController.clear();
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please enter a task name",
                        backgroundColor: Colors.red.shade600,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8FA8B5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                   
                  ),
                  child: const Text(
                    "Add Task",
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
}

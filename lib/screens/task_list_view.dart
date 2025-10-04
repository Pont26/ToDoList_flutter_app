import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/screens/task_edit_screen.dart'; 

class TaskListView extends StatelessWidget {
  
  TaskListView({super.key});

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('d MMM yyyy');
    final Color deleteColor = Theme.of(context).colorScheme.error;

    return SafeArea(
      
      child: Container(
        
        color: const Color(0xFFF0F9FB),
        
        child: RefreshIndicator(
          onRefresh: taskController.fetchTasks, 
          child: ListView(
            padding: const EdgeInsets.only(top: 16.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Center(child: Image.asset("./image/welcome.png", height: 120)),
                  const SizedBox(height: 25),
                  const Text("Your Tasks",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Divider(height: 30, thickness: 1),
                ],
              ),

              Obx(() {
                final tasks = taskController.tasks;

                if (tasks.isEmpty) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("No tasks found! Go add a new one.",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...tasks.mapIndexed((index, task) {
                      return Dismissible(
                        key: ValueKey(task.id), 
                        
                        // Background for Delete action (Remains red)
                        background: Container(
                          color: deleteColor, 
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              SizedBox(width: 8),
                              Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          color: deleteColor, 
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.delete, color: Colors.white),
                            ],
                          ),
                        ),
                        
                        onDismissed: (direction) {
                          taskController.deleteTask(task);
                        },

                        // The list item (Card) remains white/default for contrast
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: ListTile(
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (bool? newValue) {
                                taskController.toggleTaskDone(task);
                              },
                              activeColor: Colors.blue,
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration:
                                    task.isDone ? TextDecoration.lineThrough : null,
                                color: task.isDone ? Colors.grey : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              formatter.format(task.updatedAt),
                              style: const TextStyle(fontSize: 10),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Get.to(() => TaskEditScreen(task: task));
                            },
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 50),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
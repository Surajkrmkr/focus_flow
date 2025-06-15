import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:focus_flow/presentation/controllers/task_controller.dart';
import 'package:focus_flow/data/models/task_model.dart';
import 'package:focus_flow/presentation/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    final AuthController authController = Get.find();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Obx(() {
      final user = authController.currentUser.value;
      if (user != null && taskController.tasks.isEmpty) {
        taskController.loadTasks(user.uid);
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('FocusFlow Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => authController.logout(),
            ),
          ],
        ),
        body: Obx(() {
          if (taskController.tasks.isEmpty) {
            return const Center(child: Text('No tasks yet.'));
          }
          return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              final TaskModel task = taskController.tasks[index];
              return ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    taskController.updateTask(
                      task.copyWith(isCompleted: value),
                    );
                  },
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.description,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(task.createdAt.toLocal().toString().split(' ')[0]),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => taskController.deleteTask(task.id),
                ),
                onTap: () {
                  titleController.text = task.title;
                  descriptionController.text = task.description;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Edit Task'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            taskController.updateTask(
                              task.copyWith(
                                title: titleController.text,
                                description: descriptionController.text,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            titleController.clear();
            descriptionController.clear();
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final title = titleController.text.trim();
                      final description = descriptionController.text.trim();

                      if (title.isEmpty || description.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Both title and description are required',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }

                      final newTask = TaskModel(
                        id: '',
                        title: title,
                        description: description,
                        createdAt: DateTime.now(),
                        isCompleted: false,
                      );

                      taskController.addTask(newTask);
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

extension on TaskModel {
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

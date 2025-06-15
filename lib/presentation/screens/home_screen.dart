import 'package:flutter/material.dart';
import 'package:focus_flow/data/models/export.dart';
import 'package:focus_flow/presentation/controllers/export.dart';
import 'package:focus_flow/presentation/widgets/export.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TaskController taskController = Get.put(TaskController());
  final AuthController authController = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _showTaskDialog({
    required BuildContext context,
    TaskModel? task,
    required void Function(String, String) onSave,
  }) {
    titleController.text = task?.title ?? '';
    descriptionController.text = task?.description ?? '';

    showDialog(
      context: context,
      builder: (_) => TaskDialog(
        title: task == null ? 'Add Task' : 'Edit Task',
        initialTitle: task?.title ?? '',
        initialDescription: task?.description ?? '',
        onSave: (newTitle, newDesc) {
          if (task != null) {
            taskController.updateTask(
              task.copyWith(title: newTitle, description: newDesc),
            );
          } else {
            final newTask = TaskModel(
              id: '',
              title: newTitle,
              description: newDesc,
              createdAt: DateTime.now(),
              isCompleted: false,
            );
            taskController.addTask(newTask);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          final tasks = taskController.tasks;
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks yet.'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
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
                        maxLines: 1,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(task.createdAt.toLocal().toString().split(' ')[0]),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => taskController.deleteTask(task.id),
                ),
                onTap: () {
                  _showTaskDialog(
                    context: context,
                    task: task,
                    onSave: (title, desc) {
                      taskController.updateTask(
                        task.copyWith(title: title, description: desc),
                      );
                    },
                  );
                },
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showTaskDialog(
              context: context,
              onSave: (title, desc) {
                final newTask = TaskModel(
                  id: '',
                  title: title,
                  description: desc,
                  createdAt: DateTime.now(),
                  isCompleted: false,
                );
                taskController.addTask(newTask);
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

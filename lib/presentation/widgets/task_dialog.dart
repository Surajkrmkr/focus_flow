import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDialog extends StatelessWidget {
  final String title;
  final String initialTitle;
  final String initialDescription;
  final void Function(String title, String description) onSave;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TaskDialog({
    super.key,
    required this.title,
    required this.initialTitle,
    required this.initialDescription,
    required this.onSave,
  }) {
    titleController.text = initialTitle;
    descriptionController.text = initialDescription;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
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
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
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

            onSave(title, description);
            Get.back();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

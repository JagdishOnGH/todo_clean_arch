import 'package:flutter/material.dart';

import '../../domain/entity/task.dart';

/// Displays a dialog for updating an existing task.

Future<void> updateTaskDialog({
  required BuildContext context,
  required Task task,
  required void Function(Task updatedTask) onSubmit,
}) {
  final titleController = TextEditingController(text: task.title);
  final descController = TextEditingController(text: task.description ?? '');
  TaskPriority selectedPriority = task.priority;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Edit Task'),
        alignment: Alignment.center,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 400,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<TaskPriority>(
              value: selectedPriority,
              decoration: const InputDecoration(
                labelText: 'Priority *',
                border: OutlineInputBorder(),
              ),
              items: TaskPriority.values
                  .map(
                    (priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority.asString),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  selectedPriority = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(); // Cancel
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updated = task.copyWith(
                title: titleController.text.trim(),
                description: descController.text.trim().isEmpty
                    ? null
                    : descController.text.trim(),
                priority: selectedPriority,
              );
              onSubmit(updated);
              Navigator.of(context, rootNavigator: true).pop(); // Submit
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}

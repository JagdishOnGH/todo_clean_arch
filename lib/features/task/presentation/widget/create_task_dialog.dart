import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/task/domain/entity/task.dart';

import '../bloc/task_bloc/task_bloc.dart';
import '../bloc/task_bloc/task_event.dart';

Future<void> showTaskFormDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  TaskPriority selectedPriority = TaskPriority.medium;

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Add Task"),
      content: StatefulBuilder(
        builder: (context, setState) => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Title TextField (Required)
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? 'Title is required'
                        : null,
                  ),
                  const SizedBox(height: 18),

                  /// Description TextField (Optional)
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 18),

                  /// Priority Dropdown (Required)
                  DropdownButtonFormField<TaskPriority>(
                    value: selectedPriority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: TaskPriority.values.map((priority) {
                      return DropdownMenuItem<TaskPriority>(
                        value: priority,
                        child: Text(priority.asString),
                      );
                    }).toList(),
                    onChanged: (val) => setState(
                        () => selectedPriority = val ?? TaskPriority.medium),
                    validator: (val) =>
                        val == null ? 'Priority is required' : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final Task task = Task(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  createdAt: DateTime.now(),
                  description: descController.text,
                  priority: selectedPriority);
              context.read<TaskBloc>().add(AddTaskEvent(task));

              Navigator.of(context).pop();
              // Handle newTask with Bloc or Provider (emit event or call notifier)
            }
          },
          child: const Text("Submit"),
        ),
      ],
    ),
  );
}

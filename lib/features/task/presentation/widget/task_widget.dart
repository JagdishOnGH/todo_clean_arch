import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_clean_arch/core/extentions/on_build_context.dart';
import 'package:todo_clean_arch/features/task/presentation/widget/update_task_dialog.dart';

import '../../domain/entity/task.dart';
import '../bloc/task_bloc/task_bloc.dart';
import '../bloc/task_bloc/task_event.dart';
import 'delete_task_dialog.dart';

/// This widget displays a single task with its details and provides options to update or delete it.
class TaskWidget extends StatelessWidget {
  final Task task;

  final VoidCallback? onToggleComplete;

  const TaskWidget({
    super.key,
    required this.task,
    this.onToggleComplete,
  });

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.orangeAccent;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor =
        _getPriorityColor(task.priority).withValues(alpha: 0.2);
    final textTheme = context.textTheme;
    final theme = context.theme;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: ExpansionTile(
        backgroundColor: priorityColor,
        collapsedBackgroundColor: priorityColor,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        leading: IconButton(
          onPressed: () {
            final toggledTask = task.copyWith(
              isCompleted: !task.isCompleted,
            );
            context.read<TaskBloc>().add(
                  ToggleTaskCompletionEvent(toggledTask),
                );
          },
          icon: Icon(
            task.isCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: task.isCompleted ? Colors.green : Colors.grey,
          ),
        ),
        title: Text(task.title,
            style: textTheme.titleSmall?.copyWith(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            )),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        _getPriorityColor(task.priority).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    task.priority.name.toUpperCase(),
                    style: TextStyle(
                      color: _getPriorityColor(task.priority),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(task.createdAt),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          if (task.description != null && task.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                task.description!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //outlinedBtn
                FilledButton.icon(
                  icon: Icon(Icons.edit_note),
                  onPressed: () {
                    updateTaskDialog(
                        context: context,
                        task: task,
                        onSubmit: (updatedTask) {
                          context
                              .read<TaskBloc>()
                              .add(UpdateTaskEvent(updatedTask));
                        });
                  },
                  label: const Text("Update"),
                ),
                //deleteBtn
                FilledButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                  ),
                  onPressed: () async {
                    await showDeleteDialog(
                      context: context,
                      onConfirm: () {
                        context.read<TaskBloc>().add(DeleteTaskEvent(task));
                      },
                      title: task.title,
                    );
                  },
                  label: const Text("Delete"),
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

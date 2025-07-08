import '../../../domain/entity/task.dart';

sealed class TaskEvent {
  const TaskEvent();
}

// This event is used to load all tasks from the repository

class LoadAllTaskEvent extends TaskEvent {
  const LoadAllTaskEvent();
}

// These events are used to add, delete, update, toggle completion status,
class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);
}

// and filter tasks based on their completion status.

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  const DeleteTaskEvent(this.task);
}

//update task event to update
class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);
}

//// This event is used to toggle the completion status of a task

class ToggleTaskCompletionEvent extends TaskEvent {
  final Task task;

  const ToggleTaskCompletionEvent(this.task);
}

//// This event is used to filter tasks based on their completion status

class FilterTasksEvent extends TaskEvent {
  final bool? isCompleted;

  const FilterTasksEvent(
    this.isCompleted,
  );
}

class SortByNewestFirstEvent extends TaskEvent {
  final bool isNewestFirst;

  const SortByNewestFirstEvent({
    this.isNewestFirst = true,
  });
}

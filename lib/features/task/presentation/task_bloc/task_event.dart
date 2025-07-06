import '../../domain/entity/task.dart';

sealed class TaskEvent {
  const TaskEvent();
}

class LoadAllTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  const DeleteTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);
}

class ToggleTaskCompletionEvent extends TaskEvent {
  final Task task;

  const ToggleTaskCompletionEvent(this.task);
}

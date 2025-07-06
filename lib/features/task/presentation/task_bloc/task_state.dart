import '../../domain/entity/task.dart';

sealed class TaskState {
  const TaskState();
}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  const TaskLoadedState(this.tasks);
}

class TaskOperationErrorState extends TaskState {
  final String message;
  final List<Task> tasks;

  const TaskOperationErrorState(this.message, {required this.tasks});
}

class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);
}

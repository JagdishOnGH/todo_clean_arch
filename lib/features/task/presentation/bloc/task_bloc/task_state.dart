import '../../../domain/entity/task.dart';

sealed class TaskState {
  const TaskState();
}

// Initial state when the task module is loaded
class TaskInitialState extends TaskState {}

// State when tasks are being loaded, typically shown while fetching data
class TaskLoadingState extends TaskState {}

// State when tasks are successfully loaded, contains a list of tasks
class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  const TaskLoadedState(this.tasks);
}

//when a task is added, deleted, updated, or toggled if error occurs that wont show error in main page
class TaskOperationErrorState extends TaskState {
  final String message;
  final List<Task> tasks;

  const TaskOperationErrorState(this.message, {required this.tasks});
}

//when loading all tasks if error occurs that will show error in main page
class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);
}

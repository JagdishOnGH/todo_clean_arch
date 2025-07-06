import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/task/presentation/task_bloc/task_event.dart';
import 'package:todo_clean_arch/features/task/presentation/task_bloc/task_state.dart';

import '../../domain/entity/task.dart';
import '../../domain/usecase/create_task_usecase.dart';
import '../../domain/usecase/delete_task_usecase.dart';
import '../../domain/usecase/get_all_tasks_usecase.dart';
import '../../domain/usecase/toggle_task_usecase.dart';
import '../../domain/usecase/update_task_usecase.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  //ask for create, delete, update, toggle, getall usecases of domain
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final GetAllTasksUseCase getAllTasksUseCase;
  final ToggleTaskUseCase toggleTaskCompletionUseCase;

  TaskBloc({
    required this.createTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
    required this.getAllTasksUseCase,
    required this.toggleTaskCompletionUseCase,
  }) : super(TaskInitialState()) {
    on<LoadAllTaskEvent>(_onLoadAllTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<ToggleTaskCompletionEvent>(_onToggleTaskCompletion);
  }

  List<Task> allTasks = [];

  Future<void> _onLoadAllTasks(
      LoadAllTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    final result = await getAllTasksUseCase();
    if (result.isSuccess) {
      allTasks = result.value;
      emit(TaskLoadedState(result.value));
    } else {
      emit(TaskErrorState(result.error.message));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final result = await createTaskUseCase(event.task);
    if (result.isSuccess) {
      add(LoadAllTaskEvent());
    } else {
      emit(TaskOperationErrorState(
        result.error.message,
        tasks: allTasks,
      ));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final result = await deleteTaskUseCase(event.task);
    if (result.isSuccess) {
      add(LoadAllTaskEvent());
    } else {
      emit(TaskOperationErrorState(
        result.error.message,
        tasks: allTasks,
      ));
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    final result = await updateTaskUseCase(event.task);
    if (result.isSuccess) {
      add(LoadAllTaskEvent());
    } else {
      emit(TaskOperationErrorState(
        result.error.message,
        tasks: allTasks,
      ));
    }
  }

  Future<void> _onToggleTaskCompletion(
      ToggleTaskCompletionEvent event, Emitter<TaskState> emit) async {
    final result = await toggleTaskCompletionUseCase(event.task);
    if (result.isSuccess) {
      add(LoadAllTaskEvent());
    } else {
      emit(TaskOperationErrorState(
        result.error.message,
        tasks: allTasks,
      ));
    }
  }
}

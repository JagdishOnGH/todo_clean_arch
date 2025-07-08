import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/task.dart';
import '../../../domain/usecase/create_task_usecase.dart';
import '../../../domain/usecase/delete_task_usecase.dart';
import '../../../domain/usecase/get_all_tasks_usecase.dart';
import '../../../domain/usecase/toggle_task_usecase.dart';
import '../../../domain/usecase/update_task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

// TaskBloc that handles task-related events and states and calls to
// the use cases to perform operations on tasks.
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
    on<FilterTasksEvent>(_onFilterTasks);
    on<SortByNewestFirstEvent>(_onSortByNewestFirst);
  }

  List<Task> allTasks = [];

  bool? _isCompletedFilter;
  bool _isSortByNewest = true;

  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) {
    _isCompletedFilter = event.isCompleted;
    final filteredTasks = _applyFilterAndSort(
      allTasks: allTasks,
      isCompletedFilter: event.isCompleted,
      isSortByNewest: _isSortByNewest,
    );
    emit(TaskLoadedState(filteredTasks));
  }

  void _onSortByNewestFirst(
      SortByNewestFirstEvent event, Emitter<TaskState> emit) {
    _isSortByNewest = event.isNewestFirst;
    final sortedTasks = _applyFilterAndSort(
      allTasks: allTasks,
      isCompletedFilter: _isCompletedFilter,
      isSortByNewest: _isSortByNewest,
    );
    emit(TaskLoadedState(sortedTasks));
  }

  Future<void> _onLoadAllTasks(
      LoadAllTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    final result = await getAllTasksUseCase();
    if (result.isSuccess) {
      allTasks = result.value;
      emit(TaskLoadedState(result.value));
    } else {
      emit(TaskLoadFailureState(result.error.message));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final result = await createTaskUseCase(event.task);
    if (result.isSuccess) {
      add(LoadAllTaskEvent());
    } else {
      emit(TaskOperationFailureState(
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
      emit(TaskOperationFailureState(
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
      emit(TaskOperationFailureState(
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
      emit(TaskOperationFailureState(
        result.error.message,
        tasks: allTasks,
      ));
    }
  }

  List<Task> _applyFilterAndSort({
    required List<Task> allTasks,
    bool? isCompletedFilter,
    required bool isSortByNewest,
  }) {
    var filtered = allTasks;

    if (isCompletedFilter != null) {
      filtered =
          filtered.where((t) => t.isCompleted == isCompletedFilter).toList();
    }

    filtered.sort((a, b) => isSortByNewest
        ? b.createdAt.compareTo(a.createdAt)
        : a.createdAt.compareTo(b.createdAt));

    return filtered;
  }
}

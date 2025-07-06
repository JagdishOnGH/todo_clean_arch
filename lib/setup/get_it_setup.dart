import 'package:get_it/get_it.dart';
import 'package:todo_clean_arch/core/app_constants.dart';
import 'package:todo_clean_arch/features/task/data/datasources/local_task_data_source_impl.dart';
import 'package:todo_clean_arch/features/task/data/datasources/task_data_source.dart';
import 'package:todo_clean_arch/features/task/domain/usecase/update_task_usecase.dart';

import '../features/task/data/repository/task_repository_impl.dart';
import '../features/task/domain/repository/task_repository.dart';
import '../features/task/domain/usecase/create_task_usecase.dart';
import '../features/task/domain/usecase/delete_task_usecase.dart';
import '../features/task/domain/usecase/get_all_tasks_usecase.dart';
import '../features/task/domain/usecase/toggle_task_usecase.dart';
import '../features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'floor_setup.dart';

final sl = GetIt.instance;

/// This function sets up the GetIt service locator for dependency injection in the application.
Future<void> getItSetup() async {
  /// Registering the Floor database and its DAO
  final database = await $FloorAppDatabase
      .databaseBuilder(AppConstants.databaseName)
      .build();
  final taskDao = database.taskDao;

  /// Registering the service locator with all dependencies
  sl.registerSingleton<ITaskDataSource>(LocalTaskDataSourceImpl(taskDao));

  /// Registering the repository with its implementation
  sl.registerSingleton<ITaskRepository>(
      TaskRepositoryImpl(sl<ITaskDataSource>()));

  /// Registering use cases for task operations
  sl.registerSingleton<GetAllTasksUseCase>(
      GetAllTasksUseCase(sl<ITaskRepository>()));
  sl.registerSingleton<CreateTaskUseCase>(
      CreateTaskUseCase(sl<ITaskRepository>()));
  sl.registerSingleton<DeleteTaskUseCase>(
      DeleteTaskUseCase(sl<ITaskRepository>()));
  sl.registerSingleton<UpdateTaskUseCase>(
      UpdateTaskUseCase(sl<ITaskRepository>()));

  sl.registerSingleton<ToggleTaskUseCase>(
      ToggleTaskUseCase(sl<ITaskRepository>()));

  /// Registering the TaskBloc with its dependencies
  sl.registerFactory<TaskBloc>(() => TaskBloc(
        createTaskUseCase: sl<CreateTaskUseCase>(),
        deleteTaskUseCase: sl<DeleteTaskUseCase>(),
        updateTaskUseCase: sl<UpdateTaskUseCase>(),
        getAllTasksUseCase: sl<GetAllTasksUseCase>(),
        toggleTaskCompletionUseCase: sl<ToggleTaskUseCase>(),
      ));
}

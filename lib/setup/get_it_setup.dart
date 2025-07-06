import 'package:get_it/get_it.dart';
import 'package:todo_clean_arch/core/app_constants.dart';
import 'package:todo_clean_arch/features/task/data/datasources/local_task_data_source.dart';
import 'package:todo_clean_arch/features/task/data/datasources/task_data_source.dart';
import 'package:todo_clean_arch/features/task/domain/usecase/update_task_usecase.dart';

import '../features/task/data/repository/task_repository_impl.dart';
import '../features/task/domain/repository/task_repository.dart';
import '../features/task/domain/usecase/create_task_usecase.dart';
import '../features/task/domain/usecase/delete_task_usecase.dart';
import '../features/task/domain/usecase/get_all_tasks_usecase.dart';
import 'floor_setup.dart';

final sl = GetIt.instance;

Future<void> getItSetup() async {
  final database = await $FloorAppDatabase
      .databaseBuilder(AppConstants.databaseName)
      .build();
  final taskDao = database.taskDao;
  sl.registerSingleton<ITaskDataSource>(LocalTaskDataSourceImpl(taskDao));
  //repository
  sl.registerSingleton<ITaskRepository>(
      TaskRepositoryImpl(sl<ITaskDataSource>()));
  //getallusecase,
  sl.registerSingleton<GetAllTasksUseCase>(
      GetAllTasksUseCase(sl<ITaskRepository>()));
  sl.registerSingleton<CreateTaskUseCase>(
      CreateTaskUseCase(sl<ITaskRepository>()));
  sl.registerSingleton<DeleteTaskUseCase>(
      DeleteTaskUseCase(sl<ITaskRepository>()));
  sl.registerSingleton<UpdateTaskUseCase>(
      UpdateTaskUseCase(sl<ITaskRepository>()));
}

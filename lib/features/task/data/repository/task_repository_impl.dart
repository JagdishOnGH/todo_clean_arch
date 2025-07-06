import '../../../../core/domain/failures.dart';
import '../../../../core/domain/result.dart';
import '../../domain/entity/task.dart';
import '../../domain/repository/task_repository.dart';
import '../datasources/task_data_source.dart';
import '../model/task_model.dart';

//repository implementation for task management

class TaskRepositoryImpl implements ITaskRepository {
  final ITaskDataSource taskDataSource;

  const TaskRepositoryImpl(this.taskDataSource);

  @override
  Future<Result<bool, Failure>> deleteTask(Task task) async {
    try {
      final result =
          await taskDataSource.deleteTask(TaskModel.fromEntity(task));
      return Success(result);
    } catch (e) {
      return Error(CacheFailure("Failed to delete task: $e"));
    }
  }

  @override
  Future<Result<List<Task>, Failure>> getAllTasks() async {
    try {
      final taskModels = await taskDataSource.getAllTasks();
      final tasks = taskModels.map((model) => model.toEntity()).toList();
      return Success(tasks);
    } catch (e) {
      return Error(CacheFailure("Failed to fetch tasks: $e"));
    }
  }

  @override
  Future<Result<Task?, Failure>> getTaskById(int id) async {
    try {
      final taskModel = await taskDataSource.getTaskById(id);
      if (taskModel != null) {
        return Success(taskModel.toEntity());
      } else {
        return Success(null);
      }
    } catch (e) {
      return Error(CacheFailure("Failed to fetch task by id: $e"));
    }
  }

  @override
  Future<Result<bool, Failure>> updateTask(Task task) async {
    try {
      final result =
          await taskDataSource.updateTask(TaskModel.fromEntity(task));
      return Success(result);
    } catch (e) {
      return Error(CacheFailure("Failed to update task: $e"));
    }
  }

  @override
  Future<Result<bool, Failure>> createTask(Task task) async {
    try {
      final result = await taskDataSource.addTask(TaskModel.fromEntity(task));
      return Success(result);
    } catch (e) {
      return Error(CacheFailure("Failed to create task: $e"));
    }
  }
}

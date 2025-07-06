import 'package:todo_clean_arch/core/exceptions/exceptions.dart';
import 'package:todo_clean_arch/features/task/data/dao/task_dao.dart';
import 'package:todo_clean_arch/features/task/data/datasources/task_data_source.dart';
import 'package:todo_clean_arch/features/task/data/model/task_model.dart';

class LocalTaskDataSourceImpl implements ITaskDataSource {
  final TaskDao taskDao;

  const LocalTaskDataSourceImpl(this.taskDao);

  @override
  Future<bool> addTask(TaskModel task) async {
    try {
      await taskDao.addTask(task);
      return true;
    } catch (e) {
      throw CacheException("Failed to add task: $e");
    }
  }

  @override
  Future<bool> deleteTask(TaskModel task) async {
    try {
      await taskDao.deleteTask(task);
      return true;
    } catch (e) {
      throw CacheException("Failed to delete task: $e");
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() {
    try {
      return taskDao.getAllTasks();
    } catch (e) {
      throw CacheException("Failed to fetch tasks: $e");
    }
  }

  @override
  Future<TaskModel?> getTaskById(String id) {
    try {
      return taskDao.getTaskById(id);
    } catch (e) {
      throw CacheException("Failed to fetch task by id: $e");
    }
  }

  @override
  Future<bool> updateTask(TaskModel task) {
    try {
      taskDao.updateTask(task);
      return Future.value(true);
    } catch (e) {
      throw CacheException("Failed to update task: $e");
    }
  }
}

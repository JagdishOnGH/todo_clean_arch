import 'package:todo_clean_arch/core/exceptions/exceptions.dart';
import 'package:todo_clean_arch/features/task/data/datasources/task_data_source.dart';
import 'package:todo_clean_arch/features/task/data/model/task_model.dart';

class MockDataSource implements ITaskDataSource {
  List<TaskModel> tasks = [];

  @override
  Future<bool> addTask(TaskModel task) async {
    //if task has same id,  throw an error
    if (tasks.any((t) => t.id == task.id)) {
      throw CacheException("Task with id ${task.id} already exists.");
    }
    tasks.add(task);
    print("Task added: ${task.name}");
    print(tasks);
    return true;
  }

  @override
  Future<bool> deleteTask(TaskModel task) async {
    tasks.removeWhere((t) => t.id == task.id);
    return true;
  }

  @override
  Future<List<TaskModel>> getAllTasks() {
    return Future.value(tasks);
  }

  @override
  Future<TaskModel?> getTaskById(int id) async {
    final TaskModel? task = tasks.firstWhere(
      (t) => t.id == id,
    );
    return Future.value(task);
  }

  @override
  Future<bool> updateTask(TaskModel task) {
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      return Future.value(true);
    }
    return Future.value(false);
  }
}

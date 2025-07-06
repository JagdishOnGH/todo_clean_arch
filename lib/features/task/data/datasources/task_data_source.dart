import '../model/task_model.dart';

//abstract itaskdatasourc for better testing and dependency inversion
abstract class ITaskDataSource {
  Future<bool> addTask(TaskModel task);

  Future<bool> updateTask(TaskModel task);

  Future<bool> deleteTask(TaskModel task);

  Future<List<TaskModel>> getAllTasks();

  Future<TaskModel?> getTaskById(int id);
}

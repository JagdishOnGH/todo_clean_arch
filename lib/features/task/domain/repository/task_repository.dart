import 'package:todo_clean_arch/core/domain/result.dart';

import '../../../../core/domain/failures.dart';
import '../entity/task.dart';

abstract class ITaskRepository {
  Future<Result<List<Task>, Failure>> getAllTasks();

  Future<Result<Task?, Failure>> getTaskById(int id);

  Future<Result<bool, Failure>> createTask(Task task);

  Future<Result<bool, Failure>> updateTask(Task task);

  Future<Result<bool, Failure>> deleteTask(Task id);
}

import 'package:todo_clean_arch/core/domain/result.dart';

import '../../../../core/domain/failures.dart';
import '../entities/task.dart';

abstract class ITaskRepository {
  Future<Result<List<Task>, Failure>> getAllTasks();

  Future<Result<Task?, Failure>> getTaskById(String id);

  Future<Result<bool, Failure>> addTask(Task task);

  Future<Result<bool, Failure>> updateTask(Task task);

  Future<Result<bool, Failure>> deleteTask(String id);
}

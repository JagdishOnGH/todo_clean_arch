/*
  summary: Use case for updating a task.
 */

import '../../../../core/domain/failures.dart';
import '../../../../core/domain/result.dart';
import '../entity/task.dart';
import '../repository/task_repository.dart';

class UpdateTaskUseCase {
  final ITaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  Future<Result<bool, Failure>> call(Task task) async {
    return await _taskRepository.updateTask(task);
  }
}

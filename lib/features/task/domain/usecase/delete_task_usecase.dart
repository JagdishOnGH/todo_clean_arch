//delete usecase responsible for deleting a task from the repository

import '../../../../core/domain/failures.dart';
import '../../../../core/domain/result.dart';
import '../entity/task.dart';
import '../repository/task_repository.dart';

class DeleteTaskUseCase {
  final ITaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  Future<Result<bool, Failure>> call(Task task) async {
    final result = await _taskRepository.deleteTask(task);
    return result;
  }
}

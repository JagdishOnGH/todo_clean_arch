import '../../../../core/domain/failures.dart';
import '../../../../core/domain/result.dart';
import '../entity/task.dart';
import '../repository/task_repository.dart';

class ToggleTaskUseCase {
  final ITaskRepository _taskRepository;

  ToggleTaskUseCase(this._taskRepository);

  Future<Result<bool, Failure>> call(Task task) async {
    return await _taskRepository.updateTask(task);
  }
}

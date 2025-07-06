import '../../../../core/domain/failures.dart';
import '../../../../core/domain/result.dart';
import '../entity/task.dart';
import '../repository/task_repository.dart';

class CreateTaskUseCase {
  final ITaskRepository _taskRepository;

  CreateTaskUseCase(this._taskRepository);

  Future<Result<bool, Failure>> call(Task task) async {
    return await _taskRepository.createTask(task);
  }
}

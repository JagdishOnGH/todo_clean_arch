import '../../../../core/domain/failures.dart';
import '../../../../core/domain/result.dart';
import '../entity/task.dart';
import '../repository/task_repository.dart';

class GetAllTasksUseCase {
  final ITaskRepository _taskRepository;

  GetAllTasksUseCase(this._taskRepository);

  Future<Result<List<Task>, Failure>> call() async {
    return await _taskRepository.getAllTasks();
  }
}

import '../entity/task.dart';
import '../repository/task_repository.dart';

class ToggleTaskUseCase {
  final ITaskRepository _taskRepository;

  ToggleTaskUseCase(this._taskRepository);

  Future<void> call(Task task) async {
    await _taskRepository.updateTask(task);
  }
}

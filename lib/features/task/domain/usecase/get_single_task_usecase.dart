import 'package:todo_clean_arch/core/domain/failures.dart';
import 'package:todo_clean_arch/core/domain/result.dart';

import '../entity/task.dart';
import '../repository/task_repository.dart';

class GetSingleTaskUseCase {
  final ITaskRepository _taskRepository;

  GetSingleTaskUseCase(this._taskRepository);

  Future<Result<Task?, Failure>> call(int taskId) async {
    return await _taskRepository.getTaskById(taskId);
  }
}

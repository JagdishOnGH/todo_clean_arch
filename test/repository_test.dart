import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean_arch/features/task/data/model/task_model.dart';
import 'package:todo_clean_arch/features/task/data/repository/task_repository_impl.dart';
import 'package:todo_clean_arch/features/task/domain/entity/task.dart';
import 'package:todo_clean_arch/features/task/domain/repository/task_repository.dart';

import 'mock_data_source.dart';

final task1 = TaskModel(
  id: 1,
  name: 'Task 1',
  description: 'Description 1',
  createdAt: DateTime.now().millisecondsSinceEpoch,
  priority: 0,
);
final task2 = TaskModel(
  id: 2,
  name: 'Task 2',
  description: 'Description 2',
  createdAt: DateTime.now().millisecondsSinceEpoch,
  priority: 0,
);
final invalidTask1 = TaskModel(
  id: 3,
  name: 'Task 3',
  description: 'Description 3',
  createdAt: DateTime.now().millisecondsSinceEpoch,
  priority: 7,
);
final invalidTask2 = TaskModel(
  id: 4,
  name: 'Task 4',
  description: 'Description 4',
  createdAt: DateTime.now().millisecondsSinceEpoch,
  priority: -1,
);
final negativeDate = TaskModel(
  id: 5,
  name: 'Task 5',
  description: 'Description 5',
  createdAt: 1000000000000,
  //invalid date
  priority: 0,
);
//invalid- negative id
final invalidId = TaskModel(
  id: 0,
  name: 'Last Time Task',
  description: 'This task has an invalid ID',
  createdAt: DateTime.now().millisecondsSinceEpoch,
  priority: 0,
);

void main() {
  late ITaskRepository taskRepository;
  setUp(() {
    taskRepository = TaskRepositoryImpl(MockDataSource());
  });

  test('Add valid task', () async {
    final result = await taskRepository.updateTask(task1.toEntity());
    expect(result.isSuccess, true);
  });
  test('Add invalid task with invalid priority', () async {
    expect(
      () => taskRepository.updateTask(invalidTask1.toEntity()),
      throwsA(isA<ArgumentError>()),
    );
  });

  test("Success translation to entity with negative date", () {
    //expect model
    final task = negativeDate.toEntity();
    expect(task.runtimeType, Task);
  });
}

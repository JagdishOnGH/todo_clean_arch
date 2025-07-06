import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean_arch/core/exceptions/exceptions.dart';
import 'package:todo_clean_arch/features/task/data/model/task_model.dart';

import 'mock_data_source.dart'; // Update this with your real import

void main() {
  late MockDataSource dataSource;

  setUp(() {
    dataSource = MockDataSource();
  });
  final createdAt = DateTime.now().millisecondsSinceEpoch;

  final task1 = TaskModel(
      id: 1,
      name: 'Task 1',
      description: 'Description 1',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      priority: 0);
  final task2 = TaskModel(
      id: 2,
      name: 'Task 2',
      priority: 0,
      description: 'Description 2',
      createdAt: DateTime.now().millisecondsSinceEpoch);

  group('MockDataSource Tests', () {
    test('should add a new task successfully', () async {
      final result = await dataSource.addTask(task1);
      expect(result, true);

      final allTasks = await dataSource.getAllTasks();
      expect(allTasks.length, 1);
      expect(allTasks.first.id, task1.id);
    });

    test('should throw error when adding task with duplicate ID', () async {
      await dataSource.addTask(task1);

      expect(
        () async => await dataSource.addTask(task1),
        throwsA(isA<CacheException>().having(
          (e) => e.toString(),
          'message',
          contains('already exists'),
        )),
      );
    });

    test('should get a task by ID successfully', () async {
      await dataSource.addTask(task1);
      final fetchedTask = await dataSource.getTaskById(task1.id);

      expect(fetchedTask, isNotNull);
      expect(fetchedTask!.name, task1.name);
    });

    test('should throw when getting task by non-existent ID', () async {
      expect(
        () async => await dataSource.getTaskById(99),
        throwsA(isA<
            StateError>()), // because `firstWhere` without `orElse` throws StateError
      );
    });

    test('should return all added tasks', () async {
      await dataSource.addTask(task1);
      await dataSource.addTask(task2);

      final tasks = await dataSource.getAllTasks();
      expect(tasks.length, 2);
      expect(tasks.any((t) => t.id == task1.id), true);
      expect(tasks.any((t) => t.id == task2.id), true);
    });

    test('should update an existing task successfully', () async {
      await dataSource.addTask(task1);
      final updatedTask = TaskModel(
          id: 1,
          name: 'Updated Task 1',
          createdAt: createdAt,
          priority: 1,
          description: 'New Desc');

      final result = await dataSource.updateTask(updatedTask);
      expect(result, true);

      final fetchedTask = await dataSource.getTaskById(1);
      expect(fetchedTask!.name, 'Updated Task 1');
    });

    test('should return false when updating non-existent task', () async {
      final nonExistingTask = TaskModel(
          priority: 0,
          id: 999,
          name: 'Fake',
          description: 'Fake',
          createdAt: createdAt);
      final result = await dataSource.updateTask(nonExistingTask);
      expect(result, false);
    });

    test('should delete a task successfully', () async {
      await dataSource.addTask(task1);
      await dataSource.addTask(task2);

      final result = await dataSource.deleteTask(task1);
      expect(result, true);

      final tasks = await dataSource.getAllTasks();
      expect(tasks.length, 1);
      expect(tasks.first.id, task2.id);
    });

    test('deleting a non-existent task should not throw', () async {
      final result = await dataSource.deleteTask(TaskModel(
          id: 999,
          name: 'Ghost',
          description: 'None',
          createdAt: createdAt,
          priority: 0));
      expect(result, true); // still true per implementation
    });
  });
}

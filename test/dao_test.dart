import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean_arch/core/domain/failures.dart';
import 'package:todo_clean_arch/core/domain/result.dart';
import 'package:todo_clean_arch/features/task/data/dao/task_dao.dart';
import 'package:todo_clean_arch/features/task/data/datasources/local_task_data_source_impl.dart';
import 'package:todo_clean_arch/features/task/data/datasources/task_data_source.dart';
import 'package:todo_clean_arch/features/task/data/model/task_model.dart';
import 'package:todo_clean_arch/features/task/data/repository/task_repository_impl.dart';
import 'package:todo_clean_arch/features/task/domain/repository/task_repository.dart';
import 'package:todo_clean_arch/features/task/domain/usecase/create_task_usecase.dart';
import 'package:todo_clean_arch/setup/floor_setup.dart';

import 'repository_test.dart';

void main() {
  late AppDatabase database;
  late TaskDao taskDao;
  late ITaskDataSource dataSource;
  late ITaskRepository repository;

  setUp(() async {
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    taskDao = database.taskDao;
    dataSource = LocalTaskDataSourceImpl(taskDao);
  });

  tearDown(() async {
    await database.close();
  });

  final task1 = TaskModel(
    id: 1,
    name: 'Task 1',
    description: 'Description 1',
    isCompleted: false,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    priority: 1,
  );

  final task2 = TaskModel(
    id: 2,
    name: 'Task 2',
    description: null,
    isCompleted: true,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    priority: 2,
  );

  group('LocalTaskDataSourceImpl', () {
    test('should add a task successfully', () async {
      await dataSource.addTask(task1);
      final tasks = await dataSource.getAllTasks();
      expect(tasks.length, 1);
      expect(tasks.first.id, task1.id);
    });

    test('should throw error on duplicate insert', () async {
      await dataSource.addTask(task1);
      expect(
        () async => await dataSource.addTask(task1),
        throwsA(isA<Exception>()), // Floor will throw a SQLite exception
      );
    });

    test('should return all tasks', () async {
      await dataSource.addTask(task1);
      await dataSource.addTask(task2);

      final tasks = await dataSource.getAllTasks();
      expect(tasks.length, 2);
    });

    test('should return a task by ID', () async {
      await dataSource.addTask(task2);

      final task = await dataSource.getTaskById(task2.id);
      expect(task, isNotNull);
      expect(task!.name, task2.name);
    });

    test('should return null for non-existent task', () async {
      final task = await dataSource.getTaskById(999);
      expect(task, isNull);
    });

    test('should update a task successfully', () async {
      await dataSource.addTask(task1);

      final updatedTask = TaskModel(
        id: task1.id,
        name: 'Updated Task',
        description: 'Updated Desc',
        isCompleted: true,
        createdAt: task1.createdAt,
        priority: 1,
      );

      await dataSource.updateTask(updatedTask);

      final task = await dataSource.getTaskById(task1.id);
      expect(task!.name, 'Updated Task');
      expect(task.isCompleted, true);
      expect(task.priority, 1);
    });

    //should throw ArguementError if priority is invalid (0,1,2)
    test('should throw ArgumentError for invalid priority', () {
      expect(
        () => TaskModel(
          id: 3,
          name: 'Invalid Priority Task',
          description: 'This task has an invalid priority',
          isCompleted: false,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          priority: 5, // Invalid priority
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should delete a task', () async {
      await dataSource.addTask(task1);
      await dataSource.deleteTask(task1);

      final tasks = await dataSource.getAllTasks();
      expect(tasks, isEmpty);
    });

    test('deleting a non-existent task should not throw', () async {
      await dataSource.deleteTask(task2);
      final tasks = await dataSource.getAllTasks();
      expect(tasks, isEmpty); // still empty, no crash
    });
    test("No conflict with negative and 0 id ", () async {
      final result = await dataSource.addTask(invalidId);

      final allTasks = await dataSource.getAllTasks();
      if (kDebugMode) {
        print('allTasks: ${allTasks[0].id}');
      }
      expect(result, isA<bool>());
    });
  });

  group("use case test", () {
    final emptyTask = TaskModel(
      id: 0,
      name: '',
      description: null,
      isCompleted: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      priority: 0,
    );
    late CreateTaskUseCase createTaskUseCase;
    //create a
    setUp(() {
      repository = TaskRepositoryImpl(dataSource);
      createTaskUseCase = CreateTaskUseCase(repository);
    });
    test("Create task use case should return success", () async {
      final result = await createTaskUseCase(task1.toEntity());
      expect(result.isSuccess, true);
    });
    test("Create task use case should throw error for invalid priority", () {
      expect(
        () => createTaskUseCase(invalidTask1.toEntity()),
        throwsA(isA<ArgumentError>()),
      );
    });
    test("Create task use case should throw error for empty task", () async {
      final result = await createTaskUseCase(emptyTask.toEntity());
      expect(
          result,
          isA<DomainFailure<bool, Failure>>().having((p0) {
            return p0.isSuccess;
          }, "", false));
    });
  });
}

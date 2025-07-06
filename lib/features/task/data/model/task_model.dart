// entity/person.dart

import 'package:floor/floor.dart';

import '../../domain/entity/task.dart';

@entity
class TaskModel {
  @primaryKey
  final int id; // Unique ID based on timestamp
  final String name;
  final String? description;
  final bool isCompleted;
  final int createdAt; // Store as milliseconds since epoch
  final int priority;

  const TaskModel({
    required this.id,
    required this.name,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    required this.priority,
  });

//toEntity
  Task toEntity() {
    return Task(
      id: id.toString(),
      title: name,
      description: description,
      isCompleted: isCompleted,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      priority: TaskPriority.values[priority],
    );
  }

  factory TaskModel.create({
    required String name,
    String? description,
    bool isCompleted = false,
    required DateTime createdAt,
    required int priority,
  }) {
    return TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      // Generate unique ID
      name: name,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt.millisecondsSinceEpoch,
      priority: priority,
    );
  }

  //fromEntity
  factory TaskModel.fromEntity(Task task) {
    final id = int.tryParse(task.id) ?? DateTime.now().millisecondsSinceEpoch;
    return TaskModel(
      id: id,
      name: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt.millisecondsSinceEpoch,
      priority: task.priority.index, // Convert enum to int
    );
  }
}

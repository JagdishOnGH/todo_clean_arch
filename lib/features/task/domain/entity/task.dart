//pure dart business representation of a task entity

enum TaskPriority { high, medium, low }

extension TaskPriorityExtension on TaskPriority {
  String get asString {
    final name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1); // Capitalize first letter
  }
}

class Task {
  final int id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;

  final TaskPriority priority;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.priority = TaskPriority.medium,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
    );
  }
}

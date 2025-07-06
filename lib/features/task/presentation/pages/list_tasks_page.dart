import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../domain/entity/task.dart';
import '../widget/task_widget.dart';

class ListTasksPage extends StatefulWidget {
  const ListTasksPage({super.key});

  @override
  State<ListTasksPage> createState() => _ListTasksPageState();
}

class _ListTasksPageState extends State<ListTasksPage> {
  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Tasks"),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Handle search action
                print("Search tasks");
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle add task action
            print("Add new task");
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Builder(builder: (ctx) {
            if (appSize.width < 400) {
              return ListView(
                children: dummyTasks
                    .map((dummyTasks) => TaskWidget(
                          task: dummyTasks,
                          onDelete: () {
                            // Handle delete action
                            print("Delete task: ${dummyTasks.title}");
                          },
                          onUpdate: () {
                            // Handle update action
                            print("Update task: ${dummyTasks.title}");
                          },
                        ))
                    .toList(),
              );
            } else if (appSize.width < 900) {
              return MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: dummyTasks.length,
                itemBuilder: (context, index) {
                  final task = dummyTasks[index];
                  return TaskWidget(
                    task: task,
                    onDelete: () {
                      // Handle delete action
                      print("Delete task: ${task.title}");
                    },
                    onUpdate: () {
                      // Handle update action
                      print("Update task: ${task.title}");
                    },
                  );
                },
              );
            } else {
              return MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: dummyTasks.length,
                itemBuilder: (context, index) {
                  final task = dummyTasks[index];
                  return TaskWidget(
                    task: task,
                    onDelete: () {
                      // Handle delete action
                      print("Delete task: ${task.title}");
                    },
                    onUpdate: () {
                      // Handle update action
                      print("Update task: ${task.title}");
                    },
                  );
                },
              );
            }
          }),
        ));
  }
}

final List<Task> dummyTasks = [
  Task(
    id: '1',
    title: 'Buy groceries',
    description: 'Milk, eggs, bread, fruits',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    priority: TaskPriority.high,
  ),
  Task(
    id: '2',
    title: 'Finish Flutter project',
    description: 'Implement UI for the task list screen',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    priority: TaskPriority.medium,
  ),
  Task(
    id: '3',
    title: 'Call electrician',
    description: 'Fix the kitchen light issue',
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    isCompleted: true,
    priority: TaskPriority.low,
  ),
  Task(
    id: '4',
    title: 'Read a book',
    description: 'Start reading "Atomic Habits"',
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    priority: TaskPriority.low,
  ),
  Task(
    id: '5',
    title: 'Workout',
    description: 'Upper body session at the gym',
    createdAt: DateTime.now(),
    priority: TaskPriority.high,
  ),
];

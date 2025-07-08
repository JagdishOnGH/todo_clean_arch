import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../domain/entity/task.dart';
import '../bloc/task_bloc/task_bloc.dart';
import '../bloc/task_bloc/task_event.dart';
import '../bloc/task_bloc/task_state.dart';
import '../widget/create_task_dialog.dart';
import '../widget/task_widget.dart';

// This page displays a list of tasks and allows users to filter, add, and manage tasks.
class ListTasksPage extends StatelessWidget {
  const ListTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;

    return BlocConsumer<TaskBloc, TaskState>(
      listener: (ctx, state) {
        if (state is TaskOperationFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
        if (state is TaskLoadFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(" Failed to load data ${state.message}.")),
          );
        }
      },
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is TaskLoadFailureState) {
          return Scaffold(
            appBar: AppBar(title: const Text("My Tasks")),
            body: Center(child: Text("Error: ${state.message}")),
          );
        }

        // Shared state for Loaded & OperationError
        List<Task> tasks = [];

        if (state is TaskLoadedState) {
          tasks = state.tasks;
        } else if (state is TaskOperationFailureState) {
          tasks = state.tasks;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("My Tasks"),
            centerTitle: false,
            actions: [
              PopupMenuButton<bool>(
                onSelected: (bool selectedValue) {
                  context.read<TaskBloc>().add(
                        SortByNewestFirstEvent(isNewestFirst: selectedValue),
                      );
                },
                icon: const Icon(Icons.calendar_month_outlined),
                itemBuilder: (context) => const [
                  PopupMenuItem<bool>(
                    value: false,
                    child: Text("Sort Oldest First"),
                  ),
                  PopupMenuItem<bool>(
                    value: true,
                    child: Text("Sort Newest First"),
                  ),
                ],
              ),

              PopupMenuButton<String>(
                icon: const Icon(Icons.tune),
                onSelected: (value) {
                  if (value == "completed") {
                    context.read<TaskBloc>().add(
                          FilterTasksEvent(true),
                        );
                  } else if (value == "incomplete") {
                    context.read<TaskBloc>().add(
                          FilterTasksEvent(false),
                        );
                  } else if (value == "reset") {
                    context.read<TaskBloc>().add(
                          FilterTasksEvent(null),
                        );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "completed",
                    child: Text('Completed'),
                  ),
                  const PopupMenuItem(
                    value: "incomplete",
                    child: Text('Incomplete'),
                  ),
                  const PopupMenuItem(
                    value: "reset",
                    child: Text('All'),
                  ),
                ],
              ),

              //sort by date
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "uniqueHero",
            onPressed: () async {
              await showTaskFormDialog(context);
            },
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: tasks.isEmpty
                ? const Center(child: Text("No tasks available"))
                : (appSize.width < 400
                    ? ListView(
                        children: tasks
                            .map((task) => TaskWidget(task: task))
                            .toList(),
                      )
                    : MasonryGridView.builder(
                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: appSize.width < 900 ? 2 : 3,
                        ),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TaskWidget(task: task);
                        },
                      )),
          ),
        );
      },
    );
  }
}

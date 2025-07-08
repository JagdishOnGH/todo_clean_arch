import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/core/app_theme/app_theme.dart';
import 'package:todo_clean_arch/core/app_theme/app_theme_dark.dart';
import 'package:todo_clean_arch/features/task/presentation/pages/list_tasks_page.dart';
import 'package:todo_clean_arch/setup/get_it_setup.dart';

import 'features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'features/task/presentation/bloc/task_bloc/task_bloc_observer.dart';
import 'features/task/presentation/bloc/task_bloc/task_event.dart';

/// Main entry point for the Task Management application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await getItSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TaskBloc>()..add(const LoadAllTaskEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Management',
        theme: appTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const ListTasksPage(),
      ),
    );
  }
}

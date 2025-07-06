import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_clean_arch/features/task/data/dao/task_dao.dart';

import '../features/task/data/model/task_model.dart';

part 'floor_setup.g.dart';

@Database(version: 1, entities: [TaskModel])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}

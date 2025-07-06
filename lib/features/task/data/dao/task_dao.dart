import 'package:floor/floor.dart';
import 'package:todo_clean_arch/features/task/data/model/task_model.dart';

//task dao to perform database operation
@dao
abstract class TaskDao {
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> addTask(TaskModel task);

  @update
  Future<void> updateTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);

  @Query('SELECT * FROM TaskModel')
  Future<List<TaskModel>> getAllTasks();

  @Query('SELECT * FROM TaskModel WHERE id = :id')
  Future<TaskModel?> getTaskById(int id);
}

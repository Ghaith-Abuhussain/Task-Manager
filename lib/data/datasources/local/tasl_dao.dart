import 'package:floor/floor.dart';
import '../../../utils/constants/strings.dart';
import '../../../domain/models/local/task.dart';

@dao
abstract class TaskDao {
  @Query("SELECT * FROM $taskTableName")
  Future<List<Task>> getAllTasks();

  @Query("SELECT Max(id) FROM $taskTableName")
  Future<int?> getMaxId();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTask(Task task);

  @delete
  Future<void> deleteTask(Task task);

  @Query("DELETE FROM $taskTableName WHERE id = :id")
  Future<void> deleteTaskOnId(int id);

  @Query("SELECT * FROM $taskTableName WHERE id = :id")
  Future<Task?> getTask(int id);

  @Query("DELETE FROM $taskTableName WHERE id > 0")
  Future<void> deleteAllTasks();
}
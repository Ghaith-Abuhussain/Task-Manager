import '../../models/local/remember_me_user.dart';
import '../../models/local/task.dart';

abstract class DatabaseRepository {

  Future<List<RememberMeUser>> getAllRememberedUsers();

  Future<void> insertRememberedUser(RememberMeUser user);

  Future<void> deleteRememberedUser(RememberMeUser user);

  Future<RememberMeUser?> getRememberedUser();

  Future<List<Task>> getAllTasks();

  Future<int?> getMaxId();

  Future<void> insertTask(Task task);

  Future<void> insertTasks(List<Task> taskList);

  Future<void> deleteTask(Task task);

  Future<Task?> getTask(int id);

  Future<void> deleteAllTasks();

  Future<void> deleteTaskOnId(int id);
}
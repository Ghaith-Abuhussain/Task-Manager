import 'package:task_managing/domain/models/local/task.dart';

import '../../../domain/models/local/remember_me_user.dart';
import '../../datasources/local/app_database.dart';
import '../../../domain/repositories/database/database_repository.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<void> deleteRememberedUser(RememberMeUser user) async {
    return _appDatabase.rememberMeDao.deleteRememberedUser(user);
  }

  @override
  Future<List<RememberMeUser>> getAllRememberedUsers() async {
    return _appDatabase.rememberMeDao.getAllRememberedUsers();
  }

  @override
  Future<void> insertRememberedUser(RememberMeUser user) {
    return _appDatabase.rememberMeDao.insertRememberedUser(user);
  }

  @override
  Future<RememberMeUser?> getRememberedUser() {
    return _appDatabase.rememberMeDao.getRememberedUser();
  }

  @override
  Future<void> deleteTask(Task task) {
    return _appDatabase.taskDao.deleteTask(task);
  }

  @override
  Future<List<Task>> getAllTasks() {
    return _appDatabase.taskDao.getAllTasks();
  }

  @override
  Future<Task?> getTask(int id) {
    return _appDatabase.taskDao.getTask(id);
  }

  @override
  Future<void> insertTask(Task task) {
    return _appDatabase.taskDao.insertTask(task);
  }

  @override
  Future<void> insertTasks(List<Task> taskList) {
    taskList.forEach((task) {
      _appDatabase.taskDao.insertTask(task);
    });
    return _appDatabase.taskDao.insertTask(taskList.last);
  }

  @override
  Future<void> deleteAllTasks() {
    return _appDatabase.taskDao.deleteAllTasks();
  }

  @override
  Future<void> deleteTaskOnId(int id) {
    return _appDatabase.taskDao.deleteTaskOnId(id);
  }

  @override
  Future<int?> getMaxId() {
    return _appDatabase.taskDao.getMaxId();
  }

}
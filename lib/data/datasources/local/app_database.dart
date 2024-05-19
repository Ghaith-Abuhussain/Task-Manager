import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:task_managing/data/datasources/local/tasl_dao.dart';
import 'package:task_managing/domain/models/local/task.dart';

import '../../../domain/models/local/remember_me_user.dart';
import './remember_me_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [RememberMeUser, Task])
abstract class AppDatabase extends FloorDatabase {
  RemembermeDao get rememberMeDao;
  TaskDao get taskDao;
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RemembermeDao? _rememberMeDaoInstance;

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rememberMeUser` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `isLoggedIn` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `todo` TEXT NOT NULL, `completed` INTEGER NOT NULL, `userId` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RemembermeDao get rememberMeDao {
    return _rememberMeDaoInstance ??= _$RemembermeDao(database, changeListener);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$RemembermeDao extends RemembermeDao {
  _$RemembermeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _rememberMeUserInsertionAdapter = InsertionAdapter(
            database,
            'rememberMeUser',
            (RememberMeUser item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'isLoggedIn': item.isLoggedIn ? 1 : 0
                }),
        _rememberMeUserDeletionAdapter = DeletionAdapter(
            database,
            'rememberMeUser',
            ['id'],
            (RememberMeUser item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'isLoggedIn': item.isLoggedIn ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RememberMeUser> _rememberMeUserInsertionAdapter;

  final DeletionAdapter<RememberMeUser> _rememberMeUserDeletionAdapter;

  @override
  Future<List<RememberMeUser>> getAllRememberedUsers() async {
    return _queryAdapter.queryList('SELECT * FROM rememberMeUser',
        mapper: (Map<String, Object?> row) => RememberMeUser(
            id: row['id'] as int?,
            username: row['username'] as String,
            password: row['password'] as String,
            isLoggedIn: (row['isLoggedIn'] as int) != 0));
  }

  @override
  Future<RememberMeUser?> getRememberedUser() async {
    return _queryAdapter.query('SELECT * FROM rememberMeUser WHERE id = 1',
        mapper: (Map<String, Object?> row) => RememberMeUser(
            id: row['id'] as int?,
            username: row['username'] as String,
            password: row['password'] as String,
            isLoggedIn: (row['isLoggedIn'] as int) != 0));
  }

  @override
  Future<void> insertRememberedUser(RememberMeUser user) async {
    await _rememberMeUserInsertionAdapter.insert(
        user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRememberedUser(RememberMeUser user) async {
    await _rememberMeUserDeletionAdapter.delete(user);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'todo': item.todo,
                  'completed': item.completed ? 1 : 0,
                  'userId': item.userId
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'todo': item.todo,
                  'completed': item.completed ? 1 : 0,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM task',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            todo: row['todo'] as String,
            completed: (row['completed'] as int) != 0,
            userId: row['userId'] as int));
  }

  @override
  Future<int?> getMaxId() async {
    return _queryAdapter.query('SELECT Max(id) FROM task',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> deleteTaskOnId(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM task WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<Task?> getTask(int id) async {
    return _queryAdapter.query('SELECT * FROM task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            todo: row['todo'] as String,
            completed: (row['completed'] as int) != 0,
            userId: row['userId'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllTasks() async {
    await _queryAdapter.queryNoReturn('DELETE FROM task WHERE id > 0');
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:task_managing/domain/models/local/remember_me_user.dart';
import 'package:task_managing/domain/models/local/task.dart';
import 'package:task_managing/domain/models/remote/requests/add_new_todo/add_new_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/delete_todo/delete_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/get_all_todos/get_all_todos_request.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_body.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_new_todo/add_new_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/delete_todo/delete_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/get_all_todos_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/todo.dart';
import 'package:task_managing/domain/models/remote/responses/update_todo/update_todo_response.dart';
import 'package:task_managing/domain/repositories/database/database_repository.dart';
import 'package:task_managing/domain/repositories/remote/get_info_repository.dart';
import 'package:task_managing/utils/resources/data_state.dart';

bool internetConnectionStatus = false;
bool addNewTodoStatus = false;
bool deleteTodoStatus = false;
bool getPageStatus = false;
bool updateTodoStatus = false;
int limit = 10;
int skipped = 10;
List<Task> taskTable = [];
List<Task> fetchedTasks = [];
List<Task> tasksAfterEdit = [];
List<Task> tasksAfterAdd = [];
List<Task> apiTasks = [
  Task(id: 1, todo: "Todo1", completed: false, userId: 1),
  Task(id: 2, todo: "Todo2", completed: true, userId: 1),
  Task(id: 3, todo: "Todo3", completed: false, userId: 6),
  Task(id: 4, todo: "Todo4", completed: false, userId: 1),
  Task(id: 5, todo: "Todo5", completed: false, userId: 13),
  Task(id: 6, todo: "Todo6", completed: true, userId: 10),
  Task(id: 7, todo: "Todo7", completed: false, userId: 142),
  Task(id: 8, todo: "Todo8", completed: true, userId: 9),
  Task(id: 9, todo: "Todo9", completed: true, userId: 51),
  Task(id: 10, todo: "Todo10", completed: false, userId: 1),
  Task(id: 11, todo: "Todo11", completed: false, userId: 1),
  Task(id: 12, todo: "Todo12", completed: true, userId: 1),
  Task(id: 13, todo: "Todo13", completed: false, userId: 6),
  Task(id: 14, todo: "Todo14", completed: false, userId: 1),
  Task(id: 15, todo: "Todo15", completed: false, userId: 13),
  Task(id: 16, todo: "Todo16", completed: true, userId: 10),
  Task(id: 17, todo: "Todo17", completed: false, userId: 142),
  Task(id: 18, todo: "Todo18", completed: true, userId: 9),
  Task(id: 19, todo: "Todo19", completed: true, userId: 51),
  Task(id: 20, todo: "Todo20", completed: false, userId: 1),
  Task(id: 21, todo: "Todo21", completed: false, userId: 1),
  Task(id: 22, todo: "Todo22", completed: true, userId: 1),
  Task(id: 23, todo: "Todo23", completed: false, userId: 6),
  Task(id: 24, todo: "Todo24", completed: false, userId: 1),
  Task(id: 25, todo: "Todo25", completed: false, userId: 13),
  Task(id: 26, todo: "Todo26", completed: true, userId: 10),
  Task(id: 27, todo: "Todo27", completed: false, userId: 142),
  Task(id: 28, todo: "Todo28", completed: true, userId: 9),
  Task(id: 29, todo: "Todo29", completed: true, userId: 51),
  Task(id: 30, todo: "Todo30", completed: false, userId: 1),
  Task(id: 31, todo: "Todo31", completed: false, userId: 1),
  Task(id: 32, todo: "Todo32", completed: true, userId: 1),
  Task(id: 33, todo: "Todo33", completed: false, userId: 6),
  Task(id: 34, todo: "Todo34", completed: false, userId: 1),
  Task(id: 35, todo: "Todo35", completed: false, userId: 13),
  Task(id: 36, todo: "Todo36", completed: true, userId: 10),
  Task(id: 37, todo: "Todo37", completed: false, userId: 142),
  Task(id: 38, todo: "Todo38", completed: true, userId: 9),
  Task(id: 39, todo: "Todo39", completed: true, userId: 51),
  Task(id: 40, todo: "Todo40", completed: false, userId: 1),
  Task(id: 41, todo: "Todo41", completed: false, userId: 1),
  Task(id: 42, todo: "Todo42", completed: true, userId: 1),
  Task(id: 43, todo: "Todo43", completed: false, userId: 6),
  Task(id: 44, todo: "Todo44", completed: false, userId: 1),
  Task(id: 45, todo: "Todo45", completed: false, userId: 13),
  Task(id: 46, todo: "Todo46", completed: true, userId: 10),
  Task(id: 47, todo: "Todo47", completed: false, userId: 142),
  Task(id: 48, todo: "Todo48", completed: true, userId: 9),
  Task(id: 49, todo: "Todo49", completed: true, userId: 51),
  Task(id: 60, todo: "Todo50", completed: false, userId: 1),
  Task(id: 51, todo: "Todo51", completed: false, userId: 1),
  Task(id: 52, todo: "Todo52", completed: true, userId: 1),
  Task(id: 53, todo: "Todo53", completed: false, userId: 6),
  Task(id: 54, todo: "Todo54", completed: false, userId: 1),
  Task(id: 55, todo: "Todo55", completed: false, userId: 13),
  Task(id: 56, todo: "Todo56", completed: true, userId: 10),
  Task(id: 57, todo: "Todo57", completed: false, userId: 142),
  Task(id: 58, todo: "Todo58", completed: true, userId: 9),
  Task(id: 59, todo: "Todo59", completed: true, userId: 51),
  Task(id: 60, todo: "Todo60", completed: false, userId: 1),
];

class MockDatabaseRepository extends Mock implements DatabaseRepository {
  @override
  Future<void> deleteAllTasks() async {
    // TODO: implement deleteAllTasks
    taskTable = [];
  }

  @override
  Future<void> deleteTask(Task task) async {
    if (taskTable.isNotEmpty) {
      taskTable.removeWhere((element) => element.id == task.id);
    }
  }

  @override
  Future<void> deleteTaskOnId(int id) async {
    if (taskTable.isNotEmpty) {
      taskTable.removeWhere((element) => element.id == id);
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return taskTable;
  }

  @override
  Future<int?> getMaxId() async {
    if (taskTable.isNotEmpty) {
      return taskTable.last.id;
    } else {
      return null;
    }
  }

  @override
  Future<Task?> getTask(int id) async {
    if (taskTable.isNotEmpty) {
      return taskTable.firstWhere((element) => element.id == id);
    } else {
      return null;
    }
  }

  @override
  Future<void> insertTask(Task task) async {
    if (taskTable.isEmpty) {
      taskTable.add(task);
    } else {
      Task isThereTask = taskTable.firstWhere(
        (element) => element.id == task.id,
        orElse: () => Task(id: 0, todo: '', completed: false, userId: 0),
      );

      if (isThereTask.id! > 0) {
        taskTable[taskTable.indexOf(isThereTask)] = task;
      } else {
        taskTable.add(task);
      }
    }
  }

  @override
  Future<void> insertTasks(List<Task> taskList) async {
    taskList.forEach((element) async {
      await insertTask(element);
    });
  }
}

class MockGetInfoRepository extends Mock implements GetInfoRepository {
  @override
  Future<DataState<AddNewTodoResponse>> addNewTodo(
      {required AddNewTodoRequest request}) async {
    if (addNewTodoStatus) {
      return DataSuccess(
        AddNewTodoResponse(
            id: 151,
            todo: request.todo,
            completed: request.completed,
            userId: request.userId),
      );
    } else {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "Error fetching data from add new todo API",
        ),
      );
    }
  }

  @override
  Future<DataState<DeleteTodoResponse>> deleteTodo(
      {required DeleteTodoRequest request}) async {
    if (deleteTodoStatus) {
      return DataSuccess(
        DeleteTodoResponse(
            id: request.id,
            completed: false,
            todo: "aaaaaa",
            userId: 5,
            deletedOn: "2024-05-19T14:09:10.219Z",
            isDeleted: true),
      );
    } else {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "Error with deleting Todo API",
        ),
      );
    }
  }

  @override
  Future<DataState<GetAllTodosResponse>> getPage(
      {required GetAllTodosRequest request}) async {
    if (getPageStatus) {
      List<Todo> todoList = apiTasks
          .getRange(request.skip!, request.skip! + request.limit!)
          .map((e) => Todo(
              id: e.id, todo: e.todo, completed: e.completed, userId: e.userId))
          .toList();

      return DataSuccess(
        GetAllTodosResponse(
          todos: todoList,
          limit: 10,
          total: 150,
          skip: 10,
        ),
      );
    } else {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "Error with get Todo list API",
        ),
      );
    }
  }

  @override
  Future<DataState<UpdateTodoResponse>> updateTodo(
      {required UpdateTodoTaskRequest request}) async {
    if (updateTodoStatus) {
      return DataSuccess(
        UpdateTodoResponse(
          id: request.id,
          todo: request.body!.todo,
          completed: request.body!.completed,
          userId:
              apiTasks.firstWhere((element) => element.id == request.id).userId,
        ),
      );
    } else {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "Error with get update todo API",
        ),
      );
    }
  }
}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {
  @override
  // TODO: implement hasConnection
  Future<bool> get hasConnection async {
    return internetConnectionStatus;
  }
}

enum CRUDSTATE {
  initial,
  displayData,
  gettingPageData,
  gettingPageDataSuccess,
  gettingPageDataFailed,
  gettingNewPageData,
  gettingNewPageDataSuccess,
  gettingNewPageDataFailed,
  noMoreDataToFetch,
  editingTask,
  editingTaskSuccess,
  editingTaskFailed,
  addingTask,
  addingTaskSuccess,
  addingTaskFailed,
  deletingTask,
  deletingTaskSuccess,
  deletingTaskFailed
}

Future<CRUDSTATE> testGettingNewPage(
  MockDatabaseRepository databaseRepository,
  MockGetInfoRepository getInfoRepository,
) async {
  var state = CRUDSTATE.initial;
  var tasks = await databaseRepository.getAllTasks();
  state = CRUDSTATE.gettingNewPageData;

  bool result = await MockInternetConnectionChecker().hasConnection;
  if (result == true) {
    DataState<GetAllTodosResponse> response = await getInfoRepository.getPage(
        request: GetAllTodosRequest(limit: limit, skip: skipped));

    if (response is DataSuccess) {
      if (response.data!.todos!.isNotEmpty) {
        skipped += 10;
      } else {
        state = CRUDSTATE.noMoreDataToFetch;
      }

      await databaseRepository.insertTasks(
        response.data!.todos!
            .map(
              (e) => Task(
                id: e.id,
                todo: e.todo!,
                completed: e.completed!,
                userId: e.userId!,
              ),
            )
            .toList(),
      );

      tasks = await databaseRepository.getAllTasks();
      fetchedTasks = tasks;
      state = CRUDSTATE.gettingNewPageDataSuccess;
    } else {
      state = CRUDSTATE.gettingNewPageDataFailed;
    }
  } else {
    state = CRUDSTATE.gettingNewPageDataFailed;
  }
  return state;
}

Future<CRUDSTATE> testEditTask(
  MockDatabaseRepository databaseRepository,
  MockGetInfoRepository getInfoRepository,
) async {
  var state = CRUDSTATE.initial;
  var tasks = await databaseRepository.getAllTasks();
  state = CRUDSTATE.editingTask;

  bool result = await MockInternetConnectionChecker().hasConnection;
  if (result == true) {
    DataState<UpdateTodoResponse> response = await getInfoRepository.updateTodo(
      request: UpdateTodoTaskRequest(
        id: 4,
        body: UpdateTodoBody(
          todo: "Edit Todo",
          completed: true,
        ),
      ),
    );

    if (response is DataSuccess) {
      Task? task = await databaseRepository.getTask(4);

      await databaseRepository.insertTask(Task(
        id: task!.id,
        todo: response.data!.todo!,
        completed: response.data!.completed!,
        userId: response.data!.userId!,
      ));

      tasks = await databaseRepository.getAllTasks();
      tasksAfterEdit = tasks;
      state = CRUDSTATE.editingTaskSuccess;
    } else {
      var tasks = await databaseRepository.getAllTasks();
      tasksAfterEdit = tasks;
      state = CRUDSTATE.editingTaskFailed;
    }
  } else {
    state = CRUDSTATE.editingTaskFailed;
  }

  return state;
}

Future<CRUDSTATE> testDeleteTask(
  MockDatabaseRepository databaseRepository,
  MockGetInfoRepository getInfoRepository,
) async {
  var state = CRUDSTATE.initial;
  var tasks = await databaseRepository.getAllTasks();
  state = CRUDSTATE.deletingTask;

  bool result = await MockInternetConnectionChecker().hasConnection;
  if (result == true) {
    DataState<DeleteTodoResponse> response = await getInfoRepository.deleteTodo(
      request: DeleteTodoRequest(
        id: 5,
      ),
    );

    if (response is DataSuccess) {
      await databaseRepository.deleteTaskOnId(5);
      tasks = await databaseRepository.getAllTasks();
      state = CRUDSTATE.deletingTaskSuccess;
    } else {
      var tasks = await databaseRepository.getAllTasks();
      state = CRUDSTATE.deletingTaskFailed;
    }
  } else {
    state = CRUDSTATE.deletingTaskFailed;
  }

  return state;
}

Future<CRUDSTATE> testAddTask(
  MockDatabaseRepository databaseRepository,
  MockGetInfoRepository getInfoRepository,
) async {
  var state = CRUDSTATE.initial;
  var tasks = await databaseRepository.getAllTasks();
  state = CRUDSTATE.addingTask;

  bool result = await MockInternetConnectionChecker().hasConnection;
  if (result == true) {
    DataState<AddNewTodoResponse> response = await getInfoRepository.addNewTodo(
      request: AddNewTodoRequest(todo: "Add Todo", completed: false, userId: 5),
    );

    if (response is DataSuccess) {
      await databaseRepository.insertTask(
        Task(
          id: response.data!.id!,
          todo: response.data!.todo!,
          completed: response.data!.completed!,
          userId: response.data!.userId!,
        ),
      );

      tasks = await databaseRepository.getAllTasks();
      tasksAfterAdd = tasks;
      state = CRUDSTATE.addingTaskSuccess;
    } else {
      var tasks = await databaseRepository.getAllTasks();
      tasksAfterAdd = tasks;
      state = CRUDSTATE.addingTaskFailed;
    }
  } else {
    state = CRUDSTATE.addingTaskFailed;
  }

  return state;
}

void main() {
  MockDatabaseRepository databaseRepository = MockDatabaseRepository();
  MockGetInfoRepository getInfoRepository = MockGetInfoRepository();

  setUp(
    () => {},
  );

  // Test fetch new 10 tasks (skipping 30 tasks) with internet connection and the fetch is fine.
  test(
    'Test New Get Page, Skip = 30, limit = 10, internet connection: true, api working: true',
    () async {
      internetConnectionStatus = true;
      getPageStatus = true;
      limit = 10;
      skipped = 30;
      fetchedTasks = List.from([]);
      taskTable = List.from([]);

      CRUDSTATE state = await testGettingNewPage(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.gettingNewPageDataSuccess);

      // Ensure that we fetched 10 tasks between 31 and 40
      expect(fetchedTasks.first.id, 31);
      expect(fetchedTasks.last.id, 40);

      // Ensure that tasks are stored in database correctly
      expect(taskTable, fetchedTasks);
    },
  );

  // Test fetch new 10 tasks (skipping 30 tasks) with internet connection and the fetch emits error.
  test(
    'Test New Get Page, Skip = 30, limit = 10, internet connection: true, api working: false',
    () async {
      internetConnectionStatus = true;
      getPageStatus = false;
      limit = 10;
      skipped = 30;
      fetchedTasks = List.from([]);
      taskTable = List.from([]);

      CRUDSTATE state = await testGettingNewPage(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.gettingNewPageDataFailed);
    },
  );

  // Test fetch new 10 tasks (skipping 30 tasks) with no internet connection and the fetch is fine.
  test(
    'Test New Get Page, Skip = 30, limit = 10, internet connection: false, api working: true',
    () async {
      internetConnectionStatus = false;
      getPageStatus = true;
      limit = 10;
      skipped = 30;
      fetchedTasks = List.from([]);
      taskTable = List.from([]);

      CRUDSTATE state = await testGettingNewPage(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.gettingNewPageDataFailed);
    },
  );

  // Test Edit/Update Task (Task Id = 4), with  internet connection and the edit API works fine.
  test(
    'Test Edit/Update Task, Task Id = 4, internet connection: true, api working: true',
    () async {
      internetConnectionStatus = true;
      updateTodoStatus = true;
      taskTable = List.from(apiTasks);
      tasksAfterEdit = List.from([]);

      CRUDSTATE state = await testEditTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.editingTaskSuccess);

      // Check if the task is really updated
      expect(
        tasksAfterEdit.firstWhere((element) => element.id == 4),
        Task(id: 4, todo: "Edit Todo", completed: true, userId: 1),
      );
    },
  );

  // Test Edit/Update Task (Task Id = 4), with  internet connection and the edit API does not work fine.
  test(
    'Test Edit/Update Task, Task Id = 4, internet connection: true, api working: false',
    () async {
      internetConnectionStatus = true;
      updateTodoStatus = false;
      taskTable = List.from(apiTasks);
      tasksAfterEdit = List.from([]);

      CRUDSTATE state = await testEditTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.editingTaskFailed);
      // Check if the task is not updated
      expect(
        tasksAfterEdit.firstWhere((element) => element.id == 4),
        Task(id: 4, todo: "Todo4", completed: false, userId: 1),
      );
    },
  );

  // Test Edit/Update Task (Task Id = 4), with no internet connection and the edit API works fine.
  test(
    'Test Edit/Update Task, Task Id = 4, internet connection: false, api working: true',
    () async {
      internetConnectionStatus = false;
      updateTodoStatus = false;
      taskTable = List.from(apiTasks);
      tasksAfterEdit = List.from([]);

      CRUDSTATE state = await testEditTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.editingTaskFailed);
    },
  );

  // Test delete Task (Task Id = 5), with  internet connection and the edit API works fine.
  test(
    'Test Delete Task, Task Id = 5, internet connection: true, api working: true',
    () async {
      internetConnectionStatus = true;
      deleteTodoStatus = true;
      taskTable = List.from(apiTasks);
      tasksAfterEdit = List.from([]);

      CRUDSTATE state = await testDeleteTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.deletingTaskSuccess);

      // Check if the task is really updated
      expect(
        tasksAfterEdit.firstWhere((element) => element.id == 5,
            orElse: () => Task(id: 0, todo: '', completed: false, userId: 0)),
        Task(id: 0, todo: '', completed: false, userId: 0),
      );
    },
  );

  // Test delete Task (Task Id = 5), with  internet connection and the edit API does not work fine.
  test(
    'Test Delete Task, Task Id = 5, internet connection: true, api working: false',
    () async {
      internetConnectionStatus = true;
      deleteTodoStatus = false;
      taskTable = List.from(apiTasks);
      tasksAfterEdit = List.from([]);

      CRUDSTATE state = await testDeleteTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.deletingTaskFailed);
    },
  );

  // Test delete Task (Task Id = 5), with no internet connection and the edit API works fine.
  test(
    'Test Delete Task, Task Id = 5, internet connection: false, api working: true',
    () async {
      internetConnectionStatus = false;
      deleteTodoStatus = true;
      taskTable = List.from(apiTasks);
      tasksAfterEdit = List.from([]);

      CRUDSTATE state = await testDeleteTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.deletingTaskFailed);
    },
  );

  // Test add Task, with internet connection and the add API works fine.
  test(
    'Test Add Task, internet connection: true, api working: true',
    () async {
      internetConnectionStatus = true;
      addNewTodoStatus = true;
      taskTable = List.from(apiTasks);
      tasksAfterAdd = List.from([]);

      CRUDSTATE state = await testAddTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.addingTaskSuccess);

      // Check that the new task with ID 151 is added correctly
      expect(
        tasksAfterAdd.last,
        Task(id: 151, todo: "Add Todo", completed: false, userId: 5),
      );
    },
  );

  // Test add Task, with internet connection and the add API does not work fine.
  test(
    'Test Add Task, internet connection: true, api working: false',
        () async {
      internetConnectionStatus = true;
      addNewTodoStatus = false;
      taskTable = List.from(apiTasks);
      tasksAfterAdd = List.from([]);

      CRUDSTATE state = await testAddTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.addingTaskFailed);
      // Check that the new task with ID 151 is not added at all
      expect(
        tasksAfterAdd.last,
        Task(id: 60, todo: "Todo60", completed: false, userId: 1),
      );
    },
  );

  // Test add Task, with internet no connection and the add API works fine.
  test(
    'Test Add Task, internet connection: false, api working: true',
        () async {
      internetConnectionStatus = false;
      addNewTodoStatus = true;
      taskTable = List.from(apiTasks);
      tasksAfterAdd = List.from([]);

      CRUDSTATE state = await testAddTask(
        databaseRepository,
        getInfoRepository,
      );

      expect(state, CRUDSTATE.addingTaskFailed);
    },
  );

  tearDown(
    () => {},
  );
}

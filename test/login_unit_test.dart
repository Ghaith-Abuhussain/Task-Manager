import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:task_managing/domain/models/local/remember_me_user.dart';
import 'package:task_managing/domain/models/local/task.dart';
import 'package:task_managing/domain/models/remote/requests/add_new_todo/add_new_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/delete_todo/delete_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/get_all_todos/get_all_todos_request.dart';
import 'package:task_managing/domain/models/remote/requests/login/login_request.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_request.dart';
import 'package:task_managing/domain/models/remote/responses/delete_todo/delete_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/get_all_todos_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/todo.dart';
import 'package:task_managing/domain/models/remote/responses/login/login_response.dart';
import 'package:task_managing/domain/models/remote/responses/update_todo/update_todo_response.dart';
import 'package:task_managing/domain/repositories/database/database_repository.dart';
import 'package:task_managing/domain/repositories/remote/get_info_repository.dart';
import 'package:task_managing/domain/repositories/remote/login_repository.dart';
import 'package:task_managing/utils/resources/data_state.dart';

bool internetConnectionStatus = false;
bool loginStatus = false;
bool getFirst10TasksStatus = false;
bool rememberMe = false;
int skippedValue = 0;
List<RememberMeUser> userTable = [];
List<Task> taskTable = [];
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
];

enum LoginState {
  initial,
  getRemembered,
  rememberedDone,
  attemptLogin,
  loginSuccess,
  loginFailed
}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {
  @override
  // TODO: implement hasConnection
  Future<bool> get hasConnection async {
    return internetConnectionStatus;
  }
}

class MockRemoteLoginRepository extends Mock implements LoginRepository {
  @override
  Future<DataState<LoginResponse>> login(
      {required LoginRequest request}) async {
    if (loginStatus == true) {
      return DataSuccess(
        LoginResponse(
            id: 1,
            firstName: "Ghaith",
            email: "gaes@gmail.com",
            lastName: "AbuHussain",
            gender: "Male",
            image: "ggggg",
            token: "123456789",
            username: "ghaith_abuhussain"),
      );
    } else {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "Error With Login",
        ),
      );
    }
  }
}

class MockDatabaseRepository extends Mock implements DatabaseRepository {
  @override
  Future<void> insertTasks(List<Task> taskList) async {
    taskTable = taskList;
  }

  @override
  Future<void> deleteRememberedUser(RememberMeUser user) async {
    userTable = [];
  }

  @override
  Future<List<RememberMeUser>> getAllRememberedUsers() async {
    return userTable;
  }

  @override
  Future<RememberMeUser?> getRememberedUser() async {
    if (userTable.isEmpty) {
      return null;
    } else {
      return userTable[0];
    }
  }

  @override
  Future<void> insertRememberedUser(RememberMeUser user) async {
    if (userTable.isEmpty) {
      userTable.add(user);
    } else {
      userTable[0] = user;
    }
  }
}

class MockGetInfoRepository extends Mock implements GetInfoRepository {
  @override
  Future<DataState<GetAllTodosResponse>> getPage(
      {required GetAllTodosRequest request}) async {
    if (getFirst10TasksStatus) {
      return DataSuccess(
        GetAllTodosResponse(
          skip: 0,
          total: 150,
          limit: 10,
          todos: apiTasks
              .map((e) => Todo(
              id: e.id,
              userId: e.userId,
              completed: e.completed,
              todo: e.todo))
              .toList(),
        ),
      );
    } else {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          message: "Error fetching Todos",
        ),
      );
    }
  }
}

Future<LoginState> testLogin(
    MockDatabaseRepository loginRepository,
    MockRemoteLoginRepository remoteLoginRepository,
    MockGetInfoRepository getInfoRepository,
    ) async {
  LoginState state = LoginState.initial;
  LoginRequest request = LoginRequest(
      username: "ghaith_abuhussain", password: "987654321", expiresInMins: 30);

  // emit(LoginStateAttemptLogin());
  state = LoginState.attemptLogin;

  bool result = await MockInternetConnectionChecker().hasConnection;
  if (result) {
    DataState<LoginResponse> response =
    await remoteLoginRepository.login(request: request);

    if (response is DataSuccess) {
      if (rememberMe) {
        RememberMeUser user = RememberMeUser(
            username: "ghaith_abuhussain",
            password: "987654321",
            id: 1,
            isLoggedIn: true);
        loginRepository.insertRememberedUser(user);
      } else {
        RememberMeUser user = RememberMeUser(
            username: '', password: '', id: 1, isLoggedIn: false);
        loginRepository.deleteRememberedUser(user);
      }

      DataState<GetAllTodosResponse> fetchingFirstPageResponse =
      await getInfoRepository.getPage(
          request: GetAllTodosRequest(limit: 10, skip: 0));

      if (fetchingFirstPageResponse is DataSuccess) {
        await loginRepository.insertTasks(
          fetchingFirstPageResponse.data!.todos!
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
        state = LoginState.loginSuccess;
      } else {
        state = LoginState.loginFailed;
      }
    } else {
      state = LoginState.loginFailed;
    }
  } else {
    state = LoginState.loginFailed;
  }
  return state;
}

void main() {
  MockDatabaseRepository loginRepository = MockDatabaseRepository();
  MockRemoteLoginRepository remoteLoginRepository = MockRemoteLoginRepository();
  MockGetInfoRepository getInfoRepository = MockGetInfoRepository();

  setUp(
        () => {},
  );

  // Test login when internet connection to the server is Good, and the Login API
  // works fine, No Error with Password or Username,
  // and the Get first 10 tasks from the server API works fine,
  // works fine, No Error with Password or Username, and the user used remember me feature.
  test(
      'Login Test internet: Ok, Username & Password: Ok, GetTasks: Ok, rememberMe: True',
          () async {
        internetConnectionStatus = true;
        loginStatus = true;
        getFirst10TasksStatus = true;
        rememberMe = true;

        userTable = List.from([]);
        taskTable = List.from([]);


        LoginState state = await testLogin(
          loginRepository,
          remoteLoginRepository,
          getInfoRepository,
        );
        // Assertions
        expect(state, LoginState.loginSuccess);
        expect(taskTable, apiTasks);
        expect(userTable.length, 1);
        expect(
          userTable[0],
          RememberMeUser(
              username: "ghaith_abuhussain",
              password: "987654321",
              id: 1,
              isLoggedIn: true),
        );
      });

  // Test login when internet connection to the server is Good, and the Login API
  // works fine, No Error with Password or Username,
  // and the Get first 10 tasks from the server API works fine,
  // and the user did not use remember me feature.
  test(
      'Login Test internet: Ok, Username & Password: Ok, GetTasks: Ok, rememberMe: false',
          () async {
        internetConnectionStatus = true;
        loginStatus = true;
        getFirst10TasksStatus = true;
        rememberMe = false;

        userTable = List.from([]);
        taskTable = List.from([]);

        LoginState state = await testLogin(
          loginRepository,
          remoteLoginRepository,
          getInfoRepository,
        );
        // Assertions
        expect(state, LoginState.loginSuccess);
        expect(taskTable, apiTasks);
        expect(userTable.length, 0);
      });

  // Test login when internet connection to the server is Good, and the Login API
  // works fine, No Error with Password or Username,
  // and the Get first 10 tasks from the server API didn't work well,
  // and the user did not use remember me feature.
  test(
      'Login Test internet: Ok, Username & Password: Ok, GetTasks: false, rememberMe: false',
          () async {
        internetConnectionStatus = true;
        loginStatus = true;
        getFirst10TasksStatus = false;
        rememberMe = false;

        userTable = List.from([]);
        taskTable = List.from([]);

        LoginState state = await testLogin(
          loginRepository,
          remoteLoginRepository,
          getInfoRepository,
        );
        // Assertions
        expect(state, LoginState.loginFailed);
        expect(taskTable.length, 0);
      });

  // Test login when internet connection to the server is Good, and the Login API
  // works fine, With Errors in Password or Username for example,
  // and the Get first 10 tasks from the server API works well,
  // and the user did not use remember me feature.
  test(
      'Login Test internet: Ok, Username & Password: false, GetTasks: true, rememberMe: true',
          () async {
        internetConnectionStatus = true;
        loginStatus = false;
        getFirst10TasksStatus = true;
        rememberMe = true;

        userTable = List.from([]);
        taskTable = List.from([]);

        LoginState state = await testLogin(
          loginRepository,
          remoteLoginRepository,
          getInfoRepository,
        );
        // Assertions
        expect(state, LoginState.loginFailed);
        expect(taskTable.length, 0);
      });

  // Test login with no internet connection with the server, and the Login API
  // works fine, No Error with Password or Username,
  // and the Get first 10 tasks from the server API works fine,
  // and the user did not use remember me feature.
  test(
      'Login Test internet: false, Username & Password: true, GetTasks: true, rememberMe: true',
          () async {
        internetConnectionStatus = false;
        loginStatus = true;
        getFirst10TasksStatus = true;
        rememberMe = true;

        userTable = List.from([]);
        taskTable = List.from([]);

        LoginState state = await testLogin(
          loginRepository,
          remoteLoginRepository,
          getInfoRepository,
        );
        // Assertions
        expect(state, LoginState.loginFailed);
        expect(taskTable.length, 0);
      });


  tearDown(
        () => {},
  );
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing/domain/models/remote/requests/get_all_todos/get_all_todos_request.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/get_all_todos_response.dart';
import 'package:task_managing/utils/constants/nums.dart';
import 'package:task_managing/utils/constants/strings.dart';
import '../../../domain/models/local/task.dart';
import '../../../domain/repositories/remote/get_info_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../../domain/repositories/database/database_repository.dart';
import '../../../domain/models/local/remember_me_user.dart';
import '../../../domain/repositories/remote/login_repository.dart';
import '../../../domain/models/remote/requests/login/login_request.dart';
import '../../../domain/models/remote/responses/login/login_response.dart';
import '../../../utils/resources/data_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseRepository loginRepository;
  final LoginRepository remoteLoginRepository;
  final GetInfoRepository getInfoRepository;
  final SharedPreferences prefs;

  LoginBloc(this.loginRepository, this.remoteLoginRepository, this.prefs,
      this.getInfoRepository)
      : super(LoginStateInitial()) {
    on<LoginEventLogin>((event, emit) async {
      LoginRequest request = LoginRequest(
          username: event.username,
          password: event.password,
          expiresInMins: 30);

      emit(LoginStateAttemptLogin());
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<LoginResponse> response =
            await remoteLoginRepository.login(request: request);
        if (response is DataSuccess) {
          prefs.setInt(userId_name, response.data!.id!);
          if (event.remembermeValue) {
            RememberMeUser user = RememberMeUser(
                username: event.username, password: event.password, id: 1, isLoggedIn: true);
            loginRepository.insertRememberedUser(user);
            prefs.setString('token', 'Bearer ${response.data!.token!}');
          } else {
            RememberMeUser user =
                RememberMeUser(username: '', password: '', id: 1, isLoggedIn: false);
            loginRepository.deleteRememberedUser(user);
          }

          DataState<GetAllTodosResponse> fetchingFirstPageResponse =
              await getInfoRepository.getPage(
                  request: GetAllTodosRequest(limit: limit_size, skip: 0));

          if (fetchingFirstPageResponse is DataSuccess) {
            prefs.setInt(skipped_name, 10);
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
            emit(LoginStateLoginSuccess());
          } else {
            emit(LoginStateLoginFailure());
          }
        } else {
          emit(LoginStateLoginFailure());
        }
      } else {
        emit(LoginStateLoginFailure());
      }
    });
    on<LoginGetRememberedUser>((event, emit) async {
      RememberMeUser? user = await loginRepository.getRememberedUser();
      if (user == null) {
        emit(const LoginStateGetRemembered(username: '', password: ''));
      } else {
        print("User is Remembered");
        emit(LoginStateGetRemembered(
            username: user.username, password: user.password));
      }
    });
    on<LoginEmitInitial>((event, emit) async {
      emit(LoginStateInitial());
    });
    on<LoginSetState>((event, emit) async {
      if (event.state is! SetStateFirst) {
        emit(SetStateFirst());
      } else {
        emit(SetStateSecond());
      }
    });
  }
}

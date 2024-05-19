import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing/domain/models/local/task.dart';
import 'package:task_managing/domain/models/remote/requests/add_new_todo/add_new_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/delete_todo/delete_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/get_all_todos/get_all_todos_request.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_body.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_new_todo/add_new_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/delete_todo/delete_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/get_all_todos_response.dart';
import 'package:task_managing/domain/models/remote/responses/update_todo/update_todo_response.dart';
import 'package:task_managing/presentation/blocs/home/home_event.dart';
import 'package:task_managing/presentation/blocs/home/home_state.dart';
import 'package:task_managing/utils/constants/strings.dart';

import '../../../domain/models/local/remember_me_user.dart';
import '../../../domain/repositories/database/database_repository.dart';
import '../../../domain/repositories/remote/get_info_repository.dart';
import '../../../utils/constants/nums.dart';
import '../../../utils/resources/data_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseRepository databaseRepository;
  final GetInfoRepository getInfoRepository;
  final SharedPreferences prefs;

  HomeBloc(this.databaseRepository, this.prefs, this.getInfoRepository)
      : super(HomeStateInitial()) {
    on<HomeEventDisplayData>((event, emit) async {
      emit(HomeStateDisplayData(await databaseRepository.getAllTasks()));
    });
    on<HomeEventGetPage>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateGettingPageData(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        int skipped = 0;
        DataState<GetAllTodosResponse> response =
            await getInfoRepository.getPage(
                request: GetAllTodosRequest(limit: limit_size, skip: skipped));

        if (response is DataSuccess) {
          skipped += skipped_value;
          prefs.setInt(skipped_name, skipped);
          await databaseRepository.deleteAllTasks();
          await databaseRepository.insertTasks(
            response.data!.todos!
                .map((e) => Task(
                      id: e.id,
                      todo: e.todo!,
                      completed: e.completed!,
                      userId: e.userId!,
                    ))
                .toList(),
          );

          tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingPageDataSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingPageDataFailure(tasks));
        }
      } else {
        emit(FinishGettingPageDataFailure(tasks));
      }
    });
    on<HomeEventGetNewPage>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateGettingNewPageData(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        int skipped = (await databaseRepository.getMaxId())!;
        DataState<GetAllTodosResponse> response =
            await getInfoRepository.getPage(
                request: GetAllTodosRequest(limit: limit_size, skip: skipped));

        if (response is DataSuccess) {
          if (response.data!.todos!.isNotEmpty) {
            skipped += 10;
            prefs.setInt(skipped_name, skipped);
          } else {
            emit(NoMoreDataToFitch(tasks));
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
          emit(FinishGettingNewPageDataSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingNewPageDataFailure(tasks));
        }
      } else {
        emit(FinishGettingNewPageDataFailure(tasks));
      }
    });
    on<HomeEventEditTask>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateEditingTask(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<UpdateTodoResponse> response =
            await getInfoRepository.updateTodo(
          request: UpdateTodoTaskRequest(
            id: event.id,
            body: UpdateTodoBody(
              todo: event.todo,
              completed: event.completed,
            ),
          ),
        );

        if (response is DataSuccess) {
          Task? task = await databaseRepository.getTask(event.id);

          await databaseRepository.insertTask(Task(
            id: task!.id,
            todo: response.data!.todo!,
            completed: response.data!.completed!,
            userId: response.data!.userId!,
          ));

          tasks = await databaseRepository.getAllTasks();
          emit(HomeStateEditingTaskSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(HomeStateEditingTaskFailure(tasks));
        }
      } else {
        emit(HomeStateEditingTaskFailure(tasks));
      }
    });
    on<HomeEventDeletingTask>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateDeletingTask(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<DeleteTodoResponse> response =
            await getInfoRepository.deleteTodo(
          request: DeleteTodoRequest(
            id: event.id,
          ),
        );

        if (response is DataSuccess) {
          await databaseRepository.deleteTaskOnId(event.id);
          tasks = await databaseRepository.getAllTasks();
          emit(HomeStateDeletingTaskSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(HomeStateDeletingTaskFailure(tasks));
        }
      } else {
        emit(HomeStateDeletingTaskFailure(tasks));
      }
    });
    on<HomeEventAddingTask>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateAddingTask(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<AddNewTodoResponse> response =
            await getInfoRepository.addNewTodo(
          request: AddNewTodoRequest(
              todo: event.todo,
              completed: event.completed,
              userId: event.userId),
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
          emit(HomeStateAddingTaskSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(HomeStateAddingTaskFailure(tasks));
        }
      } else {
        emit(HomeStateAddingTaskFailure(tasks));
      }
    });
    on<HomeEventLoggingOut>((event, emit) async {
      RememberMeUser? user = await databaseRepository.getRememberedUser();
      await databaseRepository.insertRememberedUser(
        RememberMeUser(
            id: user!.id,
            username: user.username,
            password: user.password,
            isLoggedIn: false),
      );
    });
  }
}

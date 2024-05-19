import 'package:task_managing/data/datasources/remote/api/task_manager_api_service.dart';
import 'package:task_managing/domain/models/remote/requests/add_new_todo/add_new_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/delete_todo/delete_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/get_all_todos/get_all_todos_request.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_new_todo/add_new_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/delete_todo/delete_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/get_all_todos_response.dart';
import 'package:task_managing/domain/models/remote/responses/update_todo/update_todo_response.dart';

import '../../../domain/repositories/remote/get_info_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../../base/base_api_repository.dart';

class GetInfoRepositoryImpl extends BaseApiRepository
    implements GetInfoRepository {
  final TaskManagerApiService _taskManagerApiService;

  GetInfoRepositoryImpl(this._taskManagerApiService);

  @override
  Future<DataState<GetAllTodosResponse>> getPage(
      {required GetAllTodosRequest request}) {
    return getStateOf<GetAllTodosResponse>(
      request: () => _taskManagerApiService.getPage(
          request.limit!.toString(), request.skip!.toString()),
    );
  }

  @override
  Future<DataState<AddNewTodoResponse>> addNewTodo(
      {required AddNewTodoRequest request}) {
    return getStateOf<AddNewTodoResponse>(
      request: () => _taskManagerApiService.addNewTodo(body: request),
    );
  }

  @override
  Future<DataState<DeleteTodoResponse>> deleteTodo(
      {required DeleteTodoRequest request}) {
    return getStateOf<DeleteTodoResponse>(
      request: () => _taskManagerApiService.deleteTodo(request.id.toString()),
    );
  }

  @override
  Future<DataState<UpdateTodoResponse>> updateTodo(
      {required UpdateTodoTaskRequest request}) {
    return getStateOf<UpdateTodoResponse>(
      request: () => _taskManagerApiService.updateTodo(
          body: request.body, id: request.id.toString()),
    );
  }
}

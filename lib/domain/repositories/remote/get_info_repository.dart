import 'package:task_managing/domain/models/remote/requests/add_new_todo/add_new_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/delete_todo/delete_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/get_all_todos/get_all_todos_request.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_new_todo/add_new_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/delete_todo/delete_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/update_todo/update_todo_response.dart';

import '../../../utils/resources/data_state.dart';
import '../../models/remote/responses/get_all_todos/get_all_todos_response.dart';

abstract class GetInfoRepository {
  Future<DataState<GetAllTodosResponse>> getPage({
    required GetAllTodosRequest request,
  });

  Future<DataState<UpdateTodoResponse>> updateTodo(
      {required UpdateTodoTaskRequest request});

  Future<DataState<DeleteTodoResponse>> deleteTodo({required DeleteTodoRequest request});

  Future<DataState<AddNewTodoResponse>> addNewTodo({required AddNewTodoRequest request});
}

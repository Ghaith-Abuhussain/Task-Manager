import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_managing/domain/models/remote/requests/add_new_todo/add_new_todo_request.dart';
import 'package:task_managing/domain/models/remote/requests/update_todo/update_todo_body.dart';
import 'package:task_managing/domain/models/remote/responses/add_new_todo/add_new_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/delete_todo/delete_todo_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/get_all_todos_response.dart';
import 'package:task_managing/domain/models/remote/responses/update_todo/update_todo_response.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../domain/models/remote/requests/login/login_request.dart';
import '../../../../domain/models/remote/responses/login/login_response.dart';

part 'task_manager_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable) // must put baseUrl
abstract class TaskManagerApiService {
  factory TaskManagerApiService(Dio dio, {String baseUrl}) =
      _TaskManagerApiService;

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @POST('/auth/login')
  Future<HttpResponse<LoginResponse>> login({
    @Body() LoginRequest? body,
  });

  @GET('/todos?limit={limit}&skip={skip}')
  Future<HttpResponse<GetAllTodosResponse>> getPage(
      @Path() String limit, @Path() String skip);

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @PUT('/todos/{id}')
  Future<HttpResponse<UpdateTodoResponse>> updateTodo({
    @Path() String? id,
    @Body() UpdateTodoBody? body,
  });

  @DELETE('/todos/{id}')
  Future<HttpResponse<DeleteTodoResponse>> deleteTodo(
    @Path() String id,
  );

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @POST('/todos/add')
  Future<HttpResponse<AddNewTodoResponse>> addNewTodo({
    @Body() AddNewTodoRequest? body,
  });
}

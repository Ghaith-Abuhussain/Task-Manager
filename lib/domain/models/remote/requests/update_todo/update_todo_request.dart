import 'update_todo_body.dart';

class UpdateTodoTaskRequest {
  final int? id;
  final UpdateTodoBody? body;


  UpdateTodoTaskRequest({
    required this.id,
    required this.body,
  });

  Map<String, dynamic> toJson() => {
    'body': body!.toJson(),
    'id': id,
  };
}
import 'package:equatable/equatable.dart';
import 'package:task_managing/domain/models/remote/responses/get_all_todos/todo.dart';

class GetAllTodosResponse extends Equatable {
  final List<Todo>? todos;
  final int? total;
  final int? skip;
  final int? limit;

  GetAllTodosResponse({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  factory GetAllTodosResponse.fromMap(Map<String, dynamic> map) {
    return GetAllTodosResponse(
      todos: List<Todo>.from((map['todos'] as List<dynamic>)
          .map<Todo>((x) => Todo.fromMap(x as Map<String, dynamic>))),
      total: map['total'] != null ? map['total'] as int : null,
      skip: map['skip'] != null ? map['skip'] as int : null,
      limit: map['limit'] != null ? map['limit'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? todoList =
        todos?.map((i) => i.toJson()).toList();

    return {
      'todos': todoList,
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        todos,
        total,
        skip,
        limit,
      ];
}

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String? todo;
  final bool? completed;
  final int? userId;

  Todo({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id:map['id'] != null ? map['id'] as int : null,
      todo:map['todo'] != null ? map['todo'] as String : null,
      completed:map['completed'] != null ? map['completed'] as bool : null,
      userId:map['userId'] != null ? map['userId'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
    'id': id,
    'todo': todo,
    'completed': completed,
    'userId': userId,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, todo, completed, userId];
}

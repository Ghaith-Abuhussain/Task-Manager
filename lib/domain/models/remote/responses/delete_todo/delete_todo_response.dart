import 'package:equatable/equatable.dart';

class DeleteTodoResponse extends Equatable {
  final int? id;
  final String? todo;
  final bool? completed;
  final int? userId;
  final bool? isDeleted;
  final String? deletedOn;

  DeleteTodoResponse({
    this.id,
    this.todo,
    this.completed,
    this.userId,
    this.isDeleted,
    this.deletedOn,
  });

  factory DeleteTodoResponse.fromMap(Map<String, dynamic> map) {
    return DeleteTodoResponse(
      id: map['id'] != null ? map['id'] as int : null,
      todo: map['todo'] != null ? map['todo'] as String : null,
      completed: map['completed'] != null ? map['completed'] as bool : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      deletedOn: map['deletedOn'] != null ? map['deletedOn'] as String : null,

    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
      'isDeleted': isDeleted,
      'deletedOn': deletedOn,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    todo,
    completed,
    userId,
    isDeleted,
    deletedOn,
  ];
}
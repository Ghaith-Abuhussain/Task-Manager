class AddNewTodoRequest {
  final String? todo;
  final bool? completed;
  final int? userId;


  AddNewTodoRequest({
    required this.todo,
    required this.completed,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'todo': todo,
    'completed': completed,
    'userId': userId,
  };
}

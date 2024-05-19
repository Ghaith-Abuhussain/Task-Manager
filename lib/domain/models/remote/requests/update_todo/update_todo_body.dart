class UpdateTodoBody {
  final String todo;
  final bool completed;

  UpdateTodoBody({
    required this.todo,
    required this.completed,
  });

  Map<String, dynamic> toJson() => {
    'todo': todo,
    'completed': completed,
  };
}

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:task_managing/utils/constants/strings.dart';

@Entity(tableName: taskTableName)
class Task extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String todo;
  final bool completed;
  final int userId;

  Task({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, todo, completed, userId];
}

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventDisplayData extends HomeEvent {
  const HomeEventDisplayData();
}

class HomeEventGetPage extends HomeEvent {

  const HomeEventGetPage();
}

class HomeEventGetNewPage extends HomeEvent {
  const HomeEventGetNewPage();
}

class HomeEventEditTask extends HomeEvent {
  final int id;
  final String todo;
  final bool completed;

  const HomeEventEditTask({
    required this.id,
    required this.todo,
    required this.completed,
  });
}

class HomeEventDeletingTask extends HomeEvent {
  final int id;

  const HomeEventDeletingTask(this.id);
}

class HomeEventAddingTask extends HomeEvent {
  final String todo;
  final bool completed;
  final int userId;

  const HomeEventAddingTask({
    required this.todo,
    required this.completed,
    required this.userId,
  });
}

class HomeEventLoggingOut extends HomeEvent {
  const HomeEventLoggingOut();
}

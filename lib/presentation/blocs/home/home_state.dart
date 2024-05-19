import 'package:equatable/equatable.dart';

import '../../../domain/models/local/task.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeStateInitial extends HomeState {
  const HomeStateInitial();
  @override
  List<Object> get props => [];
}

class HomeStateDisplayData extends HomeState {
  final List<Task> tasks;
  const HomeStateDisplayData(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateGettingPageData extends HomeState {
  final List<Task> tasks;
  const HomeStateGettingPageData(this.tasks);

  @override
  List<Object> get props => [];
}

class FinishGettingPageDataSuccess extends HomeState {
  final List<Task> tasks;
  const FinishGettingPageDataSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class FinishGettingPageDataFailure extends HomeState {
  final List<Task> tasks;
  const FinishGettingPageDataFailure(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class HomeStateGettingNewPageData extends HomeState {
  final List<Task> tasks;
  const HomeStateGettingNewPageData(this.tasks);

  @override
  List<Object> get props => [];
}

class FinishGettingNewPageDataSuccess extends HomeState {
  final List<Task> tasks;
  const FinishGettingNewPageDataSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class FinishGettingNewPageDataFailure extends HomeState {
  final List<Task> tasks;
  const FinishGettingNewPageDataFailure(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class NoMoreDataToFitch extends HomeState {
  final List<Task> tasks;
  const NoMoreDataToFitch(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class HomeStateEditingTask extends HomeState {
  final List<Task> tasks;
  const HomeStateEditingTask(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateEditingTaskSuccess extends HomeState {
  final List<Task> tasks;
  const HomeStateEditingTaskSuccess(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateEditingTaskFailure extends HomeState {
  final List<Task> tasks;
  const HomeStateEditingTaskFailure(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateDeletingTask extends HomeState {
  final List<Task> tasks;
  const HomeStateDeletingTask(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateDeletingTaskSuccess extends HomeState {
  final List<Task> tasks;
  const HomeStateDeletingTaskSuccess(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateDeletingTaskFailure extends HomeState {
  final List<Task> tasks;
  const HomeStateDeletingTaskFailure(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateAddingTask extends HomeState {
  final List<Task> tasks;
  const HomeStateAddingTask(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateAddingTaskSuccess extends HomeState {
  final List<Task> tasks;
  const HomeStateAddingTaskSuccess(this.tasks);

  @override
  List<Object> get props => [];
}

class HomeStateAddingTaskFailure extends HomeState {
  final List<Task> tasks;
  const HomeStateAddingTaskFailure(this.tasks);

  @override
  List<Object> get props => [];
}
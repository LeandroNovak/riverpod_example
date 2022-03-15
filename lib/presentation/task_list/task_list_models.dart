import 'package:domain/models/task.dart';

abstract class TaskListState {}

class Success implements TaskListState {
  const Success(this.taskList);

  final List<Task> taskList;
}

class Loading implements TaskListState {}

class Error implements TaskListState {}

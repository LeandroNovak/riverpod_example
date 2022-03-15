abstract class NewTaskState {}

class Idle implements NewTaskState {
  const Idle(this.isSubmitButtonEnabled);

  final bool isSubmitButtonEnabled;
}

class Loading implements NewTaskState {}

class Error implements NewTaskState {}

abstract class NewTaskAction {}

class CloseDialog implements NewTaskAction {}

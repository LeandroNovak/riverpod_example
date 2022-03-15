import 'package:domain/use_cases/get_task_list_uc.dart';
import 'package:domain/use_cases/remove_task_uc.dart';
import 'package:riverpod_example/presentation/task_list/task_list_models.dart';
import 'package:riverpod_example/utils/subscription_holder.dart';
import 'package:rxdart/rxdart.dart';

class TaskListBloc with SubscriptionHolder {
  TaskListBloc({
    required this.getTaskListUC,
    required this.removeTaskUC,
    required this.onTaskListChangeStream,
  }) {
    Rx.merge([
      Stream.value(null),
      onTaskListChangeStream,
    ])
        .flatMap((_) => _fetchTaskList())
        .listen(_onNewStateSubject.add)
        .addTo(subscriptions);

    _onRemoveTaskSubject.listen(_removeTask).addTo(subscriptions);
  }

  final GetTaskListUC getTaskListUC;
  final RemoveTaskUC removeTaskUC;
  final Stream<void> onTaskListChangeStream;

  final _onNewStateSubject = BehaviorSubject<TaskListState>.seeded(Loading());
  Stream<TaskListState> get onNewStateStream => _onNewStateSubject.stream;

  final _onRemoveTaskSubject = PublishSubject<String>();
  Sink<String> get onRemoveTask => _onRemoveTaskSubject.sink;

  Stream<TaskListState> _fetchTaskList() async* {
    yield Loading();
    final taskList = await getTaskListUC.getFuture(null);
    yield Success(taskList);
  }

  Future<void> _removeTask(String taskId) => removeTaskUC.getFuture(taskId);

  void dispose() {
    disposeAll();
    _onNewStateSubject.close();
    _onRemoveTaskSubject.close();
  }
}

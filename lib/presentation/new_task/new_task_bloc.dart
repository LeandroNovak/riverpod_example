import 'package:domain/models/task.dart';
import 'package:domain/use_cases/upsert_task_uc.dart';
import 'package:riverpod_example/presentation/new_task/new_task_models.dart';
import 'package:riverpod_example/utils/subscription_holder.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class NewTaskBloc with SubscriptionHolder {
  NewTaskBloc({
    required this.upsertTaskUC,
  }) {
    Rx.merge([
      _onNewTitleSubject,
      _onNewDescriptionSubject,
    ]).flatMap((_) => _checkIfValid()).listen(_onNewStateSubject.add);

    _onAddTaskSubject.listen((_) => _addTask());
  }

  final UpsertTaskUC upsertTaskUC;

  final _onNewStateSubject = BehaviorSubject<NewTaskState>();
  Stream<NewTaskState> get onNewTaskStateStream => _onNewStateSubject.stream;

  final _onNewTaskActionSubject = PublishSubject<NewTaskAction>();
  Stream<NewTaskAction> get onNewTaskActionStream =>
      _onNewTaskActionSubject.stream;

  final _onNewTitleSubject = BehaviorSubject<String>.seeded('');
  Sink<String> get onNewTitleSink => _onNewTitleSubject.sink;

  final _onNewDescriptionSubject = BehaviorSubject<String>.seeded('');
  Sink<String> get onNewDescriptionSink => _onNewDescriptionSubject.sink;

  final _onAddTaskSubject = PublishSubject<void>();
  Sink<void> get onAddTaskSink => _onAddTaskSubject.sink;

  final _uuid = const Uuid();

  Stream<NewTaskState> _checkIfValid() async* {
    yield Idle(
      _onNewTitleSubject.value.isNotEmpty &&
          _onNewDescriptionSubject.value.isNotEmpty,
    );
  }

  Future<void> _addTask() async {
    await upsertTaskUC.getFuture(
      Task(
        _uuid.v4(),
        _onNewTitleSubject.value,
        _onNewDescriptionSubject.value,
      ),
    );

    _onNewTaskActionSubject.add(CloseDialog());
  }

  void dispose() {
    disposeAll();
    _onNewStateSubject.close();
    _onNewTaskActionSubject.close();
    _onNewTitleSubject.close();
    _onNewDescriptionSubject.close();
    _onAddTaskSubject.close();
  }
}

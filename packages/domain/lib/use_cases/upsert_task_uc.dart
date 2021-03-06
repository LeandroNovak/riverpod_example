import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/models/task.dart';
import 'package:domain/use_cases/use_case.dart';

class UpsertTaskUC extends UseCase<Task, void> {
  const UpsertTaskUC({
    required this.taskRepository,
    required this.onTaskListChangeSink,
    required ErrorLogger logger,
  }) : super(logger: logger);

  final TaskDataRepository taskRepository;
  final Sink<void> onTaskListChangeSink;

  @override
  Future<void> getRawFuture(Task params) async {
    await taskRepository.upsertTask(params);
    onTaskListChangeSink.add(null);
  }
}

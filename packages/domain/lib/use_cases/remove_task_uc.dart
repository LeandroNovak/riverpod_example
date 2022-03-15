import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_cases/use_case.dart';

class RemoveTaskUC extends UseCase<String, void> {
  const RemoveTaskUC({
    required this.taskRepository,
    required this.onTaskListChangeSink,
    required ErrorLogger logger,
  }) : super(logger: logger);

  final TaskDataRepository taskRepository;
  final Sink<void> onTaskListChangeSink;

  @override
  Future<void> getRawFuture(String params) async {
    await taskRepository.removeTask(params);
    onTaskListChangeSink.add(null);
  }
}

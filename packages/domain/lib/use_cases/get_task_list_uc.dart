import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/models/task.dart';
import 'package:domain/use_cases/use_case.dart';

class GetTaskListUC extends UseCase<void, List<Task>> {
  const GetTaskListUC({
    required this.taskRepository,
    required ErrorLogger logger,
  }) : super(logger: logger);

  final TaskDataRepository taskRepository;

  @override
  Future<List<Task>> getRawFuture(void params) => taskRepository.getTaskList();
}

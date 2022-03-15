import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_cases/use_case.dart';

class GetTaskListUC extends UseCase {
  const GetTaskListUC({
    required this.taskRepository,
    required ErrorLogger logger,
  }) : super(logger: logger);

  final TaskDataRepository taskRepository;

  @override
  Future getRawFuture(params) {
    // TODO: implement getRawFuture
    throw UnimplementedError();
  }
}

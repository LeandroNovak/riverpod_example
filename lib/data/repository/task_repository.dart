import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/models/task.dart';
import 'package:riverpod_example/data/cache/data_source/task_cds.dart';

class TaskRepository implements TaskDataRepository {
  const TaskRepository({
    required this.taskCDS,
  });

  final TaskCDS taskCDS;

  @override
  Future<List<Task>> getTaskList() {
    // TODO: implement getTaskList
    throw UnimplementedError();
  }

  @override
  Future<void> upsertTask(Task task) {
    // TODO: implement upsertTask
    throw UnimplementedError();
  }
}

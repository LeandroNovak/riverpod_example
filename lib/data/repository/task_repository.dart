import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/models/task.dart';
import 'package:riverpod_example/data/cache/data_source/task_cds.dart';
import 'package:riverpod_example/data/mappers/cache_to_domain.dart';
import 'package:riverpod_example/data/mappers/domain_to_cache.dart';

class TaskRepository implements TaskDataRepository {
  const TaskRepository({
    required this.taskCDS,
  });

  final TaskCDS taskCDS;

  @override
  Future<List<Task>> getTaskList() async {
    final taskCMList = await taskCDS.getTaskList();
    return taskCMList.map((taskCM) => taskCM.toDM()).toList();
  }

  @override
  Future<void> upsertTask(Task task) => taskCDS.upsertTask(task.toCM());

  @override
  Future<void> removeTask(String taskId) => taskCDS.removeTask(taskId);
}

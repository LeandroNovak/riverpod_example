import 'package:domain/models/task.dart';

abstract class TaskDataRepository {
  Future<List<Task>> getTaskList();
  Future<void> upsertTask(Task task);
}

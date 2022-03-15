import 'package:domain/models/task.dart';
import 'package:riverpod_example/data/cache/models/task_cm.dart';

extension TaskCMToDMMapper on TaskCM {
  Task toDM() => Task(id, title, description);
}

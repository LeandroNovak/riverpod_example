import 'package:domain/models/task.dart';
import 'package:riverpod_example/data/cache/models/task_cm.dart';

extension TaskDMToCMMapper on Task {
  TaskCM toCM() => TaskCM(id, title, description);
}

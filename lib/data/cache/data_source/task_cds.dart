import 'package:riverpod_example/data/cache/models/task_cm.dart';

class TaskCDS {
  final _taskList = <TaskCM>[
    TaskCM('123123a', 'Ir ao supermercado', 'Comprar foo, bar, baz'),
    TaskCM('123123b', 'Ir ao supermercado', 'Comprar foo, bar, baz'),
    TaskCM('123123c', 'Ir ao supermercado', 'Comprar foo, bar, baz'),
  ];

  Future<List<TaskCM>> getTaskList() => Future.microtask(() => _taskList);

  Future<void> upsertTask(TaskCM task) => Future.microtask(
        () => _taskList.add(task),
      );

  Future<void> removeTask(String taskId) => Future.microtask(
        () => _taskList.removeWhere((task) => task.id == taskId),
      );
}

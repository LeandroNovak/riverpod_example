import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/presentation/common/async_snapshot_response_view.dart';
import 'package:riverpod_example/presentation/new_task/new_task_dialog.dart';
import 'package:riverpod_example/presentation/task_list/task_list_bloc.dart';
import 'package:riverpod_example/presentation/task_list/task_list_models.dart';
import 'package:riverpod_example/utils/general_provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({
    required this.bloc,
    Key? key,
  }) : super(key: key);

  final TaskListBloc bloc;

  static Widget create() => Consumer(
        builder: (context, ref, _) => TaskListPage(
          bloc: TaskListBloc(
            getTaskListUC: ref.watch(getTaskListUCProvider),
            removeTaskUC: ref.watch(removeTaskUCProvider),
            onTaskListChangeStream: ref.watch(taskListChangeStreamProvider),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tarefas'),
        ),
        body: StreamBuilder<TaskListState>(
          stream: bloc.onNewStateStream,
          builder: (context, snapshot) =>
              AsyncSnapshotResponseView<Loading, Error, Success>(
            snapshot: snapshot,
            successWidgetBuilder: (context, success) {
              if (success.taskList.isEmpty) {
                return const Center(
                  child: Text('Sem tarefas'),
                );
              }

              return ListView.builder(
                itemCount: success.taskList.length,
                itemBuilder: (context, index) {
                  final item = success.taskList[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => bloc.onRemoveTask.add(item.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => NewTaskPage.create(),
            );
          },
          tooltip: 'Adicionar tarefa',
          child: const Icon(Icons.add),
        ),
      );
}

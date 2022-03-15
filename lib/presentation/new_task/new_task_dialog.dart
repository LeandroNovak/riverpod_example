import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/presentation/common/action_handler.dart';
import 'package:riverpod_example/presentation/new_task/new_task_bloc.dart';
import 'package:riverpod_example/presentation/new_task/new_task_models.dart';
import 'package:riverpod_example/utils/general_provider.dart';

class NewTaskPage extends ConsumerStatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends ConsumerState<NewTaskPage> {
  late final NewTaskBloc bloc;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = ref.watch(newTaskBlocProvider);
    return ActionHandler<NewTaskAction>(
      actionStream: bloc.onNewTaskActionStream,
      onReceived: (action) {
        if (action is CloseDialog) {
          Navigator.of(context).pop();
        }
      },
      child: SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        children: [
          const Center(
            child: Text(
              'Nova tarefa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          TextField(
            controller: _titleController,
            onChanged: bloc.onNewTitleSink.add,
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: _descriptionController,
            onChanged: bloc.onNewDescriptionSink.add,
            decoration: const InputDecoration(
              labelText: 'Descrição',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: bloc.onNewTaskStateStream,
            builder: (context, snapshot) {
              final data = snapshot.data;
              return TextButton(
                onPressed: data is Idle && data.isSubmitButtonEnabled
                    ? () => bloc.onAddTaskSink.add(null)
                    : null,
                child: Text('Adicionar'),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:domain/data_repository/task_data_repository.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_cases/get_task_list_uc.dart';
import 'package:domain/use_cases/remove_task_uc.dart';
import 'package:domain/use_cases/upsert_task_uc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_example/data/cache/data_source/task_cds.dart';
import 'package:riverpod_example/data/repository/task_repository.dart';
import 'package:riverpod_example/presentation/new_task/new_task_bloc.dart';
import 'package:rxdart/rxdart.dart';

final _onTaskListChangeSubject = PublishSubject<void>();

final taskListChangeStreamProvider = Provider<Stream<void>>(
  (ref) => _onTaskListChangeSubject.stream,
);

final taskListChangeSinkProvider = Provider<Sink<void>>(
  (ref) => _onTaskListChangeSubject.sink,
);

final _logger = Logger(
  printer: PrettyPrinter(),
);

final taskCDSProvider = Provider<TaskCDS>(
  (_) => TaskCDS(),
);

final taskRepositoryProvider = Provider<TaskDataRepository>(
  (ref) => TaskRepository(
    taskCDS: ref.watch(taskCDSProvider),
  ),
);

final errorLoggerProvider = Provider<ErrorLogger>(
  (ref) => (String errorType, dynamic error, {StackTrace? stackTrace}) {
    final stack = stackTrace ?? (error is Error ? error.stackTrace : null);
    _logger.e(errorType, [error, stack]);
  },
);

final getTaskListUCProvider = Provider<GetTaskListUC>(
  (ref) => GetTaskListUC(
    taskRepository: ref.watch(taskRepositoryProvider),
    logger: ref.watch(errorLoggerProvider),
  ),
);

final upsertTaskUCProvider = Provider<UpsertTaskUC>(
  (ref) => UpsertTaskUC(
    taskRepository: ref.watch(taskRepositoryProvider),
    onTaskListChangeSink: ref.watch(taskListChangeSinkProvider),
    logger: ref.watch(errorLoggerProvider),
  ),
);

final removeTaskUCProvider = Provider<RemoveTaskUC>(
  (ref) => RemoveTaskUC(
    taskRepository: ref.watch(taskRepositoryProvider),
    onTaskListChangeSink: ref.watch(taskListChangeSinkProvider),
    logger: ref.watch(errorLoggerProvider),
  ),
);

final newTaskBlocProvider = Provider<NewTaskBloc>(
  (ref) => NewTaskBloc(
    upsertTaskUC: ref.watch(
      upsertTaskUCProvider,
    ),
  ),
);

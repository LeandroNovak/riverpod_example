import 'package:domain/exceptions.dart';
import 'package:domain/logger.dart';

abstract class UseCase<P, R> {
  const UseCase({
    required this.logger,
  });

  final ErrorLogger logger;

  Future<R> getRawFuture(P params);

  Future<R> getFuture(P params) async {
    try {
      return await getRawFuture(params);
    } catch (error, stackTrace) {
      logger('UseCase Error', error, stackTrace: stackTrace);

      if (error is TaskException) {
        rethrow;
      } else {
        throw UnexpectedException();
      }
    }
  }
}

import 'package:logger/logger.dart';

class ErrorLoggerx {
  final Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> logError(
    String errorType,
    dynamic error, {
    StackTrace? stackTrace,
  }) async {
    final stack = stackTrace ?? (error is Error ? error.stackTrace : null);
    logger.e(errorType, [error, stack]);
  }
}

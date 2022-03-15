typedef ErrorLogger = void Function(
  String errorType,
  dynamic error, {
  StackTrace? stackTrace,
});

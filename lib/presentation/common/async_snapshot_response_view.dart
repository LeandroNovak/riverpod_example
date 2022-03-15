import 'package:flutter/material.dart';

class AsyncSnapshotResponseView<Loading, Error, Success>
    extends StatelessWidget {
  AsyncSnapshotResponseView({
    required this.snapshot,
    required this.successWidgetBuilder,
    this.onTryAgainTap,
    this.loadingWidgetBuilder,
    this.errorWidgetBuilder,
    Key? key,
  })  : assert(Loading != dynamic),
        assert(Error != dynamic),
        assert(Success != dynamic),
        super(key: key);

  final AsyncSnapshot snapshot;
  final Function? onTryAgainTap;
  final Widget Function(BuildContext context, Success success)
      successWidgetBuilder;
  final Widget Function(BuildContext context, Loading? loading)?
      loadingWidgetBuilder;
  final Widget Function(BuildContext context, Error? error)? errorWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final data = snapshot.data;
    if (data == null || data is Loading) {
      if (loadingWidgetBuilder != null) {
        return loadingWidgetBuilder!(context, data);
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is Error) {
      if (errorWidgetBuilder != null) {
        return errorWidgetBuilder!(context, data);
      }
      return Container();
    }

    if (data is Success) {
      return successWidgetBuilder(context, data);
    }
    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}

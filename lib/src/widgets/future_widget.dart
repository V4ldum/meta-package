import 'package:flutter/material.dart';

/// Wrapper around the [FutureBuilder] widget to simplify it's usage
/// [future] is the future that should be awaited
/// [success] is the widget shown in case of success
/// [error] is the widget shown in ase of error
/// [waiting] is the widget shown while waiting for [future]
class FutureWidget<T> extends StatefulWidget {
  /// Constructor fot a [FutureWidget]
  const FutureWidget({
    required this.future,
    required this.success,
    required this.error,
    required this.waiting,
    super.key,
  });

  /// The future to await
  final Future<T> Function() future;

  /// The widget shown in case of success
  final Widget Function(T data) success;

  /// The widget shown in case of error
  final Widget Function(Exception exception, StackTrace stackTrace) error;

  /// The widget shown while waiting for [future]
  final Widget Function() waiting;

  @override
  State<FutureWidget<T>> createState() => _FutureWidgetState<T>();
}

class _FutureWidgetState<T> extends State<FutureWidget<T>> {
  late final Future<T> futureData;

  @override
  void initState() {
    super.initState();
    futureData = widget.future();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.error(snapshot.error! as Exception, snapshot.stackTrace!);
          }
          return widget.success(snapshot.data as T);
        }
        return widget.waiting();
      },
    );
  }
}

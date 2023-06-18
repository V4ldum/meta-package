import 'package:flutter/material.dart';

/// Wrapper around the [FutureBuilder] widget to simplify it's usage
/// [future] is the future that should be awaited
/// [success] is the widget shown in case of success
/// [error] is the widget shown in ase of error
/// [waiting] is the widget shown while waiting for [future]
class FutureWidget<T> extends StatelessWidget {
  /// Constructor fot a [FutureWidget]
  const FutureWidget({
    required this.future,
    required this.success,
    required this.error,
    required this.waiting,
    super.key,
  });

  /// The future to await
  final Future<T> future;

  /// The widget shown in case of success
  final Widget Function(T data) success;

  /// The widget shown in case of error
  final Widget Function(Object error, StackTrace stackTrace) error;

  /// The widget shown while waiting for [future]
  final Widget Function() waiting;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return error(snapshot.error!, snapshot.stackTrace!);
          }
          return success(snapshot.data as T);
        }
        return waiting();
      },
    );
  }
}

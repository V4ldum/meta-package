import 'package:flutter/material.dart';

/// Calls the [onInit] function as soon as this widget is initialized
class InitCaller extends StatefulWidget {
  /// Calls the [onInit] function as soon as this widget is initialized
  const InitCaller({
    super.key,
    this.child,
    this.onInit,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The function to be called when the widget is initialized
  final void Function()? onInit;

  @override
  State<InitCaller> createState() => _StartupCallerState();
}

class _StartupCallerState extends State<InitCaller> {
  @override
  void initState() {
    super.initState();

    widget.onInit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}

import 'package:flutter/material.dart';

/// Calls the [onInit] function as soon as this widget is initialized
class InitCaller extends StatefulWidget {
  /// Calls the [onInit] function as soon as this widget is initialized
  const InitCaller({
    super.key,
    this.child,
    this.onInit,
    this.postFrame = false,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The function to be called when the widget is initialized
  final void Function()? onInit;

  /// Boolean to pass at true if you want to run [onInit] after the UI as fully built
  /// This is useful if you have something that can trigger a rebuild inside [onInit]
  final bool postFrame;

  @override
  State<InitCaller> createState() => _StartupCallerState();
}

class _StartupCallerState extends State<InitCaller> {
  @override
  void initState() {
    super.initState();

    if (widget.postFrame) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onInit?.call();
      });
    } else {
      widget.onInit?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}

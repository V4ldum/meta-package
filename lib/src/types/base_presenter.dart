import 'package:flutter/material.dart';

/// Base class for a Presenter with all the useful helper methods
class BasePresenter {
  /// Executes the function if the context is currently mounted
  void mountGuard(BuildContext context, void Function(BuildContext) func) {
    if (!context.mounted) {
      return;
    }
    func(context);
  }

  /// Display a snack bar
  void displaySnackBar({required BuildContext context, required Widget content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: content),
    );
  }

  /// Display a pop up
  Future<void> displayPopUp({required BuildContext context, required AlertDialog dialog}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}

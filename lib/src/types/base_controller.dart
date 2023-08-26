import 'package:flutter/material.dart';

/// Base class for a Presenter with all the useful helper methods
class BaseController {
  /// Display a snack bar
  void displaySnackBar({required BuildContext context, required Widget content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: content),
    );
  }
}

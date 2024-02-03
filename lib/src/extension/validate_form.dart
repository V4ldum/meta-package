import 'package:flutter/widgets.dart';

/// Extension to the [GlobalKey<FormState>] class to validate a form more easily
extension ValidateForm on GlobalKey<FormState> {
  /// Check if the form referenced by the key is valid
  bool get isFormValid => currentState!.validate();
}

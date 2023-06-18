/// Exception thrown by Option when unwrapping a None instance
final class OptionException implements Exception {
  /// Constructor for an [OptionException]
  OptionException(this.message);

  /// The message sent with the exception
  final String message;
}

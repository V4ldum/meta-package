/// Exception thrown by Result when unwrapping a Err instance
final class ResultException implements Exception {
  /// Constructor for an [ResultException]
  ResultException(this.message);

  /// The message sent with the exception
  final String message;
}

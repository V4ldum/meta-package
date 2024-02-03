/// Wrapper around an exception providing a custom title and message to be able to display the exception in
/// an UI element if needs be
abstract class DisplayableException implements Exception {
  /// Constructor for a [DisplayableException]
  DisplayableException(this.title, this.message);

  /// A title to the exception.
  /// It should be short and impactful
  String title;

  /// A message describing the exception
  String message;

  @override
  String toString() {
    return '[$title]: $message';
  }
}

import 'package:meta_package/src/exceptions/result_exception.dart';
import 'package:meta_package/src/types/option.dart';

/// Represents either a success ([Ok]) or a failure ([Err])
/// Inspired by Rust's std::result
sealed class Result<S, E extends Exception> {
  /// Returns true if the [Result] is [Ok]
  bool get isOk;

  /// Returns true if the [Result] is [Err]
  bool get isErr;

  /// Extracts the contained value if the [Result] is [Ok],
  /// throws an error with a generic message if the [Result] is [Err]
  S unwrap();

  /// Extracts the contained value if the [Result] is [Ok],
  /// or returns what the provided [function] returns if the [Result] is [Err]
  S unwrapOr(S Function() function);

  /// Returns the contained value if the [Result] is [Ok],
  /// throws an error with a custom [message] (if provider) if the [Result] is [Err]
  S expect({String? message});

  /// Transforms a [Result]<S, E> into a [Option]<S>, mapping Ok(value) into Option(value) and Err(e) into None
  Option<S> ok();

  /// Transforms a [Result]<S, E> into a [Option]<E>, mapping Err(error) into Option(error) and Ok(value) into None
  Option<E> err();
}

/// Contains a success value of type [S]
final class Ok<S, E extends Exception> extends Result<S, E> {
  /// Creates an instance of [Ok] with a success value
  Ok(this.value);

  /// The success value
  final S value;

  @override
  bool get isOk => true;

  @override
  bool get isErr => false;

  @override
  S unwrap() {
    return value;
  }

  @override
  S unwrapOr(S Function() function) {
    return unwrap();
  }

  @override
  S expect({String? message}) {
    return unwrap();
  }

  @override
  Option<S> ok() {
    return Some(value);
  }

  @override
  Option<E> err() {
    return None();
  }

  @override
  String toString() {
    return value.toString();
  }
}

/// Contains an error value of type [E]
final class Err<S, E extends Exception> extends Result<S, E> {
  /// Creates an instance of [Err] with an error value
  Err(this.error);

  /// The error value
  final E error;

  @override
  bool get isOk => false;

  @override
  bool get isErr => true;

  @override
  S unwrap() {
    throw ResultException('Operation was not successful : found ${E.runtimeType}');
  }

  @override
  S unwrapOr(S Function() function) {
    return function();
  }

  @override
  S expect({String? message}) {
    if (message != null) {
      throw ResultException(message);
    }
    return unwrap();
  }

  @override
  Option<S> ok() {
    return None();
  }

  @override
  Option<E> err() {
    return Some(error);
  }

  @override
  String toString() {
    return error.toString();
  }
}

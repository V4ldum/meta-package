import 'package:meta_package/src/exceptions/option_exception.dart';
import 'package:meta_package/src/types/result.dart';

/// Represents an optional value, either [Some] if it contains a value or [None] if it does not
/// Inspired by Rust's std::option
sealed class Option<T> {
  /// Returns true if the [Option] is [Some]
  bool get isSome;

  /// Returns true if the [Option] is [None]
  bool get isNone;

  /// Extracts the contained value if the [Option] is [Some],
  /// throws an error with a generic message if the [Option] is [None]
  T unwrap();

  /// Extracts the contained value if the [Option] is [Some],
  /// or returns what the provided [function] returns if the [Option] is [None]
  T unwrapOr(T Function() function);

  /// Returns the contained value if the [Option] is [Some],
  /// throws an error with a custom [message] (if provider) if the [Option] is [None]
  T expect({String? message});

  /// Transforms an [Option]<T> into a [Result]<T, E>, mapping Some(value) to Ok(value) and None to Err(error)
  Result<T, E> okOr<E extends Exception>(E error);

  /// Dart implementation of Rust's match expression
  /// Executes the [some] function if the [Option] is of type [Some],
  /// executes the [none] function if the [Option] is of type [None]
  void match({required void Function(T) some, required void Function() none});

  /// Creates an [Option] based on the value provided : [None] if the value is null, [Some] if it is not
  static Option<T> instance<T>(T? value) {
    if (value == null) {
      return None();
    }
    return Some(value);
  }

  /// Creates an [Option] based on the value provided : [None] if the value is null, [Some] if it is not
  /// Will cast [T] to [T2] using the provided function if the value is not null
  static Option<T2> instanceAs<T, T2>(T? value, T2 Function(T) cast) {
    if (value == null) {
      return None();
    }
    return Some(cast(value));
  }
}

/// Some value of type [T]
final class Some<T> extends Option<T> {
  /// Creates an instance of [Some] with a provided value
  Some(this.value);

  /// The value provided to the instance of [Some]
  final T value;

  @override
  bool get isNone => false;

  @override
  bool get isSome => true;

  @override
  T unwrap() {
    return value;
  }

  @override
  T unwrapOr(T Function() function) {
    return unwrap();
  }

  @override
  T expect({String? message}) {
    return unwrap();
  }

  @override
  Result<T, E> okOr<E extends Exception>(E error) {
    return Ok(value);
  }

  @override
  void match({required void Function(T) some, required void Function() none}) {
    some(value);
  }

  @override
  String toString() {
    return 'Ok($value)';
  }
}

/// No value
final class None<T> extends Option<T> {
  /// Creates an instance of [None]
  None();

  @override
  bool get isNone => true;

  @override
  bool get isSome => false;

  @override
  T unwrap() {
    throw OptionException('Optional value is not present');
  }

  @override
  T unwrapOr(T Function() function) {
    return function();
  }

  @override
  T expect({String? message}) {
    if (message != null) {
      throw OptionException(message);
    }
    return unwrap();
  }

  @override
  Result<T, E> okOr<E extends Exception>(E error) {
    return Err(error);
  }

  @override
  void match({required void Function(T) some, required void Function() none}) {
    none();
  }

  @override
  String toString() {
    return 'None()';
  }
}

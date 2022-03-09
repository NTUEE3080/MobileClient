import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

/// Exception type for Result Monad specific exceptions (such as getting the
/// success value when the Result contained is a failure.
class ResultMonadException implements Exception {
  final String message;

  /// Standard constructor with message to propagate
  ResultMonadException(this.message);

  /// Generates a standard exception for when a user accessed the success value on a monad wrapping a failure
  ResultMonadException.accessSuccessOnFailure()
      : message = 'Attempted to pull a success value from a failure monad';

  /// Generates a standard exception for when a user accesse the error value on a monad wrapping a success
  ResultMonadException.accessFailureOnSuccess()
      : message = 'Attempted to pull a failure value from a success monad';

  @override
  String toString() {
    return 'ResultMonadException{message: $message}';
  }
}

/// A shorthand type notation for Result futures
/// `FutureResult<int,String> func() async {}`
typedef FutureResult<T, E> = Future<Result<T, E>>;

/// The Result Monad type which will encapsulate a success (ok) value of type T
/// or a failure (error) value of type E
class Result<T, E> {
  final T? _value;
  final E? _error;
  final bool _isError;

  /// Create a new Result of the expected error type with the error value
  /// `Result<int,String> getErrorValue() => Result.error('This is an error');`
  Result.error(E error)
      : _value = null,
        _error = error,
        _isError = true;

  /// Create a new Result of the expected success type with the success value
  /// `Result<int,String> getSuccess() => Result.ok(10);`
  Result.ok(T success)
      : _value = success,
        _error = null,
        _isError = false;

  /// Returns the error if it is a failure Result Monad otherwise throws
  /// [ResultMonadException]. It is best to check that it is a failure monad
  /// by calling [isFailure].
  E get error {
    if (_error == null) {
      throw ResultMonadException.accessFailureOnSuccess();
    }

    return _error!;
  }

  /// Returns true if the Result Monad has a failure value, false otherwise
  bool get isFailure => _isError;

  /// Returns true if the Result Monad has a success value, false otherwise
  bool get isSuccess => !_isError;

  /// Returns the value if it is a success Result Monad otherwise throws
  /// [ResultMonadException]. It is best to check that it is a success monad
  /// by calling [isSuccess].
  T get value {
    if (_isError) {
      throw ResultMonadException.accessSuccessOnFailure();
    }
    if (_value == null) {
      return _value as T;
    }
    return _value!;
  }

  /// Executes the anonymous function passing the current value to it to support
  /// operation chaining.
  ///
  /// Example:
  /// ```dart
  /// return doSomething()
  ///   .andThen((r1) => r1.doSomething1())
  ///   .andThen((r2) => r2.doSomething2())
  ///   .andThen((r3) => r3.doSomething3())
  /// ```
  Result<T2, dynamic> andThen<T2, E2>(Result<T2, E2> Function(T) thenFunction) {
    if (isSuccess) {
      return thenFunction(_value!);
    }

    return Result.error(_error!);
  }

  /// Executes the anonymous async function passed in on the current value. Due
  /// to Dart syntax peculiarities it may be cleaner to work with interim
  /// results.
  ///
  /// ```dart
  /// final asyncResult = await doSomething()
  ///   .andThen((r1) => r1.doSomething1())
  ///   .andThen((r2) => r2.doSomething2())
  ///   .andThenAsync((r3) async  => r3.doSomething3())
  ///
  /// return asyncResult
  ///   .andThen((r4) => r4.doSomething4())
  ///   .andThen((r5) => r5.doSomething5())
  /// ```
  FutureResult<T2, dynamic> andThenAsync<T2, E2>(
      FutureResult<T2, E2> Function(T) thenFunction) async {
    if (isSuccess) {
      try {
        return await thenFunction(_value!);
      } catch (e) {
        return Result.error(e);
      }
    }

    return Result.error(_error!);
  }

  /// Maps (folds) the result into a new type consistent across both the
  /// success and failure conditions.
  ///
  /// ```dart
  /// // Mock function
  /// Result<File, FileAccessError> open(String filename) ...
  /// ...
  ///
  /// final size = File.open(filename)
  ///  .fold(
  ///    onSuccess: (file) => file.stat().fileSize(),
  ///    onError: (error) => 0
  ///  );
  /// ```
  ///
  T2 fold<T2>(
      {required T2 Function(T value) onSuccess,
      required T2 Function(E error) onError}) {
    if (isSuccess) {
      return onSuccess(_value!);
    }

    return onError(_error!);
  }

  /// Returns the error value *if* the monad is wrapping a failure or return
  /// the specified default value.
  ///
  /// ```dart
  /// final Result<int,String> result = obj.doSomething();
  /// final error = result.getErrorOrElse(()=>'No error found');
  /// ```
  E getErrorOrElse(E Function() orElse) => _isError ? (_error as E) : orElse();

  /// Returns the success value *if* the monad is wrapping a success or return
  /// the specified default value.
  ///
  /// ```dart
  /// final Result<int,String> result = obj.doSomething();
  /// final value = result.getValueOrElse(()=>-1);;
  /// ```
  T getValueOrElse(T Function() orElse) => _isError ? orElse() : _value as T;

  /// Maps from a monad from one error type to another. This is useful for
  /// transforming from error mappings between APIs etc.
  ///
  ///
  /// ```dart
  /// final Result<int, Exception> result1 = obj.doSomething();
  /// final Result<int, String> result2 = result1.mapError((exception) => exception.message);
  /// ```
  Result<T, E2> mapError<E2>(E2 Function(E error) mapFunction) {
    if (isSuccess) {
      return Result.ok(_value as T);
    }
    final newError = mapFunction(_error as E);
    return Result.error(newError);
  }

  Result<T, E> thenError(Result<T, E> Function(E error) mapFunction) {
    if (isSuccess) {
      return Result.ok(_value!);
    }
    return mapFunction(_error as E);
  }

  /// Maps from a monad from one result type to another. This is useful for
  /// transforming from error mappings between APIs etc.
  ///
  ///
  /// ```dart
  /// final Result<User, Error> serviceResult = service.getUser(id);
  /// final Result<String, Error> addressResult = user.mapValue((user)=>user.address);
  /// ```
  Result<T2, E> mapValue<T2>(T2 Function(T value) mapFunction) {
    if (isFailure) {
      return Result.error(_error as E);
    }
    final newValue = mapFunction(_value as T);
    return Result.ok(newValue);
  }

  /// A mechanism for executing functions on a result monad for each of the two conditions
  /// result.match(
  ///   onSuccess: (value) => log.finest('Result: $value');
  ///   onError: (error) => log.severe('Error getting result: $error');
  /// )
  void match(
      {required Function(T value) onSuccess,
      required Function(E error) onError}) {
    if (isSuccess) {
      onSuccess(_value!);
      return;
    }

    onError(_error!);
  }

  @override
  String toString() {
    return isSuccess ? 'ok($_value)' : 'error($_error)';
  }
}

extension FutureExtension<T, E> on Future<Result<T, E>> {
  Future<Result<T2, E>> thenMap<T2>(T2 Function(T value) mapFunction) async {
    var result = await this;
    return result.mapValue(mapFunction);
  }

  Future<Result<T2, E>> thenMapAsync<T2>(
      Future<T2> Function(T value) mapFunction) async {
    var result = await this;
    return await result.mapValueAsync(mapFunction);
  }

  Future<Result<T, E>> run<T2>(void Function(T value) mapFunction) async {
    var result = await this;
    return result.run(mapFunction);
  }

  Future<Result<T, E>> runAsync<T2>(
      Future<void> Function(T value) mapFunction) async {
    var result = await this;
    return await result.runAsync(mapFunction);
  }

  Future<Result<T2, E>> andThen<T2>(
      Result<T2, E> Function(T value) mapFunction) async {
    var result = await this;
    return result.then(mapFunction);
  }

  Future<Result<T2, E>> andThenAsync<T2>(
      Future<Result<T2, E>> Function(T value) mapFunction) async {
    var result = await this;
    return await result.thenAsync(mapFunction);
  }
}

extension ResultExtension<T, E> on Result<T, E> {
  Future<Result<T2, E>> mapValueAsync<T2>(
      Future<T2> Function(T value) mapFunction) async {
    if (isFailure) {
      return Result.error(error);
    }
    final newValue = await mapFunction(value);
    return Result.ok(newValue);
  }

  Future<Result<T, E2>> mapErrorAsync<E2>(
      Future<E2> Function(E value) mapFunction) async {
    if (isFailure) {
      var e = await mapFunction(error);
      return Result.error(e);
    }
    return Result.ok(value);
  }

  Future<Result<T2, E>> thenAsync<T2>(
      Future<Result<T2, E>> Function(T value) mapFunction) async {
    if (isFailure) {
      return Result.error(error);
    }
    return await mapFunction(value);
  }

  Result<T2, E> then<T2>(Result<T2, E> Function(T value) mapFunction) {
    if (isFailure) return Result.error(error);
    return mapFunction(value);
  }

  Result<T, E> run(void Function(T value) mapFunction) {
    if (isSuccess) {
      mapFunction(value);
    }
    return this;
  }

  Future<Result<T, E>> runAsync(
      Future<void> Function(T value) mapFunction) async {
    if (isSuccess) {
      await mapFunction(value);
    }
    return this;
  }
}

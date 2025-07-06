sealed class Result<TValue, TError> {
  const Result();

  bool get isSuccess => this is Success<TValue, Error>;

  bool get isFailure => this is Error<TValue, Error>;

  TValue get value => (this as Success<TValue, Error>).value;

  TError get error => (this as Error<TValue, TError>).error;

  @override
  String toString() {
    return switch (this) {
      Success() => 'Success(value: $value)',
      Error() => 'Failure(error: $error)',
    };
  }
}

class Success<T, E> extends Result<T, E> {
  @override
  final T value;

  const Success(this.value);

  @override
  String toString() => 'Success(value: $value)';
}

class Error<T, E> extends Result<T, E> {
  @override
  final E error;

  const Error(this.error);

  @override
  String toString() => 'Failure(error: $error)';
}

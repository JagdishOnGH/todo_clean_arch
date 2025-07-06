sealed class Result<TValue, TError> {
  const Result();

  bool get isSuccess => this is DomainSuccess<TValue, TError>;

  bool get isFailure => this is DomainFailure<TValue, TError>;

  TValue get value => (this as DomainSuccess<TValue, TError>).value;

  TError get error => (this as DomainFailure<TValue, TError>).error;

  @override
  String toString() {
    return switch (this) {
      DomainSuccess() => 'Success(value: $value)',
      DomainFailure() => 'Failure(error: $error)',
    };
  }
}

class DomainSuccess<T, E> extends Result<T, E> {
  @override
  final T value;

  const DomainSuccess(this.value);

  @override
  String toString() => 'Success(value: $value)';
}

class DomainFailure<T, E> extends Result<T, E> {
  @override
  final E error;

  const DomainFailure(this.error);

  @override
  String toString() => 'Failure(error: $error)';
}

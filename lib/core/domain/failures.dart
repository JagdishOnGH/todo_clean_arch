abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

//update delete

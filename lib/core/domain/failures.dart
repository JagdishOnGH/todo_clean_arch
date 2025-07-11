//custom class that catches error in repo impl and result them as failure
abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

//invalid input failure
class InvalidInputFailure extends Failure {
  InvalidInputFailure(super.message);
}

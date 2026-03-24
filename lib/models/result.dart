/// A simple Result type for repository operations.
///
/// Usage:
///   final result = await repo.getAllProducts();
///   switch (result) {
///     case Success(data: final products): // use products
///     case Failure(error: final message): // handle error
///   }
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String error;
  final Object? exception;
  const Failure(this.error, {this.exception});
}

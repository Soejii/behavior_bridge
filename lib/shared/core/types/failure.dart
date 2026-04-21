sealed class Failure {
  const Failure({this.stackTrace});
  final StackTrace? stackTrace;
}

class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure(this.message, {super.stackTrace});
}

class NotFoundFailure extends Failure {
  final String message;
  const NotFoundFailure(this.message, {super.stackTrace});
}

class StorageFailure extends Failure {
  final String message;
  const StorageFailure(this.message, {super.stackTrace});
}

class SerializationFailure extends Failure {
  final String message;
  const SerializationFailure(this.message, {super.stackTrace});
}

class UnknownFailure extends Failure {
  final Object error;
  const UnknownFailure(this.error, {required super.stackTrace});
}

String errorToMessage(Object error) {
  if (error is Failure) {
    return switch (error) {
      ValidationFailure(:final message) =>
        message.isEmpty ? 'Validation failed.' : message,
      NotFoundFailure(:final message) =>
        message.isEmpty ? 'Not found.' : message,
      StorageFailure(:final message) =>
        message.isEmpty ? 'Storage error.' : message,
      SerializationFailure(:final message) =>
        message.isEmpty ? 'Failed to read saved data.' : message,
      UnknownFailure(:final error) => 'Unexpected error: $error',
    };
  }
  return error.toString();
}

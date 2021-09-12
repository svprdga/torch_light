part of 'torch_light.dart';

class EnableTorchExistentUserException implements Exception {
  String? message;

  EnableTorchExistentUserException(this.message);

  @override
  String toString() => "[EnableTorchExistentUserException: $message]";
}

class EnableTorchException implements Exception {
  String? message;

  EnableTorchException(this.message);

  @override
  String toString() => "[EnableTorchException: $message]";
}

class EnableTorchNotAvailableException implements Exception {
  String? message;

  EnableTorchNotAvailableException(this.message);

  @override
  String toString() => "[EnableTorchNotAvailableException: $message]";
}

class DisableTorchExistentUserException implements Exception {
  String? message;

  DisableTorchExistentUserException(this.message);

  @override
  String toString() => "[DisableTorchExistentUserException: $message]";
}

class DisableTorchException implements Exception {
  String? message;

  DisableTorchException(this.message);

  @override
  String toString() => "[DisableTorchException: $message]";
}

class DisableTorchNotAvailableException implements Exception {
  String? message;

  DisableTorchNotAvailableException(this.message);

  @override
  String toString() => "[DisableTorchNotAvailableException: $message]";
}

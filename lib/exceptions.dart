part of 'torch_light.dart';

class EnableTorchExistentUserException implements Exception {
  String? message;

  EnableTorchExistentUserException([this.message]);

  @override
  String toString() => message != null
      ? "[EnableTorchExistentUserException: $message]"
      : "[EnableTorchExistentUserException has received a null message]";
}

class EnableTorchException implements Exception {
  String? message;

  EnableTorchException([this.message]);

  @override
  String toString() => message != null
      ? "[EnableTorchException: $message]"
      : "[EnableTorchException has received a null message]";
}

class EnableTorchNotAvailableException implements Exception {
  String? message;

  EnableTorchNotAvailableException([this.message]);

  @override
  String toString() => message != null
      ? "[EnableTorchNotAvailableException: $message]"
      : "[EnableTorchNotAvailableException has received a null message]";
}

class DisableTorchExistentUserException implements Exception {
  String? message;

  DisableTorchExistentUserException([this.message]);

  @override
  String toString() => message != null
      ? "[DisableTorchExistentUserException: $message]"
      : "[DisableTorchExistentUserException has received a null message]";
}

class DisableTorchException implements Exception {
  String? message;

  DisableTorchException([this.message]);

  @override
  String toString() => message != null
      ? "[DisableTorchException: $message]"
      : "[DisableTorchException has received a null message]";
}

class DisableTorchNotAvailableException implements Exception {
  String? message;

  DisableTorchNotAvailableException([this.message]);

  @override
  String toString() => message != null
      ? "[DisableTorchNotAvailableException: $message]"
      : "[DisableTorchNotAvailableException has received a null message]";
}

part of 'torch_light.dart';

class EnableTorchExistentUserException implements Exception {
  String? message;

  EnableTorchExistentUserException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchExistentUserException: $message]"
      : "[EnableTorchExistentUserException]";
}

class EnableTorchException implements Exception {
  String? message;

  EnableTorchException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchException: $message]"
      : "[EnableTorchException]";
}

class EnableTorchNotAvailableException implements Exception {
  String? message;

  EnableTorchNotAvailableException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchNotAvailableException: $message]"
      : "[EnableTorchNotAvailableException]";
}

class DisableTorchExistentUserException implements Exception {
  String? message;

  DisableTorchExistentUserException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchExistentUserException: $message]"
      : "[DisableTorchExistentUserException]";
}

class DisableTorchException implements Exception {
  String? message;

  DisableTorchException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchException: $message]"
      : "[DisableTorchException]";
}

class DisableTorchNotAvailableException implements Exception {
  String? message;

  DisableTorchNotAvailableException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchNotAvailableException: $message]"
      : "[DisableTorchNotAvailableException]";
}

class CheckTorchStrengthException implements Exception {
  String? message;

  CheckTorchStrengthException({this.message});

  @override
  String toString() => message != null
      ? "[CheckTorchStrengthException: $message]"
      : "[CheckTorchStrengthException]";
}

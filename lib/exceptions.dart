part of 'torch_light.dart';

/// Exception thrown when an attempt was made to turn on the torch but it was
/// detected that the camera was being used by another process.
/// This means that the torch cannot be controlled.
class EnableTorchExistentUserException implements Exception {
  /// Informative message about this exception.
  String? message;

  /// Exception thrown when an attempt was made to turn on the torch but it was
  /// detected that the camera was being used by another process.
  /// This means that the torch cannot be controlled.
  EnableTorchExistentUserException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchExistentUserException: $message]"
      : "[EnableTorchExistentUserException]";
}

/// Exception thrown when an error occurred while trying to turn on the
/// device torch.
class EnableTorchException implements Exception {
  /// Informative message about this exception.
  String? message;

  /// Exception thrown when an error occurred while trying to turn on the
  /// device torch.
  EnableTorchException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchException: $message]"
      : "[EnableTorchException]";
}

/// Exception thrown when an attempt was made to turn on the torch but it was
/// detected that the device does not have one equipped.
class EnableTorchNotAvailableException implements Exception {
  /// Informative message about this exception.
  String? message;

  /// Exception thrown when an attempt was made to turn on the torch but it was
  /// detected that the device does not have one equipped.
  EnableTorchNotAvailableException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchNotAvailableException: $message]"
      : "[EnableTorchNotAvailableException]";
}

/// Exception thrown when an attempt was made to turn off the torch but it was
/// detected that the camera was being used by another process.
/// This means that the torch cannot be controlled.
class DisableTorchExistentUserException implements Exception {
  /// Informative message about this exception.
  String? message;

  /// Exception thrown when an attempt was made to turn off the torch but it was
  /// detected that the camera was being used by another process.
  /// This means that the torch cannot be controlled.
  DisableTorchExistentUserException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchExistentUserException: $message]"
      : "[DisableTorchExistentUserException]";
}

/// Exception thrown when an error occurred while trying to turn off the
/// device torch.
class DisableTorchException implements Exception {
  /// Informative message about this exception.
  String? message;

  /// Exception thrown when an error occurred while trying to turn off the
  /// device torch.
  DisableTorchException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchException: $message]"
      : "[DisableTorchException]";
}

/// Exception thrown when an attempt was made to turn off the torch but it was
/// detected that the device does not have one equipped.
class DisableTorchNotAvailableException implements Exception {
  /// Informative message about this exception.
  String? message;

  /// Exception thrown when an attempt was made to turn off the torch but it was
  /// detected that the device does not have one equipped.
  DisableTorchNotAvailableException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchNotAvailableException: $message]"
      : "[DisableTorchNotAvailableException]";
}

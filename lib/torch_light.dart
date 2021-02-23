import 'dart:async';

import 'package:flutter/services.dart';

part 'exceptions.dart';

class TorchLight {
  // ****************************** CONSTANTS ****************************** //

  static const _CHANNEL_NAME = 'com.svprdga.torchlight/main';

  static const NATIVE_EVENT_ENABLE_TORCH = 'enable_torch';
  static const ERROR_ENABLE_TORCH_EXISTENT_USER =
      'enable_torch_error_existent_user';
  static const ERROR_ENABLE_TORCH = 'enable_torch_error';
  static const ERROR_ENABLE_TORCH_NOT_AVAILABLE = 'enable_torch_not_available';

  static const NATIVE_EVENT_DISABLE_TORCH = 'disable_torch';
  static const ERROR_DISABLE_TORCH_EXISTENT_USER =
      'disable_torch_error_existent_user';
  static const ERROR_DISABLE_TORCH = 'disable_torch_error';
  static const ERROR_DISABLE_TORCH_NOT_AVAILABLE =
      'disable_torch_not_available';

  // ********************************* VARS ******************************** //

  static const MethodChannel _channel = const MethodChannel(_CHANNEL_NAME);

  //***************************** PUBLIC METHODS *************************** //

  /// Enables the device torch.
  ///
  /// Throws an [EnableTorchExistentUserException] if the camera is being used by another user.
  /// Throws an [EnableTorchNotAvailableException] if a torch was not detected.
  /// Throws an [EnableTorchException] if the process encounters an error.
  static Future<void> enableTorch() async {
    try {
      await _channel.invokeMethod(NATIVE_EVENT_ENABLE_TORCH);
    } on PlatformException catch (e) {
      switch (e.code) {
        case ERROR_ENABLE_TORCH_EXISTENT_USER:
          throw EnableTorchExistentUserException(e.message);
        case ERROR_ENABLE_TORCH_NOT_AVAILABLE:
          throw EnableTorchNotAvailableException(e.message);
        default:
          throw EnableTorchException(e.message);
      }
    }
  }

  /// Disables the device torch.
  ///
  /// Throws an [DisableTorchExistentUserException] if the camera is being used by another user.
  /// Throws an [DisableTorchNotAvailableException] if a torch was not detected.
  /// Throws a [DisableTorchException] if the process encounters an error.
  static Future<void> disableTorch() async {
    try {
      await _channel.invokeMethod(NATIVE_EVENT_DISABLE_TORCH);
    } on PlatformException catch (e) {
      switch (e.code) {
        case ERROR_DISABLE_TORCH_EXISTENT_USER:
          throw DisableTorchExistentUserException(e.message);
        case ERROR_DISABLE_TORCH_NOT_AVAILABLE:
          throw DisableTorchNotAvailableException(e.message);
        default:
          throw DisableTorchException(e.message);
      }
    }
  }
}

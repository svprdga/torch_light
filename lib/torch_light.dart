import 'dart:async';

import 'package:flutter/services.dart';

part 'exceptions.dart';

/// This is the main class of the plugin from which it is possible to check
/// whether the device has a torch or not, and to turn it on and off.
class TorchLight {
  // ****************************** CONSTANTS ****************************** //

  static const _channelName = 'com.svprdga.torchlight/main';

  static const _nativeEventIsTorchAvailable = 'torch_available';

  static const _nativeEventEnableTorch = 'enable_torch';
  static const _errorEnableTorchExistentUser =
      'enable_torch_error_existent_user';
  static const _errorEnableTorchNotAvailable = 'enable_torch_not_available';

  static const _nativeEventDisableTorch = 'disable_torch';
  static const _errorDisableTorchExistentUser =
      'disable_torch_error_existent_user';
  static const _errorDIsableTorchNotAvailable = 'disable_torch_not_available';

  // ********************************* VARS ******************************** //

  static const MethodChannel _channel = MethodChannel(_channelName);

  //***************************** PUBLIC METHODS *************************** //

  /// Returns true if the device has a torch available, false otherwise.
  ///
  /// - Throws an [EnableTorchException] if the process encounters an error.
  static Future<bool> isTorchAvailable() async {
    try {
      return await _channel.invokeMethod(_nativeEventIsTorchAvailable) as bool;
    } on PlatformException catch (e) {
      throw EnableTorchException(message: e.message);
    }
  }

  /// Enables the device torch.
  ///
  /// - Throws an [EnableTorchExistentUserException] if the camera is being used
  /// by another process.
  /// - Throws an [EnableTorchNotAvailableException] if a torch was not detected.
  /// - Throws an [EnableTorchException] if the process encounters an error.
  static Future<void> enableTorch() async {
    try {
      await _channel.invokeMethod(_nativeEventEnableTorch);
    } on PlatformException catch (e) {
      switch (e.code) {
        case _errorEnableTorchExistentUser:
          throw EnableTorchExistentUserException(message: e.message);
        case _errorEnableTorchNotAvailable:
          throw EnableTorchNotAvailableException(message: e.message);
        default:
          throw EnableTorchException(message: e.message);
      }
    }
  }

  /// Disables the device torch.
  ///
  /// - Throws a [DisableTorchExistentUserException] if the camera is being used
  /// by another process.
  /// - Throws a [DisableTorchNotAvailableException] if a torch was not detected.
  /// - Throws a [DisableTorchException] if the process encounters an error.
  static Future<void> disableTorch() async {
    try {
      await _channel.invokeMethod(_nativeEventDisableTorch);
    } on PlatformException catch (e) {
      switch (e.code) {
        case _errorDisableTorchExistentUser:
          throw DisableTorchExistentUserException(message: e.message);
        case _errorDIsableTorchNotAvailable:
          throw DisableTorchNotAvailableException(message: e.message);
        default:
          throw DisableTorchException(message: e.message);
      }
    }
  }
}

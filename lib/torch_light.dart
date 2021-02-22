import 'dart:async';

import 'package:flutter/services.dart';

class EnableTorchException implements Exception {
  String message;

  EnableTorchException(this.message);

  @override
  String toString() => "[EnableTorchException: $message]";
}

class DisableTorchException implements Exception {
  String message;

  DisableTorchException(this.message);

  @override
  String toString() => "[DisableTorchException: $message]";
}

class TorchLight {
  // ****************************** CONSTANTS ****************************** //

  static const _CHANNEL_NAME = 'com.svprdga.torchlight/main';

  static const NATIVE_EVENT_ENABLE_TORCH = 'enable_torch';
  static const ERROR_ENABLE_TORCH = 'enable_torch_error';

  static const NATIVE_EVENT_DISABLE_TORCH = 'disable_torch';
  static const ERROR_DISABLE_TORCH = 'disable_torch_error';

  // ********************************* VARS ******************************** //

  static const MethodChannel _channel = const MethodChannel(_CHANNEL_NAME);

  //***************************** PUBLIC METHODS *************************** //

  /// Enables the device torch.
  ///
  /// Throws an EnableTorchException if the process encounters an error.
  static Future<void> enableTorch() async {
    try {
      await _channel.invokeMethod(NATIVE_EVENT_ENABLE_TORCH);
    } on PlatformException catch (e) {
      throw EnableTorchException(e.message);
    }
  }

  /// Disables the device torch.
  ///
  /// Throws a DisableTorchException if the process encounters an error.
  static Future<void> disableTorch() async {
    try {
      await _channel.invokeMethod(NATIVE_EVENT_DISABLE_TORCH);
    } on PlatformException catch (e) {
      throw DisableTorchException(e.message);
    }
  }
}

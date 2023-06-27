import 'dart:async';

import 'package:flutter/services.dart';

part 'exceptions.dart';

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

  static const _nativeEventStrengthMaximumLevel = 'strength_maximum_level';

  static const _nativeEventEnableTorchWithStrengthLevel =
      'enable_torch_with_strength_level';
  static const _errorEnableTorchWithStrengthLevelExistentUser =
      'enable_torch_with_strength_level_existent_user';
  static const _errorEnableTorchWithStrengthLevelNotAvailable =
      'enable_torch_with_strength_level_not_available';
  static const _errorEnableTorchWithStrengthLevelInvalidValue =
      'enable_torch_with_strength_level_invalid_value';

  // ********************************* VARS ******************************** //

  static const MethodChannel _channel = MethodChannel(_channelName);

  //***************************** PUBLIC METHODS *************************** //

  /// Returns true if the device has a torch available, false otherwise.
  /// <br/><br/>
  /// You can also call the [getStrengthMaximumLevel] method to get the maximum torch strenght level, besides knowing if the device has an available torch.
  /// <br/><br/>
  /// Throws an [EnableTorchException] if the process encounters an error.
  static Future<bool> isTorchAvailable() async {
    try {
      return await _channel.invokeMethod(_nativeEventIsTorchAvailable) as bool;
    } on PlatformException catch (e) {
      throw EnableTorchException(message: e.message);
    }
  }

  /// Enables the device torch.
  /// <br/><br/>
  /// Throws an [EnableTorchExistentUserException] if the camera is being used by another user.
  /// Throws an [EnableTorchNotAvailableException] if a torch was not detected.
  /// Throws an [EnableTorchException] if the process encounters an error.
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
  /// <br/><br/>
  /// Throws a [DisableTorchExistentUserException] if the camera is being used by another user.<br/>
  /// Throws a [DisableTorchNotAvailableException] if a torch was not detected.<br/>
  /// Throws a [DisableTorchException] if the process encounters an error.<br/>
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

  /// Checks the maximum strength level of the torch.
  /// <br/><br/>
  /// On Android, this method returns a double value that must be interpreted in the following way:
  ///
  /// - A value equal to 0.0 indicates that the device doesn't have a torch.
  /// - A value equal to 1.0 indicates that the device has a torch but its strength can't be configured.
  /// - A value greater than 1.0 indicates the maximum strength level of the device torch. This value comes as a double but won't never have decimal units.
  ///
  /// On iOS, this method returns a double value that must be interpreted in the following way:
  ///
  /// - A value equal to 0.0 indicates that the device doesn't have a torch.
  /// - A value different than 0.0 indicates the current maximum strenght level of the torch.
  ///
  /// Throws a [CheckTorchStrengthException] if the torch strength could not be retrieved.
  static Future<double> getStrengthMaximumLevel() async {
    try {
      final result = await _channel
          .invokeMethod(_nativeEventStrengthMaximumLevel) as double;
      return result;
    } on PlatformException catch (_) {
      throw CheckTorchStrengthException(
        message: 'Could not retrieve torch strength.',
      );
    }
  }

  /// Enables the torch with the provided [value] as its strength level.
  /// <br/><br/>
  /// Before calling this method, the caller should know the maximum strength level of the built-in torch. You can check this value by calling the [getStrengthMaximumLevel()] method. <br/>
  /// If the device doesn't support setting the strength level of the torch, then the torch will be turned on with its default strength value.
  /// <br/><br/>
  /// Throws an [EnableTorchWithStrengthLevelExistentUserException] if the camera is being used by another user.<br/>
  /// Throws an [EnableTorchWithStrengthLevelNotAvailableException] if a torch was not detected.<br/>
  /// Throws an [EnableTorchWithStrengthLevelInvalidValueException] if the provided [value] is not valid. Call the [getStrengthMaximumLevel] method to get the maximum level of strength.<br/>
  /// Throws an [EnableTorchWithStrengthLevelException] if the process encounters an error.<br/>
  static Future<void> enableTorchWithStrengthLevel(double level) async {
    try {
      await _channel
          .invokeMethod(_nativeEventEnableTorchWithStrengthLevel, [level]);
    } on PlatformException catch (e) {
      switch (e.code) {
        case _errorEnableTorchWithStrengthLevelExistentUser:
          throw EnableTorchWithStrengthLevelExistentUserException(
            message: e.message,
          );
        case _errorEnableTorchWithStrengthLevelNotAvailable:
          throw EnableTorchWithStrengthLevelNotAvailableException(
            message: e.message,
          );
        case _errorEnableTorchWithStrengthLevelInvalidValue:
          throw EnableTorchWithStrengthLevelInvalidValueException(
            message: e.message,
          );
        default:
          throw EnableTorchWithStrengthLevelException(message: e.message);
      }
    }
  }
}

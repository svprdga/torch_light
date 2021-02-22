
import 'dart:async';

import 'package:flutter/services.dart';

class TorchLight {

  // ********************************* VARS ******************************** //

  static const MethodChannel _channel =
      const MethodChannel('torch_light');

  //***************************** PUBLIC METHODS *************************** //

  static Future<void> enableTorch() async {
    await _channel.invokeMethod('enable_torch');
  }

  static Future<void> disableTorch() async {
    await _channel.invokeMethod('disable_torch');
  }

}

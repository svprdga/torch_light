
import 'dart:async';

import 'package:flutter/services.dart';

class TorchLight {
  static const MethodChannel _channel =
      const MethodChannel('torch_light');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  const MethodChannel channel = MethodChannel('torch_light');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TorchLight.platformVersion, '42');
  });
}

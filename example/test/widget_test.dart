import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:torch_light_example/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('com.svprdga.torchlight/main');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('Renders enable and disable buttons when torch is available',
      (WidgetTester tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'torch_available') {
        return true;
      }
      return null;
    });

    await tester.pumpWidget(const TorchApp());
    await tester.pumpAndSettle();

    expect(find.text('Enable torch'), findsOneWidget);
    expect(find.text('Disable torch'), findsOneWidget);
    expect(find.byIcon(Icons.flash_on), findsOneWidget);
  });

  testWidgets('Renders caution card when torch is not available',
      (WidgetTester tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'torch_available') {
        return false;
      }
      return null;
    });

    await tester.pumpWidget(const TorchApp());
    await tester.pumpAndSettle();

    expect(find.text('Caution: No Flash / Torch Available'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}


import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('com.svprdga.torchlight/main');
  final log = <MethodCall>[];

  tearDown(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('isTorchAvailable', () {
    test('returns true when torch is available', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == 'torch_available') {
          return true;
        }
        return null;
      });

      final result = await TorchLight.isTorchAvailable();

      expect(result, isTrue);
      expect(log, <Matcher>[
        isMethodCall('torch_available', arguments: null),
      ]);
    });

    test('returns false when torch is not available', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == 'torch_available') {
          return false;
        }
        return null;
      });

      final result = await TorchLight.isTorchAvailable();

      expect(result, isFalse);
      expect(log, <Matcher>[
        isMethodCall('torch_available', arguments: null),
      ]);
    });

    test('throws EnableTorchException on PlatformException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'SOME_ERROR',
          message: 'Torch check failed',
        );
      });

      expect(
        () => TorchLight.isTorchAvailable(),
        throwsA(
          isA<EnableTorchException>().having(
            (e) => e.message,
            'message',
            'Torch check failed',
          ),
        ),
      );
    });
  });

  group('enableTorch', () {
    test('calls enable_torch successfully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });

      await TorchLight.enableTorch();

      expect(log, <Matcher>[
        isMethodCall('enable_torch', arguments: null),
      ]);
    });

    test('throws EnableTorchExistentUserException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'enable_torch_error_existent_user',
          message: 'Camera in use',
        );
      });

      expect(
        () => TorchLight.enableTorch(),
        throwsA(
          isA<EnableTorchExistentUserException>().having(
            (e) => e.message,
            'message',
            'Camera in use',
          ),
        ),
      );
    });

    test('throws EnableTorchNotAvailableException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'enable_torch_not_available',
          message: 'Torch not available',
        );
      });

      expect(
        () => TorchLight.enableTorch(),
        throwsA(
          isA<EnableTorchNotAvailableException>().having(
            (e) => e.message,
            'message',
            'Torch not available',
          ),
        ),
      );
    });

    test('throws generic EnableTorchException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'unknown_error',
          message: 'Unknown failure',
        );
      });

      expect(
        () => TorchLight.enableTorch(),
        throwsA(
          isA<EnableTorchException>().having(
            (e) => e.message,
            'message',
            'Unknown failure',
          ),
        ),
      );
    });
  });

  group('disableTorch', () {
    test('calls disable_torch successfully', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });

      await TorchLight.disableTorch();

      expect(log, <Matcher>[
        isMethodCall('disable_torch', arguments: null),
      ]);
    });

    test('throws DisableTorchExistentUserException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'disable_torch_error_existent_user',
          message: 'Camera in use',
        );
      });

      expect(
        () => TorchLight.disableTorch(),
        throwsA(
          isA<DisableTorchExistentUserException>().having(
            (e) => e.message,
            'message',
            'Camera in use',
          ),
        ),
      );
    });

    test('throws DisableTorchNotAvailableException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'disable_torch_not_available',
          message: 'Torch not available',
        );
      });

      expect(
        () => TorchLight.disableTorch(),
        throwsA(
          isA<DisableTorchNotAvailableException>().having(
            (e) => e.message,
            'message',
            'Torch not available',
          ),
        ),
      );
    });

    test('throws generic DisableTorchException', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        throw PlatformException(
          code: 'unknown_error',
          message: 'Unknown failure',
        );
      });

      expect(
        () => TorchLight.disableTorch(),
        throwsA(
          isA<DisableTorchException>().having(
            (e) => e.message,
            'message',
            'Unknown failure',
          ),
        ),
      );
    });
  });

  group('Exceptions toString', () {
    test('formats messages properly', () {
      expect(
        EnableTorchExistentUserException(message: 'msg').toString(),
        '[EnableTorchExistentUserException: msg]',
      );
      expect(
        EnableTorchExistentUserException().toString(),
        '[EnableTorchExistentUserException]',
      );
      expect(
        EnableTorchException(message: 'msg').toString(),
        '[EnableTorchException: msg]',
      );
      expect(
        EnableTorchException().toString(),
        '[EnableTorchException]',
      );
      expect(
        EnableTorchNotAvailableException(message: 'msg').toString(),
        '[EnableTorchNotAvailableException: msg]',
      );
      expect(
        EnableTorchNotAvailableException().toString(),
        '[EnableTorchNotAvailableException]',
      );
      expect(
        DisableTorchExistentUserException(message: 'msg').toString(),
        '[DisableTorchExistentUserException: msg]',
      );
      expect(
        DisableTorchExistentUserException().toString(),
        '[DisableTorchExistentUserException]',
      );
      expect(
        DisableTorchException(message: 'msg').toString(),
        '[DisableTorchException: msg]',
      );
      expect(
        DisableTorchException().toString(),
        '[DisableTorchException]',
      );
      expect(
        DisableTorchNotAvailableException(message: 'msg').toString(),
        '[DisableTorchNotAvailableException: msg]',
      );
      expect(
        DisableTorchNotAvailableException().toString(),
        '[DisableTorchNotAvailableException]',
      );
    });
  });
}

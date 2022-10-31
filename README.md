# torch_light

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

A simple Flutter plugin to manage the device torch / flashlight.

## Import the library in your Dart code

```
import 'package:torch_light/torch_light.dart';
```

## Check if the device has an available torch

```
try {
  final isTorchAvailable = await TorchLight.isTorchAvailable();
} on Exception catch (_) {
  // Handle error
}
```

## Enable/disable torch

Enable and disable the device torch / flash:

```
try {
  await TorchLight.enableTorch();
} on Exception catch (_) {
  // Handle error
}

try {
  await TorchLight.disableTorch();
} on Exception catch (_) {
  // Handle error
}
```

If you want further control over the errors, you can declare explicit exceptions:

```
// Enable torch and manage all kind of errors
try {
  await TorchLight.enableTorch();
} on EnableTorchExistentUserException catch (e) {
  // The camera is in use
} on EnableTorchNotAvailableException catch (e) {
  // Torch was not detected
} on EnableTorchException catch (e) {
  // Torch could not be enabled due to another error
}

// Disable torch and manage all kind of errors
try {
  await TorchLight.disableTorch();
} on DisableTorchExistentUserException catch (e) {
  // The camera is in use
} on DisableTorchNotAvailableException catch (e) {
  // Torch was not detected
} on DisableTorchException catch (e) {
  // Torch could not be disabled due to another error
}
```


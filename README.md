# torch_light

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

A simple Flutter plugin to enable/disable the device torch light.

## Plugin status

This plugin is considered in BETA stage, could potentially contain errors and API might change. Please, use it with caution.

## Import the library in your Dart code

```
import 'package:torch_light/torch_light.dart';
```

## Enable/disable torch

Enable and disable the device torch:

```
// Enable torch
TorchLight.enableTorch();

// Disable torch
TorchLight.disableTorch();
```

This methods can throw an error if the process could not be completed, it is recommended to wrap them like that:

```
// Safely enable torch and watch errors
try {
  await TorchLight.enableTorch();
} on Exception catch (_) {
  // Handle error
}

// Safely disable torch and watch errors
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


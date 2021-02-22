# torch_light

A simple Flutter plugin to enable/disable the device torch light.

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
} on EnableTorchException catch (e) {
  // Handle error
}

// Safely disable torch and watch errors
try {
  await TorchLight.disableTorch();
} on DisableTorchException catch (e) {
  // Handle error
}
```


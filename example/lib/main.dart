import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const TorchApp());
}

class TorchApp extends StatelessWidget {
  const TorchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'torch_light example app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      supportedLocales: const [Locale('en', '')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const TorchController(),
    );
  }
}

class TorchController extends StatefulWidget {
  const TorchController({super.key});

  @override
  State<TorchController> createState() => _TorchControllerState();
}

class _TorchControllerState extends State<TorchController> {
  late Future<bool> _isTorchAvailableFuture;

  @override
  void initState() {
    super.initState();
    _isTorchAvailableFuture = _checkTorchAvailability();
  }

  Future<bool> _checkTorchAvailability() async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception {
      // If the platform throws (e.g. on iOS simulator where AVCaptureDevice is nil),
      // it means a physical torch is unavailable.
      return false;
    }
  }

  void _retry() {
    setState(() {
      _isTorchAvailableFuture = _checkTorchAvailability();
    });
  }

  Future<void> _enableTorch(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await TorchLight.enableTorch();
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Torch enabled')),
      );
    } on Exception catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Could not enable torch: $e')),
      );
    }
  }

  Future<void> _disableTorch(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await TorchLight.disableTorch();
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Torch disabled')),
      );
    } on Exception catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Could not disable torch: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('torch_light example app'),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: _isTorchAvailableFuture,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final isAvailable = snapshot.data ?? false;

            if (isAvailable) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.flash_on,
                      size: 64,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.highlight),
                        label: const Text('Enable torch'),
                        onPressed: () => _enableTorch(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.flash_off),
                        label: const Text('Disable torch'),
                        onPressed: () => _disableTorch(context),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Caution message if the device doesn't have a flash/torch
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Caution: No Flash / Torch Available',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.error,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This device does not have a camera flash, or torch hardware is not supported (e.g. on simulators without a camera flash).',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        onPressed: _retry,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

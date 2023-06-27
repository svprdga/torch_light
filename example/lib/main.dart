import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(TorchApp());
}

class TorchApp extends StatefulWidget {
  @override
  _TorchAppState createState() => _TorchAppState();
}

class _TorchAppState extends State<TorchApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('en', '')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: TorchController(),
    );
  }
}

class TorchController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('torch_light example app'),
      ),
      body: FutureBuilder<bool>(
        future: _isTorchAvailable(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      child: const Text('Enable torch'),
                      onPressed: () async {
                        _enableTorch(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      child: const Text('Disable torch'),
                      onPressed: () {
                        _disableTorch(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      child: const Text('Get strength level'),
                      onPressed: () {
                        _getStrengthMaximumLevel(context);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            return const Center(
              child: Text('No torch available.'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<bool> _isTorchAvailable(BuildContext context) async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      _showMessage(
        'Could not check if the device has an available torch',
        context,
      );
      rethrow;
    }
  }

  Future<void> _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  Future<void> _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not disable torch', context);
    }
  }

  Future<void> _getStrengthMaximumLevel(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late final String message;

    try {
      final result = await TorchLight.getStrengthMaximumLevel();
      message = 'Maximum strength level: $result';
    } on Exception catch (_) {
      message = 'Could not get maximum strength level';
    }

    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

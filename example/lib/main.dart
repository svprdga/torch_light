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
  GlobalKey<ScaffoldMessengerState> _messangerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('en', '')],
      scaffoldMessengerKey: _messangerKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('torch_light example app'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: ElevatedButton(
                child: Text('Enable torch'),
                onPressed: () async {
                  _enableTorch(context);
                },
              ),
            )),
            Expanded(
                child: Center(
              child: ElevatedButton(
                child: Text('Disable torch'),
                onPressed: () {
                  _disableTorch(context);
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch');
    }
  }

  _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not disable torch');
    }
  }

  _showMessage(String message) {
    _messangerKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}

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
    return MaterialApp(supportedLocales: [
      Locale('en', '')
    ], localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ], home: TorchController());
  }
}

class TorchController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  _enableTorch(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      _showMessage('Could not enable torch', context);
    }
  }

  _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      _showMessage('Could not disable torch', context);
    }
  }

  _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

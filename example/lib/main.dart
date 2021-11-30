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
        body: FutureBuilder<bool>(
          future: _isTorchAvailable(context),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return Column(
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
              );
            } else if (snapshot.hasData) {
              return Center(
                child: Text('No torch available.'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<bool> _isTorchAvailable(BuildContext context) async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      _showMessage(
          'Could not check if the device has an available torch', context);
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

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

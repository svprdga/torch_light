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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('en', '')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('torch_light example app'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: RaisedButton(
                child: Text('Enable torch'),
                onPressed: () async {
                  _enableTorch(context);
                },
              ),
            )),
            Expanded(
                child: Center(
              child: RaisedButton(
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
    } on EnableTorchException catch (e) {
      _showMessage(e.message);
    }
  }

  _disableTorch(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
    } on DisableTorchException catch (e) {
      _showMessage(e.message);
    }
  }

  _showMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

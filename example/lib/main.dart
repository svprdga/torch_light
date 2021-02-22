import 'package:flutter/material.dart';
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('torch_light example app'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: RaisedButton(
                child: Text('Enable torch'),
                onPressed: () {
                  TorchLight.enableTorch();
                },
              ),
            )),
            Expanded(
                child: Center(
              child: RaisedButton(
                child: Text('Disable torch'),
                onPressed: () {
                  TorchLight.disableTorch();
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class AdvancedTab extends StatefulWidget {
  @override
  State<AdvancedTab> createState() => _AdvancedTabState();
}

class _AdvancedTabState extends State<AdvancedTab> {
  late final Future<double> _future;
  double _value = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _future = TorchLight.getStrengthMaximumLevel();
  }

  @override
  void dispose() {
    _stopSetLevelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasData && snapshot.data == 0.0) {
          return const Center(
            child: Text('No torch available.'),
          );
        } else if (snapshot.hasData &&
            snapshot.data == 1.0 &&
            Platform.isAndroid) {
          return const Center(
            child: Text("This torch doesn't allow to set a strength level."),
          );
        } else if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
                child: Text('Max torch level: ${snapshot.data}'),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
                child: Text('Current level: $_value'),
              ),
              Expanded(
                child: Slider(
                  value: _value,
                  max: snapshot.data!,
                  label: _value.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _value = value;
                    });
                    _startSetLevelTimer();
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: _disableTorch,
                    child: const Text('Disable torch'),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _startSetLevelTimer() {
    _stopSetLevelTimer();
    _timer = Timer(const Duration(seconds: 1), () {
      _enableTorchWithStrengthLevel(_value);
    });
  }

  void _stopSetLevelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _enableTorchWithStrengthLevel(double value) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await TorchLight.enableTorchWithStrengthLevel(value);
    } on Exception catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> _disableTorch() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await TorchLight.disableTorch();
      setState(() {
        _value = 0.0;
      });
    } on Exception catch (_) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Could not disable torch'),
        ),
      );
    }
  }
}

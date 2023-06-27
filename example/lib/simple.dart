import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class SimpleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
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

  void _showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

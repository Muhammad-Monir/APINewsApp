import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkStatusDialog extends StatelessWidget {
  final BuildContext context;

  const NetworkStatusDialog({super.key, required this.context});

  void _dismissDialogAndExitApp() {
    Navigator.of(context).pop(); // Dismiss the dialog
    SystemNavigator.pop(); // Exit the app
  }

  void _openSettings() {
    AppSettings.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Location Off"),
      content: const Text("Please check your Location Permission"),
      actions: [
        TextButton(
          onPressed: () {
            _dismissDialogAndExitApp();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            _openSettings();
            _dismissDialogAndExitApp();
          },
          child: const Text("Trun on Location",
              style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}

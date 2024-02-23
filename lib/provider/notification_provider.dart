import 'package:flutter/foundation.dart';

class NotificationProvider with ChangeNotifier {
  bool _isSwitchToggled = false;

  bool get isSwitchToggled => _isSwitchToggled;

  void toggleSwitch() {
    _isSwitchToggled = !_isSwitchToggled;
    notifyListeners();
  }
}
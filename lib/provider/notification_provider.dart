import 'package:flutter/foundation.dart';

import '../services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  bool _isSwitchToggled = false;

  bool get isSwitchToggled => _isSwitchToggled;

  void toggleSwitch() {
    _isSwitchToggled = !_isSwitchToggled;
    LocalNotificationService.getToken(isActive: _isSwitchToggled);
    notifyListeners();
  }

  void setInNotificationStatus() {
    // _isSwitchToggled =  //call and set value
  }
}

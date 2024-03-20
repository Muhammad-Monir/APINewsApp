import 'dart:convert';
import 'dart:developer';

import 'package:am_innnn/services/notification_service.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/toast_util.dart';

class NotificationProvider with ChangeNotifier {
  bool _isSwitchToggled = true;

  NotificationProvider() {
    _initializeSwitchToggled();
  }

  Future<void> _initializeSwitchToggled() async {
    final prefs = await SharedPreferences.getInstance();
    _isSwitchToggled = prefs.getBool('isSwitchToggled') ?? true;
    if (!_isSwitchToggled) {
      _isSwitchToggled = true;
      await _saveSwitchToggledToLocal();
    }
    notifyListeners();
  }

  bool get isSwitchToggled => _isSwitchToggled;

  void toggleSwitch() {
    _isSwitchToggled = !_isSwitchToggled;
    LocalNotificationService.getToken(isActive: _isSwitchToggled);
    _saveSwitchToggledToLocal();

    // Showing toast msg when user toggle
    if (_isSwitchToggled) {
      ToastUtil.showShortToast("Notifications enabled");
    } else {
      ToastUtil.showShortToast("Notifications disabled");
    }
    notifyListeners();
  }

  Future<void> _saveSwitchToggledToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSwitchToggled', _isSwitchToggled);
  }

  Future<void> setInNotificationStatus() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.firebaseTokenUrl));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final isActive = responseData['data']['is_active'] == '1';
        _isSwitchToggled = !isActive; // Toggle the value
        log(isActive.toString());
        await _saveSwitchToggledToLocal();
        notifyListeners();
      } else {
        throw 'Failed to fetch token';
      }
    } catch (error) {
      log('Error: $error');
      // Handle error
    }
  }
}

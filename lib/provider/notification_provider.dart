import 'dart:convert';
import 'dart:developer';

import 'package:am_innnn/services/notification_service.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  bool _isSwitchToggled = false;

  NotificationProvider() {
    // Initialize _isSwitchToggled from shared preferences on startup
    _initializeSwitchToggled();
  }

  Future<void> _initializeSwitchToggled() async {
    final prefs = await SharedPreferences.getInstance();
    _isSwitchToggled = prefs.getBool('isSwitchToggled') ?? false;
    notifyListeners();
  }

  bool get isSwitchToggled => _isSwitchToggled;

  void toggleSwitch() {
    _isSwitchToggled = !_isSwitchToggled;
    LocalNotificationService.getToken(isActive: _isSwitchToggled);
    // Save to shared preferences
    _saveSwitchToggledToLocal();
    // Other logic related to switch toggling
    notifyListeners();
  }

  Future<void> _saveSwitchToggledToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSwitchToggled', _isSwitchToggled);
  }

  Future<void> setInNotificationStatus() async {
    try {
      // Your API call logic
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

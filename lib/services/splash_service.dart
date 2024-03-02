import 'package:shared_preferences/shared_preferences.dart';

class SplashService{
  static late bool isFirstTime;
  static Future<void> checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
    // navigateToNextScreen();
  }
}




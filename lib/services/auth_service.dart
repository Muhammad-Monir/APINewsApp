
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {

  static Future<void> saveSessionData(String responseData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save session data (e.g., token)
    await prefs.setString('token', responseData);
    print( 'share pre token ${prefs.get('token')}');
    // You can save additional session data if needed
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the session data exists
    return prefs.containsKey('token');
  }

  static Future<void> clearSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove the token
    await prefs.remove('token');
    // You can remove additional session data if needed
  }

}

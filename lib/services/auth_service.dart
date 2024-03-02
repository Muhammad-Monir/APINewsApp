
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {

  static Future<void> saveSessionData(String responseData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save session data (e.g., token)
    await prefs.setString('token', responseData);
    print( 'share pre token ${prefs.getString('token')}');
    // You can save additional session data if needed
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the session data exists
    print( 'share pre token ${prefs.getString('token')}');
    return prefs.containsKey('token');
  }

  static Future<void> clearSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove the token
    await prefs.remove('token');
    // You can remove additional session data if needed
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve token from SharedPreferences
    return prefs.getString('token');
  }


}

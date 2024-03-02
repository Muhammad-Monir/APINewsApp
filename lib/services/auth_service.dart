
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {

  static Future<void> saveSessionData(String responseData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save session data (e.g., token)
    await prefs.setString('token', responseData);
    // You can save additional session data if needed
  }
  static Future<void> saveUserId(int userId) async {
    print('saveUserId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save session data (e.g., token)
    await prefs.setInt('id', userId);
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

  static Future<void> clearUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove the token
    await prefs.remove('id');
    // You can remove additional session data if needed
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve token from SharedPreferences
    return prefs.getString('token');
  }

  static Future<int?> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve token from SharedPreferences
    return prefs.getInt('id');
  }


}

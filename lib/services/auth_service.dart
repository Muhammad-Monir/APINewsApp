// import 'dart:developer';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthService {
//   final SharedPreferences prefs;
//   AuthService(this.prefs);
//   Future<void> saveSessionData(String responseData) async {
//     await prefs.setString('token', responseData);
//   }
//
//   bool isLoggedIn() {
//     return prefs.containsKey('token');
//   }
//
//   Future<void> clearSessionData() async {
//     // Remove the token
//     await prefs.remove('token');
//   }
//
//   String? getToken() {
//     // Retrieve token from SharedPreferences
//     return prefs.getString('token');
//   }
//
//   void saveUserId(int userId) async {
//     log('saveUserId');
//     // Save session data (e.g., token)
//     await prefs.setInt('id', userId);
//   }
//
//   Future<void> clearUserId() async {
//     // Remove the token
//     await prefs.remove('id');
//   }
//
//   int? getUserID() {
//     // Retrieve token from SharedPreferences
//     return prefs.getInt('id');
//   }
// }

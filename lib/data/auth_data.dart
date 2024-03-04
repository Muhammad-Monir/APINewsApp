import 'dart:convert';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../route/routes_name.dart';
import '../services/auth_service.dart';
import '../utils/utils.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(ApiUrl.loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        final Map<String, dynamic> data = jsonDecode(response.body);
        AuthService.saveSessionData(data["token"]);
        Utils.showSnackBar(context, data["message"]);
        _navigateToHome(context);
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      Utils.showSnackBar(context, "$error");
      rethrow;
    }
  }

  // Register User
  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    try {
      _isLoading = true;
      final response = await http.post(
        Uri.parse(ApiUrl.registerUrl),
        body: {
          'username': username,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        _isLoading = false;
        return {'success': true};
      } else if (response.statusCode == 403) {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        return {'success': false, 'errors': errorResponse['message']};
      } else {
        return {
          'success': false,
          'errors': {'unknown': 'Unknown error'}
        };
      }
    } catch (e) {
      return {
        'success': false,
        'errors': {'network': 'Network error'}
      };
    }
  }

  // User Account Verify
  Future<Map<String, dynamic>?> accountVerify({
    required String email,
    required String otp,
  }) async {
    try {
      _isLoading = true;

      final response = await http.post(
        Uri.parse(ApiUrl.accountVerifyUrl),
        body: {
          'email': email,
          'otp': otp,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('API Response: $data');

        return data;
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        print('Error Body: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Forgot Password
  Future<Map<String, dynamic>?> forgotPassword(String email) async {
    try {
      _isLoading = true;
      final response = await http.post(
        Uri.parse(ApiUrl.accountForgotUrl),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('API Response: $data');
        return data;
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        print('Error Body: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Reset Password
  Future<Map<String, dynamic>?> resetPassword({
    required String email,
    required String uniqueString,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      _isLoading = true;
      final response = await http.post(
        Uri.parse(ApiUrl.accountResetUrl),
        body: {
          'email': email,
          'unique_string': uniqueString,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('API Response: $data');
        return data;
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        print('Error Body: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  // Logout User
  Future<void> logoutUser(String authToken) async {
    final url = Uri.parse(ApiUrl.logoutUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        print('Logout successful');
      } else {
        throw Exception('Logout failed - ${response.statusCode}');
      }
    } catch (error) {
      print('Error during logout: $error');
      throw Exception('Error during logout');
    }
  }

  _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.bottomNavigationBar,
      (route) => false,
    );
  }
}

// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'dart:convert';
import 'dart:developer';

import 'package:am_innnn/data/user_data.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../route/routes_name.dart';
import '../utils/utils.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(ApiUrl.newLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      log('login : ${response.body}');
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        final Map<String, dynamic> data = jsonDecode(response.body);
        UserData.userProfile(data["token"], context).then((value) async {
          log('login user id = ${appData.read(kKeyUserID)}');
        });
        appData.write(kKeyIsLoggedIn, true);
        appData.write(kKeyToken, data["token"]);
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

  Future<void> socialLogin(String email, String username, String token,
      String provider, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(ApiUrl.newSocialLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'username': username,
          'token': token,
          'provider': provider,
          // 'secret': secret!,
        }),
      );
      log('login : ${response.body}');
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('social signin response: $data');
        UserData.userProfile(data["token"], context).then((value) async {
          log('login user id = ${appData.read(kKeyUserID)}');
        });
        appData.write(kKeyIsLoggedIn, true);
        appData.write(kKeyToken, data["token"]);
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
        Uri.parse(ApiUrl.newRegisterUrl),
        body: {
          'username': username,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
          'phone': phone,
        },
      );

      if (response.statusCode == 201) {
        _isLoading = false;
        final Map<String, dynamic> data = json.decode(response.body);
        // ToastUtil.showShortToast(data["message"]);
        // ToastUtil.showShortToast('User registered successfully.');
        return {'success': true};
      } else if (response.statusCode == 403) {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        // log(errorResponse.toString());
        // log("${errorResponse["message"]["phone"]}");
        // if (errorResponse["message"]["email"] == null) {
        //   ToastUtil.showLongToast("${errorResponse["message"]["phone"][0]}");
        // } else if (errorResponse["message"]["phone"] == null) {
        //   ToastUtil.showLongToast("${errorResponse["message"]["email"][0]}");
        // } else if (errorResponse["message"]["phone"] != null ||
        //     errorResponse["message"]["email"] != null) {
        //   ToastUtil.showLongToast(
        //       "${errorResponse["message"]["email"][0]}\n${errorResponse["message"]["phone"][0]}");
        // } else if (errorResponse["message"]["phone"] == null ||
        //     errorResponse["message"]["email"] == null) {
        //   ToastUtil.showLongToast("${errorResponse["message"]}");
        // }

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
        Uri.parse(ApiUrl.newVerifyAccountUrl),
        body: {
          'email': email,
          'otp': otp,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log('API Response: $data');

        return data;
      } else {
        log('Error ${response.statusCode}: ${response.reasonPhrase}');
        log('Error Body: ${response.body}');
        return null;
      }
    } catch (error) {
      log('Error: $error');
      return null;
    }
  }

  // Forgot Password
  Future<Map<String, dynamic>?> forgotPassword(String email) async {
    try {
      _isLoading = true;
      final response = await http.post(
        Uri.parse(ApiUrl.newForgotPasswordUrl),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log('API Response: $data');
        return data;
      } else {
        log('Error ${response.statusCode}: ${response.reasonPhrase}');
        log('Error Body: ${response.body}');
        return null;
      }
    } catch (error) {
      log('Error: $error');
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
        Uri.parse(ApiUrl.newResetPasswordUrl),
        body: {
          'email': email,
          'unique_string': uniqueString,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log('API Response: $data');
        return data;
      } else {
        log('Error ${response.statusCode}: ${response.reasonPhrase}');
        log('Error Body: ${response.body}');
        return null;
      }
    } catch (error) {
      log('Error: $error');
      return null;
    }
  }

  // Logout User
  Future<void> logoutUser(String authToken) async {
    final url = Uri.parse(ApiUrl.newLogOutUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        log('Logout successful');
      } else {
        throw Exception('Logout failed - ${response.statusCode}');
      }
    } catch (error) {
      log('Error during logout: $error');
      throw Exception('Error during logout');
    }
  }

  // Account Delete
  Future<void> profileDelete(String authToken) async {
    final url = Uri.parse(ApiUrl.newProfileDeleteUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        log('Profile Delete successful');
      } else {
        throw Exception('Account Delete failed - ${response.statusCode}');
      }
    } catch (error) {
      log('Error during Account delete: $error');
      throw Exception('Error during Account delete');
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

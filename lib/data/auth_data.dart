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


  Future<void> login(String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      // Make a POST request to your login API endpoint
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

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        _isLoading = false;
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('if${response.body}');
        if(data["status"] == "true"){
          AuthService.saveSessionData(data["token"]);
          Utils.showSnackBar(context, data["message"]);
          _navigateToHome(context);
        }
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception('Failed to login');
      }
    } catch (error) {
      // Handle errors, e.g., display an error message
      Utils.showSnackBar(context, "$error");
      throw error;
    }
  }

  _navigateToHome(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.bottomNavigationBar,
          (route) => false,
    );
}
}

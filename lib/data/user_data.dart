import 'dart:convert';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../model/bookmark_model.dart';
import '../services/auth_service.dart';

class UserData{
  // Get profile data
  static Future<ProfileModel> userProfile(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.userProfileUrl),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return ProfileModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception('code  ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception('Exception : $error');
    }
  }
  
  // Save user id
  static Future<void> getUserId(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.userProfileUrl),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['data']['id']);
        AuthService.saveUserId(data['data']['id']);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception('code  ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception('Exception : $error');
    }
  }

  // Add to bookmark
  static Future<void> addBookMark(String? authToken, String userId,String title,String? image) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.addBookMark),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'user_id': userId,
          'title': title,
          'image': image!,
        }),
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // return BookMarkModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception(response.statusCode);
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception(error);
    }
  }


  // Get All bookmark
  static Future<BookMarkModel> fetchBookMark(String? authToken, String userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrl.allBookMark}$userId'),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return BookMarkModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception(response.statusCode);
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception(error);
    }
  }
}


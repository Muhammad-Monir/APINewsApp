import 'dart:convert';
import 'dart:developer';
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
        Uri.parse(ApiUrl.newUserProfileUrl),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
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
  // static Future<void> getUserId(String authToken) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(ApiUrl.newUserProfileUrl),
  //       headers:{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $authToken'
  //       },
  //     );
  //     // Check if the request was successful (status code 200)
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       log('inside getUserId');
  //       log(data['data']['id']);
  //       AuthService.saveUserId(data['data']['id']);
  //       log(data.toString());
  //     } else  {
  //       // If the request was unsuccessful, throw an error
  //       throw Exception('code  ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle errors, display an error message
  //     throw Exception('Exception is : $error');
  //   }
  // }

  // Add to bookmark
  static Future<String> addBookMark(String? authToken, String newsId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrl.newAddBookMark}/$newsId'),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
        // body: jsonEncode(<String, dynamic>{
        //   'user_id': userId,
        //   'title': title,
        //   'image': image!,
        // }),
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log(data.toString());
        return data["message"];
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
  static Future<BookmarkModel> fetchBookMark(String? authToken) async {
    try {
      log('fetchBookMark: $authToken');
      final response = await http.get(
        Uri.parse(ApiUrl.newAllBookMark),
        headers:{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      log(response.statusCode.toString());
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log(data.toString());
        return BookmarkModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception(response.statusCode);
      }
    } catch (error) {
      // Handle errors, display an error message
      throw Exception(error);
    }
  }

  static Stream<BookmarkModel> fetchBookMarkStream(String? authToken) async* {
    try {
      log('fetchBookMark: $authToken');
      final response = await http.get(
        Uri.parse(ApiUrl.newAllBookMark),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log(data.toString());
        yield BookmarkModel.fromJson(data);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
      throw Exception(error);
    }
  }


}


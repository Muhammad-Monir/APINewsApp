import 'dart:convert';
import 'dart:developer';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/services/auth_service.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/bookmark_model.dart';
import 'dart:io';

class UserData {
  // Get profile data
  static Future<ProfileModel> userProfile(
      String authToken, BuildContext context) async {
    try {
      final sharedInstance = Provider.of<AuthService>(context, listen: false);
      final response = await http.get(
        Uri.parse(ApiUrl.newUserProfileUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // log('id is : ${data["data"]["id"]}');
        sharedInstance.saveUserId(data["data"]["id"]);
        // int? id = await AuthService.getUserID();
        // log('user id is : $id');
        return ProfileModel.fromJson(data);
      } else {
        throw Exception('code  ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Exception : $error');
    }
  }

  // Add to bookmark
  static Future<String> addBookMark(String? authToken, String newsId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrl.newAddBookMark}/$newsId'),
        headers: {
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
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  // Get All bookmark
  static Future<BookmarkModel> fetchBookMark(String? authToken) async {
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
        return BookmarkModel.fromJson(data);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
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

  // Update User Information
  Future<Map<String, dynamic>?> updateProfile({
    required String userName,
    required String image,
    String? authToken,
  }) async {
    try {
      final http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.newUserUpdateUrl),
      );

      if (image.isNotEmpty) {
        final File imageFile = File(image);
        final http.MultipartFile imageMultipartFile =
            await http.MultipartFile.fromPath('avatar', imageFile.path);
        request.files.add(imageMultipartFile);
      }

      request.fields['username'] = userName;

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = 'Bearer $authToken';

      final http.Response response = await http.Response.fromStream(
        await request.send(),
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
}

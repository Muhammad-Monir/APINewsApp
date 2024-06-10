import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/toast_util.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/bookmark_model.dart';
import '../utils/di.dart';

class UserData {
  // Get profile data
  static Future<ProfileModel> userProfile(
      String authToken, BuildContext context) async {
    try {
      // final sharedInstance = Provider.of<AuthService>(context, listen: false);
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
        // Save User Id Localy
        appData.write(kKeyUserID, data["data"]["id"]);

        // Check if language and country data are not null before accessing them
        final language = data["data"]["language"];
        final country = data["data"]["country"];

        if (language != null) {
          appData.write(kKeyLanguageId, language["id"]);
        } else {
          appData.write(kKeyLanguageId, 22);
        }

        if (country != null) {
          appData.write(kKeyCountryCode, country["code"]);
        } else {
          appData.write(kKeyCountryCode, 'in');
        }

        // appData.write(kKeyLanguageId, data["data"]["language"]["id"]);
        // appData.write(kKeyCountryCode, data["data"]["country"]["code"]);

        // save the categories
        List<int> categories = List<int>.from(data["data"]["categories"]);
        appData.write(kKeyCategory, categories);

        log('*********save the ln cn ca is calling');
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
    String? userName,
    String? image,
    String? authToken,
  }) async {
    try {
      final http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.newUserUpdateUrl),
      );

      if (image != null && image.isNotEmpty) {
        final File imageFile = File(image);
        final http.MultipartFile imageMultipartFile =
            await http.MultipartFile.fromPath('avatar', imageFile.path);
        request.files.add(imageMultipartFile);
      }

      request.fields['username'] = userName!;

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

  // Update Categories
  static Future<String> addCategory(List<int> categoryList) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.addCategoryUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appData.read(kKeyToken)}'
        },
        body: jsonEncode(<String, dynamic>{
          'categories': categoryList,
        }),
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log(data.toString());
        ToastUtil.showShortToast(data["message"]);
        return data["message"];
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  // Update Categories
  static Future<String> addCountryLanguage(
      int countryId, int languageId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.addCountryLanguage),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appData.read(kKeyToken)}'
        },
        body: jsonEncode(<String, dynamic>{
          'country_id': countryId,
          'language_id': languageId,
        }),
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log(data.toString());
        ToastUtil.showShortToast(data["message"]);
        return data["message"];
      } else {
        throw Exception(response.statusCode);
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}

import 'dart:convert';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';
import '../model/user_profile_model.dart';

class NewsData {
  static Future<NewsModel> fetchAllNews({String? category}) async {
    try {
      final response = await http.get(category == null
          ? Uri.parse(ApiUrl.allNewsUrl)
          : Uri.parse('${ApiUrl.allNewsUrl}&category=$category'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        // print(jsonDecode(response.body));
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }



  static Future<NewsModel> searchNews({String? searchText}) async {
    try {
      final response = await http.get(searchText == null
          ? Uri.parse(ApiUrl.allNewsUrl)
          : Uri.parse('${ApiUrl.searchUrl}&q=$searchText'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print(jsonDecode(response.body));
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<ProfileModel> userProfile(String authToken, BuildContext context) async {
    try {
      // Make a POST request to your login API endpoint
      final response = await http.get(
        Uri.parse(ApiUrl.profileUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        // Utils.showSnackBar(context, data["message"]);
        return ProfileModel.fromJson(data);
      } else  {
        // If the request was unsuccessful, throw an error
        throw Exception('Failed to login');
      }
    } catch (error) {
      // Handle errors, e.g., display an error message
      rethrow;
    }
  }

}

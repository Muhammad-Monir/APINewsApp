import 'dart:convert';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/bookmark_model.dart';
import '../model/news_model.dart';
import '../model/user_profile_model.dart';

class NewsData {
  static Future<NewsModel> fetchAllNews({String? category}) async {
    try {
      final response = await http.get(category == null
          ? Uri.parse(ApiUrl.newsEndPoint)
          : Uri.parse('${ApiUrl.newsEndPoint}&category=$category'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        // print(jsonDecode(response.body));
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        return NewsModel.fromJson(data);
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
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  static Future<StoryModel> fetchStory() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.storyUrl),
        headers:{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return StoryModel.fromJson(data);
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }



}

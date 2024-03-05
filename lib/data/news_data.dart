import 'dart:convert';
import 'dart:developer';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsData {
  static Future<NewsModel> fetchAllNews({String? category}) async {
    try {
      final response = await http.get(category == null
          ? Uri.parse(ApiUrl.newsEndPoint)
          : Uri.parse('${ApiUrl.newsEndPoint}?category=$category'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);
        return NewsModel.fromJson(data);
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<NewsModel> searchText({String? searchTitle}) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiUrl.newsEndPoint}?title=$searchTitle'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);
        return NewsModel.fromJson(data);
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
  static Future<NewsModel> filter({String? searchTitle, String? category}) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiUrl.newsEndPoint}?category=$category&title=$searchTitle'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);
        return NewsModel.fromJson(data);
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<StoryModel> fetchStory() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.storyUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return StoryModel.fromJson(data);
      } else {
        throw Exception('Failed to load Story: ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }
}

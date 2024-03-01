import 'dart:convert';
import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsData {
  static Future<NewsModel> fetchAllNews() async {
    try{
      final response = await http.get(Uri.parse(ApiUrl.allNewsUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print(jsonDecode(response.body));
        return NewsModel.fromJson(jsonDecode(response.body));

      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }

}
import 'dart:convert';
import 'package:am_innnn/model/category_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;

class NewsData {
  static Future<CategoryModel> fetchAllNewsCategory() async {
    try{
      final response = await http.get(Uri.parse(ApiUrl.allNewsCategoryUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print(jsonDecode(response.body));
        return CategoryModel.fromJson(jsonDecode(response.body));

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
import 'dart:convert';
import 'dart:developer';
import 'package:am_innnn/model/category_model.dart';
import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../model/country_model.dart';
import '../model/language_model.dart';
import '../model/news_model.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';
import '../utils/toast_util.dart';

class NewsData {
  static bool isLastPage = false;
  static Future<NewsModel> fetchAllNews(
      {String? category, int page = 1}) async {
    log('Contry ${appData.read(kKeyCountryCode)}');
    log(' laguage ${appData.read(kKeyLanguageId)}');
    log(' Category ${appData.read(kKeyCategory)}');
    try {
      final response = await http.get(category == null
          ? Uri.parse(
              '${ApiUrl.allNewsUrl}?language=${appData.read(kKeyLanguageId).toString()}&country=${appData.read(kKeyCountryCode)}&page=$page')
          : Uri.parse(
              '${ApiUrl.allNewsUrl}?language=${appData.read(kKeyLanguageId).toString()}&country=${appData.read(kKeyCountryCode)}&category=$category&page=$page'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // log(data.toString());
        return NewsModel.fromJson(data);
      } else if (response.statusCode == 404) {
        ToastUtil.showShortToast('We Are Coming Soon Be Patient ');
        throw Exception('Failed to load news');
      } else {
        // If the server did not return a 200 OK response, throw an exception
        throw Exception('Failed to load news');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<NewsModel> searchText(
      {String? category, String? searchTitle}) async {
    try {
      final response = await http.get(category == null
          ? Uri.parse(
              '${ApiUrl.allNewsUrl}?language=${appData.read(kKeyLanguageId).toString()}&country=${appData.read(kKeyCountryCode)}&title=$searchTitle')
          : Uri.parse(
              '${ApiUrl.allNewsUrl}?language=${appData.read(kKeyLanguageId).toString()}&country=${appData.read(kKeyCountryCode)}&category=$category&title=$searchTitle'));
      // final response =
      //     await http.get(Uri.parse('${ApiUrl.allNewsUrl}?title=$searchTitle'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);
        // log('search data si s: ${data.toString()}');
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

  static Future<NewsModel> filter(
      {String? searchTitle, String? category}) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiUrl.allNewsUrl}?category=$category&title=$searchTitle'));
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

  // static Future<List<Data>> fetchStory(int page) async {
  //   if (!isLastPage) {
  //     try {
  //       log('call get story');
  //       final response = await http.get(
  //         Uri.parse('${ApiUrl.newStoryUrl}?page=$page'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //       );
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> data = jsonDecode(response.body);
  //         log(data['storyboard']['next_page_url'].toString());
  //         isLastPage =
  //             data['storyboard']['next_page_url'] == null ? true : false;
  //         log(data.toString());
  //         // Extract 'data' field and convert it to a list of Data objects
  //         final List<dynamic> jsonDataList = data['storyboard']['data'];
  //         final List<Data> dataList =
  //             jsonDataList.map((json) => Data.fromJson(json)).toList();
  //         log('dataList  : ${dataList.toString()}');
  //         return dataList;
  //       } else {
  //         throw Exception('Failed to load Story: ${response.statusCode}');
  //       }
  //     } catch (error) {
  //       rethrow;
  //     }
  //   } else {
  //     throw Exception('Failed to load Story: ${4545}');
  //   }
  // }

  static Future<StoryModel> fetchStory(int page) async {
    try {
      // log('call get story');
      final response = await http.get(
        Uri.parse('${ApiUrl.newStoryUrl}?page=$page'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // log(data.toString());
        return StoryModel.fromJson(data);
      } else {
        throw Exception('Failed to load Story: ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<CategoryModel> fetchCategory() async {
    try {
      // log('call get category');
      final response = await http.get(
        Uri.parse(ApiUrl.newCategoryUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // log(data.toString());
        return CategoryModel.fromJson(data);
      } else {
        // log(response.statusCode.toString());
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (error) {
      // log(error.toString());
      rethrow;
    }
  }

  static Future<LanguageModel> getAllLanguage() async {
    try {
      // log('call get category');
      final response = await http.get(
        Uri.parse(ApiUrl.newLanguageUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // log(data.toString());
        return LanguageModel.fromJson(data);
      } else {
        // log(response.statusCode.toString());
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  static Future<CountryModel> getAllCountry() async {
    try {
      // log('call get category');
      final response = await http.get(
        Uri.parse(ApiUrl.newCountryUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // log(data.toString());
        return CountryModel.fromJson(data);
      } else {
        // log(response.statusCode.toString());
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}

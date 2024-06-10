import 'dart:convert';
import 'dart:developer';
import 'package:am_innnn/model/news_model.dart';
import '../services/base_stream_service.dart';
import 'package:http/http.dart' as http;
import '../utils/api_url.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';

class NewsDataStream extends MyStreamBase<NewsModel> {
  NewsDataStream() : super(empty: NewsModel());
  Future<NewsModel> fetchNewsStream(
      {String? category, String? authToken, int page = 1}) async {
    NewsModel? newsModel;
    log('on stream category: $category');
    try {
      final response = await http.get(
        category == null
            ? Uri.parse(
                '${ApiUrl.allNewsUrl}?language=${appData.read(kKeyLanguageId).toString()}&country=${appData.read(kKeyCountryCode)}&page=$page')
            : Uri.parse(
                '${ApiUrl.allNewsUrl}?language=${appData.read(kKeyLanguageId).toString()}&country=${appData.read(kKeyCountryCode)}&category=$category&page=$page'),
        // ? Uri.parse(ApiUrl.allNewsUrl)
        // : Uri.parse('${ApiUrl.allNewsUrl}?category=$category'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // log("Check bookmark News :$data");
        newsModel = NewsModel.fromJson(data);
      }
      return handleSuccessWithReturn(newsModel!);
    } catch (error) {
      log(error.toString());
      return handleErrorWithReturn(error);
    }
  }
}

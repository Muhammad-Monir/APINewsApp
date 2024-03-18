import 'dart:convert';
import 'dart:developer';
import 'package:am_innnn/model/news_model.dart';
import '../services/base_stream_service.dart';
import 'package:http/http.dart' as http;
import '../utils/api_url.dart';

class SearchDataStream extends MyStreamBase<NewsModel> {
  SearchDataStream() : super(empty: NewsModel());
  Future<NewsModel> fetchSearchStream(String? searchTitle) async {
    NewsModel? searchModel;
    try {
      final response =
          await http.get(Uri.parse('${ApiUrl.allNewsUrl}?title=$searchTitle'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log('search data iss : ${data.toString()}');
        searchModel = NewsModel.fromJson(data);
      }
      return handleSuccessWithReturn(searchModel!);
    } catch (error) {
      log(error.toString());
      return handleErrorWithReturn(error);
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:am_innnn/model/checkbookmark_model.dart';
import '../services/base_stream_service.dart';
import 'package:http/http.dart' as http;
import '../utils/api_url.dart';

class CheckBookmarkStream extends MyStreamBase<CheckBookmarkModel> {
  CheckBookmarkStream() : super(empty: CheckBookmarkModel());

  Future<CheckBookmarkModel> checkBookmark(
      String userId, String newsId, String token) async {
    CheckBookmarkModel? model;
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.newCheckBookMark),
        // ? Uri.parse(ApiUrl.allNewsUrl)
        // : Uri.parse('${ApiUrl.allNewsUrl}?category=$category'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'user_id': userId,
          'news_id': newsId,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // log("Check bookmark News :$data");
        model = CheckBookmarkModel.fromJson(data);
      }
      return handleSuccessWithReturn(model!);
    } catch (error) {
      log(error.toString());
      return handleErrorWithReturn(error);
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import '../model/bookmark_model.dart';
import '../services/base_stream_service.dart';
import 'package:http/http.dart' as http;
import '../utils/api_url.dart';

class BookMarkDataStream extends MyStreamBase<BookmarkModel> {
  BookMarkDataStream() : super(empty: BookmarkModel());
  Future<BookmarkModel> fetchBookMarkStream(String? authToken) async {
    BookmarkModel? bookmarkModel;

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.newAllBookMark),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      log('response code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log("book mark Data is ${data.toString()}");
        bookmarkModel = BookmarkModel.fromJson(data);
      }
      return handleSuccessWithReturn(bookmarkModel!);
    } catch (error) {
      log(error.toString());
      return handleErrorWithReturn(error);
    }
  }
}

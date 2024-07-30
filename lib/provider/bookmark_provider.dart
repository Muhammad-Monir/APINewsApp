// ignore_for_file: unused_local_variable, prefer_final_fields, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, unused_field
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/news_stream_data.dart';
import '../data/user_data.dart';
import '../model/news_model.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';
import '../utils/toast_util.dart';

class BookmarkProvider with ChangeNotifier {
  final _authToken = appData.read(kKeyToken);
  NewsDataStream newsDataStream = NewsDataStream();
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  List<Datum> _newes = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<Datum> get newes => _newes;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  void toggleBookmark(String authToken, int newsId) async {
    final value = await UserData.addBookMark(authToken, newsId.toString());
    if (value == 'Bookmark added successfully') {
      _isFavorite = true;
      ToastUtil.showShortToast(value);
    } else if (value == 'Bookmark Remove successfully') {
      _isFavorite = false;
      ToastUtil.showShortToast(value);
    }
    notifyListeners(); // Ensure the state is updated immediately
  }

  // void toggleIsFavorite() {
  //   _isFavorite = !_isFavorite;
  //   notifyListeners();
  // }

  // void setFavoriteValue(bool bookmarkValue) {
  //   _isFavorite = bookmarkValue;
  //   // notifyListeners();
  // }
}

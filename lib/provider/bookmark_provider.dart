// ignore_for_file: unused_local_variable, prefer_final_fields, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:developer';

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

  Future<void> fetchNews() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response;
      if (appData.read(kKeyCategory) == null ||
          appData.read(kKeyCategory).isEmpty ||
          appData.read(kKeyCategory) == []) {
        log('if bookmark');
        // Fetch All News
        log("token" + _authToken);
        response = await newsDataStream.fetchNewsStream(
            authToken: _authToken, page: _page);
      } else {
        log('else bookmark');
        log("token" + _authToken);
        String categoriesString = appData.read(kKeyCategory).join(',');
        // Fetch News filter by Category
        response = await newsDataStream.fetchNewsStream(
            authToken: _authToken, page: _page);
      }
      // if (response.data!.nextPageUrl != null) {
      //   ToastUtil.showShortToast('We Are Coming Soon Be Paction');
      // }

      if (response.data?.data != null) {
        _newes.addAll(response.data!.data!);
        _hasMore = response.data!.data!.isNotEmpty;

        // if (_hasMore == false) {
        //   // ToastUtil.showShortToast('We Are Coming Soon Be Paction');
        // }
        log('bookmark data is : ${_newes.first.isBookmarked}');
        log('bookmark title is : ${_newes.first.title}');
        _page++;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearList() {
    _newes.clear();
    _page = 1;
    notifyListeners();
  }

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

  void setFavoriteValue(bool bookmarkValue) {
    _isFavorite = bookmarkValue;
    // notifyListeners();
  }
}

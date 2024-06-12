// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'dart:developer';
import 'package:am_innnn/model/news_model.dart';
import 'package:flutter/material.dart';
import '../data/news_data.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';
import '../utils/toast_util.dart';

class NewsProvider extends ChangeNotifier {
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
        log('----------if');
        response = await NewsData.fetchAllNews(page: _page);
      } else {
        log('----------else');
        String categoriesString = appData.read(kKeyCategory).join(',');
        log('---------- categoriesString: $categoriesString');
        response = await NewsData.fetchAllNews(
            category: categoriesString, page: _page);
      }
      // if (response.data!.nextPageUrl == null) {
      //   ToastUtil.showShortToast('We Are Coming Soon Be Paction');
      // }

      if (response.data?.data != null) {
        // if (response.data!.nextPageUrl != null)
        _newes.addAll(response.data!.data!);
        _hasMore = response.data!.data!.isNotEmpty;
        _page++;
        if (response.status == false) {
          ToastUtil.showShortToast('We Are Coming Soon Be Patient ');
        }
      } else {
        ToastUtil.showShortToast('We Are Coming Soon Be Patient ');
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
}

// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'dart:developer';
import 'package:am_innnn/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data/news_data.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';
import '../utils/toast_util.dart';

class NewsProvider extends ChangeNotifier {
  List<Datum> _newes = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _massage = 'We Are Coming Soon Be Patient';

  List<Datum> get newes => _newes;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String get massage => _massage;

  Future<void> fetchNews() async {
    if (_isLoading) return;

    // Check internet connection
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      ToastUtil.showShortToast('No internet connection');
      _massage =
          'Looks like you are offline.\nPlease switch on your data or WIFI and try again.';
      return;
    } else {
      _massage = 'We Are Coming Soon Be Patient';
    }

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
        log('----------news provider call');
        String categoriesString = appData.read(kKeyCategory).join(',');
        response = await NewsData.fetchAllNews(
            category: categoriesString, page: _page);
      }

      if (response.data?.data != null) {
        _newes.addAll(response.data!.data!);
        _hasMore = response.data!.data!.isNotEmpty;
        _page++;
        if (response.status == false) {
          log('----------news provider call');
          ToastUtil.showShortToast('Hope World is doing good \u{1F600}');
        }
      } else {
        // ToastUtil.showShortToast('Guess World is doing good \u{1F600}');
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

// ignore_for_file: prefer_final_fields
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data/news_data.dart';
import '../model/story_model.dart';
import '../utils/toast_util.dart'; // Update with the actual path

class StoryProvider with ChangeNotifier {
  List<StoryData> _stories = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _massage = 'We Are Coming Soon Be Patient';

  String get massage => _massage;
  List<StoryData> get stories => _stories;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchStories() async {
    if (_isLoading) return;

    // Check internet connection
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      ToastUtil.showShortToast('No internet connection');
      _massage =
          'Looks like your are offline.\nPlease switch on your data or WIFI and try again.';
      return;
    } else {
      _massage = 'We Are Coming Soon Be Patient';
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await NewsData.fetchStory(_page);

      if (response.storyboard?.data != null) {
        _stories.addAll(response.storyboard!.data!);
        _hasMore = response.storyboard!.data!.isNotEmpty;
        _page++;
        if (response.status == false) {
          ToastUtil.showShortToast('We Are Coming Soon Be Patient ');
        }
        // if (response.storyboard!.nextPageUrl == null) {
        // if (!hasMore) {
        //   ToastUtil.showShortToast('We Are Coming Soon Be Paction');
        // }
      } else {
        _hasMore = false;
        ToastUtil.showShortToast('We Are Coming Soon Be Patient ');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearList() {
    _stories.clear();
    _page = 1;
    notifyListeners();
  }
}

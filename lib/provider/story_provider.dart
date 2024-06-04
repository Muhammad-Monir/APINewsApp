// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/news_data.dart';
import '../model/story_model.dart';
import '../utils/toast_util.dart'; // Update with the actual path

class StoryProvider with ChangeNotifier {
  List<StoryData> _stories = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<StoryData> get stories => _stories;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchStories() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await NewsData.fetchStory(_page);

      if (response.storyboard?.data != null) {
        if (response.storyboard!.nextPageUrl == null) {
          return ToastUtil.showShortToast('We Are Coming Soon Be Paction');
        }
        _stories.addAll(response.storyboard!.data!);
        _hasMore = response.storyboard!.data!.isNotEmpty;
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
}

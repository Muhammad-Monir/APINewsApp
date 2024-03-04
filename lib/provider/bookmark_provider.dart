import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  bool _isFavorite = true;

  bool get isFavorite => _isFavorite;

  void toggleIsFavorite(){
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
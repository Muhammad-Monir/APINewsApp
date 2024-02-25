import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  bool isFavorite = false;

  void toggleBookMarkColor(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
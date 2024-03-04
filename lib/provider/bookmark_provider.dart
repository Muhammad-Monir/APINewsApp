import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  bool isFavorite = true;


  void toggleIsFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
import 'package:flutter/foundation.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 1.0;

  double get fontSize => _fontSize;

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }
}
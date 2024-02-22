import 'package:flutter/foundation.dart';

class BarsVisibility with ChangeNotifier {
  bool _showBars = false;

  bool get showBars => _showBars;

  void toggleBars() {
    _showBars = !_showBars;
    notifyListeners();
  }

  void hideBars() {
    _showBars = false;
    notifyListeners();
  }
}
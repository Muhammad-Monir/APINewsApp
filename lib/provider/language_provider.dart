import 'package:flutter/material.dart';
import '../data/news_data.dart';
import '../model/language_model.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';

class LanguageProvider with ChangeNotifier {
  List<LanguageData>? _languages;
  LanguageData? _selectedLanguage;
  bool _isLoading = true;
  String? _errorMessage;

  List<LanguageData>? get languages => _languages;
  LanguageData? get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LanguageProvider() {
    fetchLanguages();
    initializeSelectedLanguage();
  }

  Future<void> fetchLanguages() async {
    try {
      final languageModel = await NewsData.getAllLanguage();
      _languages = languageModel.data;
      _isLoading = false;
      initializeSelectedLanguage(); // Ensure that selected language is set after fetching languages
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  void setSelectedLanguage(LanguageData? language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void resetLanguage() {
    _selectedLanguage = null;
    notifyListeners();
  }

  void initializeSelectedLanguage() {
    int? languageId = appData.read(kKeyLanguageId);
    if (languageId != null && _languages != null) {
      _selectedLanguage =
          _languages!.firstWhere((language) => language.id == languageId);
    }
    notifyListeners();
  }
}

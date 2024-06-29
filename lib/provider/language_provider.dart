import 'dart:developer';

import 'package:flutter/material.dart';
import '../data/news_data.dart';
import '../model/language_model.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';

class LanguageProvider with ChangeNotifier {
  List<LanguageData>? _languages;
  LanguageData? _selectedLanguage;
  bool _isLoading = false;
  String? _errorMessage;

  List<LanguageData>? get languages => _languages;
  LanguageData? get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LanguageProvider() {
    // fetchLanguages();
    initializeSelectedLanguage();
  }

  Future<void> fetchLanguages({String? code}) async {
    try {
      _isLoading = true;
      log('county code kKeyCountryId : ${appData.read(kKeyCountryCode)}');
      log('county code kKeyCountryId : $code');
      final languageModel = await NewsData.getAllLanguageByCountry(
          code ?? appData.read(kKeyCountryCode));
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
    try {
      log("languageId: $languageId, _languages: ${_languages.toString()}");
      if (languageId != null && _languages != null) {
        _selectedLanguage = _languages!.firstWhere(
          (language) => language.id == languageId,
          // orElse: () => _languages!
          //     .firstWhere((language) => languageId == _languages!.first.id!),
          orElse: () => _languages!.first,
        );
      } else if (_languages != null) {
        log(" else if languageId: $languageId, _languages: ${_languages.toString()}");
        // _selectedLanguage = _languages!
        //     .firstWhere((language) => language.id == _languages!.first.id!);
        _selectedLanguage = _languages!.first;
      }
      log("_selectedLanguage: ${_selectedLanguage.toString()}, ");
    } catch (e) {
      log('language initialize exception: $e ');
      rethrow;
    }
    notifyListeners();
  }

  // void initializeSelectedLanguage() {
  //   int? languageId = appData.read(kKeyLanguageId);
  //   try {
  //     log("languageId: $languageId, _languages: ${_languages.toString()}");
  //     if (languageId != null && _languages != null) {
  //       _selectedLanguage =
  //           _languages!.firstWhere((language) => language.id == languageId);
  //       log("_selectedLanguage: ${_selectedLanguage.toString()}, ");
  //     }
  //   } catch (e) {
  //     log('language initialize exception: $e ');
  //     rethrow;
  //   }
  //   notifyListeners();
  // }
}

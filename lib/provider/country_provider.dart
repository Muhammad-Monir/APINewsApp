import 'dart:developer';

import 'package:am_innnn/model/country_model.dart';
import 'package:flutter/material.dart';

import '../data/news_data.dart';
import '../utils/app_constants.dart';
import '../utils/di.dart';

class CountryProvider with ChangeNotifier {
  List<CountryData>? _countries;
  CountryData? _selectedCountry;
  bool _isLoading = true;
  String? _errorMessage;

  List<CountryData>? get countries => _countries;
  CountryData? get selectedCountry => _selectedCountry;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  CountryProvider() {
    fetchCountries();
    initializeSelectedCountry();
  }

  Future<void> fetchCountries() async {
    try {
      final countryModel = await NewsData.getAllCountry();
      _countries = countryModel.data;
      _isLoading = false;
      initializeSelectedCountry(); // Ensure that selected country is set after fetching countries
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  void setSelectedCountry(CountryData? country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void resetCountry() {
    _selectedCountry = null;
    notifyListeners();
  }

  void initializeSelectedCountry() {
    String? countryCode = appData.read(kKeyCountryCode);
    log('initial country code: $countryCode');
    if (countryCode != null && _countries != null) {
      _selectedCountry = _countries!.firstWhere(
        (country) => country.code == countryCode,
        // orElse: () {
        //   // Provider
        // },
      );
    }
    notifyListeners();
  }
}

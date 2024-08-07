// ignore_for_file: unnecessary_null_comparison, unused_field, unused_element, prefer_final_fields, use_build_context_synchronously

import 'dart:developer';
import 'package:am_innnn/provider/language_provider.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../route/routes_name.dart';
import '../../services/locations_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Position _currentPosition;
  String _country = '';
  String _countryCode = '';
  double latitude = 0.0, longitude = 0.0;

  @override
  void initState() {
    // _detectLocation();
    Future.delayed(
      const Duration(microseconds: 100),
      () {
        if (appData.read(kKeyIsFirstTime)) {
          _detectLocation();
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.home,
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

  setNewLocation(double let, double lng) {
    longitude = lng;
    latitude = let;
  }

  void _detectLocation() async {
    try {
      final position = await determinePosition();
      setNewLocation(position.latitude, position.longitude);

      List<Placemark> countryName =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (countryName != null && countryName.isNotEmpty) {
        _country = countryName[0].country!;
        _countryCode = countryName[0].isoCountryCode!;
        appData.write(kKeyCountryCode, _countryCode.toLowerCase());
        appData.write(kKeyLanguageId, 22);
        Provider.of<LanguageProvider>(context, listen: false)
            .fetchLanguages(code: _countryCode.toLowerCase());

        appData.write(kKeyIsFirstTime, false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.home,
          (route) => false,
        );
        log(_country);
        // log("Country code by get geo locaiton${countryName[0].isoCountryCode!}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Utils.scrHeight * .1,
              width: Utils.scrHeight * .1,
              child: Image.asset('assets/images/logo.png'),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: unnecessary_null_comparison, unused_field, unused_element, prefer_final_fields

import 'dart:developer';

import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
    _detectLocation();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        // if (appData.read(kKeyIsFirstTime)) {
        //   Navigator.pushNamedAndRemoveUntil(
        //     context,
        //     RoutesName.onBoarding,
        //     (route) => false,
        //   );
        // } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.home,
          (route) => false,
        );
        // }
      },
    );
    super.initState();
  }

  setNewLocation(double let, double lng) {
    longitude = lng;
    latitude = let;
    log(longitude.toString());
    log(latitude.toString());
    log(_country);
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
        appData.writeIfNull(kKeyCountryCode, _countryCode.toLowerCase());
        log(_country);
        log("Country code by get geo locaiton${countryName[0].isoCountryCode!}");
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

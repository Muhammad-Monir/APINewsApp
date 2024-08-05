// ignore_for_file: unnecessary_null_comparison, unused_field, unused_element, prefer_final_fields, use_build_context_synchronously

import 'dart:developer';
import 'package:am_innnn/provider/language_provider.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:am_innnn/view/splash/widgets/network_status_dialog.dart';
import 'package:flutter/cupertino.dart';
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
          // _detectLocation();
          _checkLocationService();
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

  void _checkLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showNoInternetDialog();
      return;
    }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // Permissions are denied, show a message.
    //     _showLocationDeniedMessage();
    //     return;
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, show a message.
    //   _showLocationDeniedMessage();
    //   return;
    // }

    // When we reach here, permissions are granted, and we can
    // continue accessing the position of the device.
    _detectLocation();
  }

  void showNoInternetDialog() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => NetworkStatusDialog(context: context),
    );
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Service Disabled'),
          content: const Text('Please enable location services.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLocationDeniedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location permissions are denied.'),
      ),
    );
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

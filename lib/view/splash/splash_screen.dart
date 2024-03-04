import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../route/routes_name.dart';
import '../../services/locations_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late Position _currentPosition;
  // String _country = '';
  // double latitude=0.0,longitude=0.0;

  @override
  void initState() {
    // _detectLocation();

    Future.delayed(
      const Duration(seconds: 1),
          () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.home,
                  (route) => false,
            );
      },
    );
    super.initState();
  }


  // setNewLocation(double let,double lng){
  //   longitude=lng;
  //   latitude=let;
  //   print(longitude);
  //   print(latitude);
  //   print(_country);
  // }

  // void _detectLocation() async {
  //   try{
  //     final position = await determinePosition();
  //     setNewLocation(position.latitude, position.longitude);
  //
  //     List<Placemark> countryName = await placemarkFromCoordinates(
  //         position.latitude, position.longitude);
  //     if (countryName != null && countryName.isNotEmpty) {
  //       _country = countryName[0].country!;
  //       print(_country);
  //     }
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Container()
          ],
        ),
      ),
    );
  }
}
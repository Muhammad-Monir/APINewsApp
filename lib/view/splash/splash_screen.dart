import 'package:flutter/material.dart';
import '../../route/routes_name.dart';
import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacementNamed(context, RoutesName.home);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Utils.showPngImage('logo',
                height: Utils.scrHeight * .07, width: Utils.scrHeight * .25)
          ],
        ),
      ),
    );
  }
}
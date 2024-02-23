import 'package:am_innn/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomWelcomeScreen extends StatelessWidget {
  const CustomWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .04, vertical: Utils.scrHeight * .04),
      color: Colors.white,
      child: Column(
        children: [
          Utils.showSvgPicture(
            'welcome',
            height: Utils.scrHeight * .284,
            width: Utils.scrHeight * .284,
          ),
        ],
      ),
    );
  }
}

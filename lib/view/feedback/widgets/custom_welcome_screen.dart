
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../route/routes_name.dart';

class CustomWelcomeScreen extends StatelessWidget {
  const CustomWelcomeScreen(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .6,
      width: Utils.scrHeight * .342,
      padding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .04, vertical: Utils.scrHeight * .02),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .02)),
      child: Column(
        children: [
          Utils.showSvgPicture('welcome',
              height: Utils.scrHeight * .284, width: Utils.scrHeight * .284),
          SizedBox(height: Utils.scrHeight * .024),
          Text(title,
              style: semiBoldTS(const Color(0xff4E617E), fontSize: 36)),
          SizedBox(height: Utils.scrHeight * .016),
          Text(
              description,
              textAlign: TextAlign.center,
              style: regularTS(homeTabTextColor, fontSize: 16)),
          SizedBox(height: Utils.scrHeight * .028),
          GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.home,
                  (route) => false,
                );
              },
              child: Center(
                  child: Text('Back to Home',
                      style: semiBoldTS(appThemeColor,
                          fontSize: 16, isUnderline: true)))),
        ],
      ),
    );
  }
}

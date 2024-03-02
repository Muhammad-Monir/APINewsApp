import 'package:flutter/material.dart';

import '../../../route/routes_name.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class ResetPopup extends StatelessWidget {
  const ResetPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .3,
      width: Utils.scrHeight * .342,
      padding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .04, vertical: Utils.scrHeight * .02),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .02)),
      child: Column(
        children: [
          Text('Congrats!',
              style: semiBoldTS(const Color(0xff4E617E), fontSize: 36)),
          SizedBox(height: Utils.scrHeight * .016),
          Text(
              'You have successfully changed your password. Please use the new password when logging in.',
              textAlign: TextAlign.center,
              style: regularTS(homeTabTextColor, fontSize: 16)),
          SizedBox(height: Utils.scrHeight * .028),
          GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.login,
                      (route) => false,
                );
              },
              child: Center(
                  child: Text('Back To Login',
                      style: semiBoldTS(appThemeColor,
                          fontSize: 16, isUnderline: true)))),
        ],
      ),
    );
  }
}

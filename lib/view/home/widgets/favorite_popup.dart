
import 'package:flutter/material.dart';

import '../../../common_widgets/action_button.dart';
import '../../../route/routes_name.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class FavoritePopup extends StatelessWidget {
  const FavoritePopup({super.key, this.onExit});

  final VoidCallback? onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .32,
      width: Utils.scrHeight * .542,
      padding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .024, vertical: Utils.scrHeight * .028),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Header Part
          Row(children: [
            Text('Welcome!', style: mediumTS(tabBarDividerColor, fontSize: 24)),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  if (onExit == null) return;
                  onExit!();
                },
                child:
                const Icon(Icons.close, size: 40, color: Color(0xff9DACC3)))
          ]),
          SizedBox(height: Utils.scrHeight * .02),
          Text('Please Login to continue.',
              style: mediumTS(tabBarDividerColor, fontSize: 18)),
          SizedBox(height: Utils.scrHeight * .04),

          // Login Part
          Center(
            child: ActionButton(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              width: Utils.scrHeight * .2,
              buttonColor: appThemeColor,
              buttonName: 'Log In',
            ),
          ),
          SizedBox(height: Utils.scrHeight * .02),

          // Register Part
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account?  ",
                style: mediumTS(loginWelcomeColor),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.register);
                },
                child: Text(
                  "Register",
                  style: mediumTS(const Color(0xff2E8540), isUnderline: true),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
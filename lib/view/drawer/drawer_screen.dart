<<<<<<< HEAD

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

=======
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
>>>>>>> 451c069ba7449e259bf4cc80e2d11e622e364736
import '../../common_widgets/action_button.dart';
import '../../common_widgets/custom_divider.dart';
import '../../provider/notification_provider.dart';
import '../../route/routes_name.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../share/share_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .00, vertical: Utils.scrWidth * .0),
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                child: Utils.showImage('pic'),
              ),
              Positioned(
                left: 120,
                bottom: -40,
                child: SizedBox(
                    child: Utils.showImage('profile_image',
                        height: Utils.scrHeight * .096,
                        width: Utils.scrHeight * .096)),
              ),
            ],
          ),
          SizedBox(height: Utils.scrHeight * .05),

          // User Information Part
          isLogin ? buildUserInformationPart() : Container(),

          // Drawer Items Part
          _buildDrawerItems(context, isLogin: isLogin),
        ],
      ),
    );
  }

  Column buildUserInformationPart() {
    return Column(
      children: [
        Text('am_innnn', style: mediumTS(appTextColor, fontSize: 24)),
        Text('@am_innnn',
            style: regularTS(const Color(0xff8E99A9), fontSize: 14)),
      ],
    );
  }

  Padding _buildDrawerItems(BuildContext context, {bool isLogin = false}) {
    return Padding(
      padding: EdgeInsets.all(Utils.scrHeight * .02),
      child: Column(
        children: [
          isLogin
              ? Consumer<NotificationProvider>(
                  builder: (context, state, child) => CustomDrawerItem(
                    text: 'Notifications',
                    svgName: 'notification',
                    isToggleable: true,
                    switchProvider: Provider.of<NotificationProvider>(context),
                  ),
                )
              : Container(),
          CustomDrawerItem(
              onTap: () async {
<<<<<<< HEAD

=======
>>>>>>> 451c069ba7449e259bf4cc80e2d11e622e364736
                try {
                  await Share.share('https://flutter.dev/');
                } catch (e) {
                  Utils.showSnackBar(context, '$e');
                }
<<<<<<< HEAD

                // getPopUp(
                //     context,
                //     (p0) => ShareScreen(onExit: () {
                //           Navigator.pop(p0);
                //         }));
=======
>>>>>>> 451c069ba7449e259bf4cc80e2d11e622e364736
              },
              text: 'App Share',
              svgName: 'drawer_share',
              icon: Icons.arrow_forward_ios),
          isLogin
              ? const CustomDrawerItem(
                  text: 'Rate this App',
                  svgName: 'rating',
                  icon: Icons.arrow_forward_ios)
              : Container(),
          isLogin
              ? CustomDrawerItem(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.feedBack);
                  },
                  text: 'Feedback',
                  svgName: 'feedback',
                  icon: Icons.arrow_forward_ios)
              : Container(),
          const CustomDrawerItem(
              text: 'Contact Us',
              svgName: 'contact_us',
              icon: Icons.arrow_forward_ios),
          CustomDrawerItem(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.termsOfUses);
              },
              text: 'Terms Of Uses',
              svgName: 'terms_of_uses',
              icon: Icons.arrow_forward_ios),
          CustomDrawerItem(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.privacyPolicy);
              },
              text: 'Privacy & Policy',
              svgName: 'privacy&policy',
              icon: Icons.arrow_forward_ios),
          SizedBox(height: Utils.scrHeight * .09),

          // Logout Button
          isLogin
              ? const ActionButton(
                  buttonColor: Color(0xffFFCFCC),
                  textColor: Color(0xffFF3B30),
                  buttonName: 'Log Out',
                )
              : ActionButton(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  buttonColor: appThemeColor,
                  textColor: Colors.white,
                  buttonName: 'Log In',
                ),
        ],
      ),
    );
  }

  void getPopUp(
    BuildContext context,
    Widget Function(BuildContext) childBuilder,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: childBuilder(context));
        });
  }
}

class CustomDrawerItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String svgName;
  final bool isToggleable;
  final VoidCallback? onTap;
  final NotificationProvider? switchProvider;

  const CustomDrawerItem(
      {super.key,
      required this.text,
      this.icon,
      required this.svgName,
      this.onTap,
      this.isToggleable = false,
      this.switchProvider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .016,
            vertical: Utils.scrHeight * .016),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Utils.showSvgPicture(svgName),
                SizedBox(width: Utils.scrHeight * .016),
                Text(text, style: mediumTS(homeTabTextColor)),
                const Spacer(),
                isToggleable
                    ? Consumer<NotificationProvider>(
                        builder: (context, provider, child) => Switch(
                            value: provider.isSwitchToggled,
                            onChanged: (newValue) => provider.toggleSwitch(),
                            activeColor: appThemeColor,
                            activeTrackColor: const Color(0xffEBF3FF),
                            inactiveTrackColor: const Color(0xffB7C1D2),
                            inactiveThumbColor: const Color(0xff4E617E)),
                      )
                    : icon != null
                        ? Icon(icon,
                            size: Utils.scrHeight * .016,
                            color: homeTabTextColor)
                        : const SizedBox.shrink(),
              ],
            ),
            SizedBox(height: Utils.scrHeight * .01),
            const CustomDivider()
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/data/user_data.dart';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:am_innnn/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/action_button.dart';
import '../../common_widgets/custom_divider.dart';
import '../../provider/notification_provider.dart';
import '../../route/routes_name.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool _isLogin = false;
  String _authToken = '';
  final AuthProvider _authProvider = AuthProvider();

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the session data exists
    bool isLogin = prefs.containsKey('token');
    String? authToken = prefs.getString('token');
    setState(() {
      _isLogin = isLogin;
      _authToken = authToken!;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  left: Utils.scrHeight * .12,
                  bottom: -Utils.scrHeight * .045,
                  child: _isLogin
                      ? FutureBuilder<ProfileModel>(
                      future: UserData.userProfile(_authToken),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return SizedBox(
                              child: ClipOval(
                                child: Image.network('${ApiUrl.appBaseUrl}${data.data!.avatar}',
                                height: Utils.scrHeight * .096,
                                width: Utils.scrHeight * .096,fit: BoxFit.cover,),
                              ));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.hasError.toString()),
                          );
                        } else {
                          return Center(
                            child: Container(),
                          );
                        }
                      }) : SizedBox(
                      child: Utils.showImage('profile_image',
                          height: Utils.scrHeight * .096,
                          width: Utils.scrHeight * .096))
              ),
            ],
          ),
          SizedBox(height: Utils.scrHeight * .05),

          // User Information Part
          _isLogin
              ? FutureBuilder<ProfileModel>(
              future: UserData.userProfile(_authToken),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return buildUserInformationPart(
                      data.data!.username, data.data!.email);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.hasError.toString()),
                  );
                } else {
                  return Center(
                    child: Container(),
                  );
                }
              })
              : Container(),

          // Drawer Items Part
          _buildDrawerItems(context, isLogin: _isLogin),
        ],
      ),
    );
  }

  Column buildUserInformationPart(String? userName, String? email) {
    return Column(
      children: [
        Text(userName ?? 'User Name',
            style: mediumTS(appTextColor, fontSize: 24)),
        Text(email ?? 'Email',
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
            builder: (context, state, child) =>
                CustomDrawerItem(
                  text: 'Notifications',
                  svgName: 'notification',
                  isToggleable: true,
                  switchProvider: Provider.of<NotificationProvider>(context),
                ),
          )
              : Container(),
          CustomDrawerItem(
              onTap: () async {
                try {
                  await Share.share('https://flutter.dev/');
                } catch (e) {
                  Utils.showSnackBar(context, '$e');
                }
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
          _isLogin
              ? ActionButton(
                  onTap: () {
                    _logOut();
                  },
                  buttonColor: const Color(0xffFFCFCC),
                  textColor: const Color(0xffFF3B30),
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

  void getPopUp(BuildContext context,
      Widget Function(BuildContext) childBuilder,) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: childBuilder(context));
        });
  }

  void _logOut() async {
    await _authProvider.logoutUser(_authToken).then((value) {
      AuthService.clearSessionData();
      AuthService.clearUserId();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.home,
            (route) => false,
      );
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

  const CustomDrawerItem({super.key,
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
                  builder: (context, provider, child) =>
                      Switch(
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

// ignore_for_file: use_build_context_synchronously, prefer_final_fields
import 'dart:developer';

import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/data/user_data.dart';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/provider/country_provider.dart';
import 'package:am_innnn/provider/language_provider.dart';
import 'package:am_innnn/provider/news_provider.dart';
import 'package:am_innnn/provider/story_provider.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/view/drawer/widget/custom_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../common_widgets/action_button.dart';
import '../../common_widgets/delete_account_popup.dart';
import '../../provider/notification_provider.dart';
import '../../route/routes_name.dart';
import '../../utils/color.dart';
import '../../utils/di.dart';
import '../../utils/styles.dart';
import '../../utils/toast_util.dart';
import '../../utils/utils.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool _isLogin = appData.read(kKeyIsLoggedIn);
  String? _authToken = appData.read(kKeyToken);
  final AuthenticationProvider _authProvider = AuthenticationProvider();
  String? localImagePath;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .00, vertical: Utils.scrWidth * .0),
        children: [
          // Drawer Header Section
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Drawer Top Image
              Container(
                child: Utils.showImage('pic'),
              ),

              // Profile Image Section
              Positioned(
                  left: 110,
                  bottom: -Utils.scrHeight * .045,
                  child: _isLogin
                      ? Center(child: _drawerHeaderSection())
                      : SizedBox(
                          child: Utils.showImage('profile_image',
                              height: Utils.scrHeight * .096,
                              width: Utils.scrHeight * .096))),
            ],
          ),
          SizedBox(height: Utils.scrHeight * .05),

          // User Information Part
          _isLogin ? _userInfoSection() : Container(),

          // Drawer Items Part
          _buildDrawerItems(context, isLogin: _isLogin),
        ],
      ),
    );
  }

  // User Information Part (Showing the user name and email)
  FutureBuilder<ProfileModel> _userInfoSection() {
    return FutureBuilder<ProfileModel>(
        future: UserData.userProfile(_authToken!, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            //Showing the user name and email
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
        });
  }

  // DrawerHeader Section ( profile image section)
  FutureBuilder<ProfileModel> _drawerHeaderSection() {
    return FutureBuilder<ProfileModel>(
        future: UserData.userProfile(_authToken!, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            // Showing Profile Imgae
            return _profileImage(data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        });
  }

  //profile image section
  SizedBox _profileImage(ProfileModel data) {
    log('message: ${ApiUrl.imageBaseUrl}${data.data!.avatar}');
    return SizedBox(
      height: Utils.scrHeight * .096,
      width: Utils.scrHeight * .096,
      child: ClipOval(
          child: CachedNetworkImage(
        fit: BoxFit.cover,
        fadeInDuration: const Duration(seconds: 2),
        imageUrl: '${ApiUrl.imageBaseUrl}${data.data!.avatar}',
        errorWidget: (context, url, error) => Utils.showImage('profile_image'),
      )),
    );
  }

  // User anme and Email Section
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

  // Drawer Items
  Widget _buildDrawerItems(BuildContext context, {bool isLogin = false}) {
    return Padding(
      padding: EdgeInsets.all(Utils.scrHeight * .02),
      child: Column(
        children: [
          // Notificaiton Item
          isLogin
              ? Consumer<NotificationProvider>(
                  builder: (context, state, child) => CustomDrawerItem(
                    text: 'Notifications',
                    svgName: 'notification',
                    isToggleable: true,
                    onTap: () async {
                      await state.setInNotificationStatus();
                    },
                    switchProvider: Provider.of<NotificationProvider>(context),
                  ),
                )
              : const SizedBox.shrink(),
          // Edite Porfile
          isLogin
              ? CustomDrawerItem(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.editProfile);
                  },
                  text: 'Edit Profile',
                  svgName: 'edit',
                  icon: Icons.arrow_forward_ios)
              : const SizedBox.shrink(),

          // Share App Link
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
          // Rate this app
          const CustomDrawerItem(
              text: 'Rate this App',
              svgName: 'rating',
              icon: Icons.arrow_forward_ios),
          // FeddBack the app
          CustomDrawerItem(
              onTap: () {},
              text: 'Feedback',
              svgName: 'feedback',
              icon: Icons.arrow_forward_ios),
          // Contact Us
          CustomDrawerItem(
              onTap: () {
                _sideBarAction('https://aminn.reigeeky.com/contact');
              },
              text: 'Contact Us',
              svgName: 'contact_us',
              icon: Icons.arrow_forward_ios),
          // Apps Terms and Conditions
          CustomDrawerItem(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.termsOfUses);
              },
              text: 'Terms Of Uses',
              svgName: 'terms_of_uses',
              icon: Icons.arrow_forward_ios),
          // App Privacy & Policy
          CustomDrawerItem(
              onTap: () {
                // Navigator.pushNamed(context, RoutesName.privacyPolicy);
                _sideBarAction(
                    'http://aminn.reigeeky.com/pages/privacy-policy');
              },
              text: 'Privacy & Policy',
              svgName: 'privacy&policy',
              icon: Icons.arrow_forward_ios),

          SizedBox(height: Utils.scrHeight * .03),

          // Logout Button
          _isLogin
              ? ActionButton(
                  onTap: () {
                    appData.write(kKeyCategory, []);
                    Provider.of<NewsProvider>(context, listen: false)
                        .clearList();
                    Provider.of<StoryProvider>(context, listen: false)
                        .clearList();
                    _logOut();
                  },
                  buttonColor: const Color(0xffFFCFCC),
                  textColor: const Color(0xffFF3B30),
                  buttonName: 'Log Out',
                )
              : ActionButton(
                  onTap: () {
                    // Navigator.pushNamed(context, RoutesName.login);
                    // Provider.of<NewsProvider>(context, listen: false)
                    //     .clearList();
                    // Provider.of<StoryProvider>(context, listen: false)
                    //     .clearList();
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.login, (route) => false);
                  },
                  buttonColor: appThemeColor,
                  textColor: Colors.white,
                  buttonName: 'Log In',
                ),

          SizedBox(height: Utils.scrHeight * .04),

          // Logout Button
          _isLogin
              ? ActionButton(
                  onTap: () {
                    getPopUp(
                      context,
                      (p0) => const WelComePopup(),
                    );
                  },
                  buttonColor: const Color(0xffFFCFCC),
                  textColor: const Color(0xffFF3B30),
                  buttonName: 'Delete Account',
                )
              : const SizedBox.shrink(),
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

  void _logOut() async {
    await _authProvider.logoutUser(_authToken!).then((value) {
      appData.write(kKeyCountryCode, 'in');
      appData.write(kKeyLanguageId, 22);
      appData.remove(kKeyUserID);
      appData.remove(kKeyToken);
      appData.write(kKeyIsLoggedIn, false);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.home,
        (route) => false,
      );
    });
  }

  void _sideBarAction(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      ToastUtil.showShortToast('No apps found to perform this action');
    }
  }
}

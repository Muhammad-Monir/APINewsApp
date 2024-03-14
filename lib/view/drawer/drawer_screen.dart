// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/data/user_data.dart';
import 'package:am_innnn/model/user_profile_model.dart';
import 'package:am_innnn/utils/api_url.dart';
import 'package:am_innnn/services/auth_service.dart';
import 'package:am_innnn/view/drawer/widget/custom_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../common_widgets/action_button.dart';
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
  String? _authToken = '';
  final AuthProvider _authProvider = AuthProvider();
  String? localImagePath;

  @override
  void initState() {
    isLogfedIn();
    super.initState();
  }

  void isLogfedIn() {
    _isLogin = Provider.of<AuthService>(context, listen: false).isLoggedIn();
    log(_isLogin.toString());
    if (_isLogin) {
      _authToken = Provider.of<AuthService>(context, listen: false).getToken();
    }
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
                  left: Utils.scrHeight * .12,
                  bottom: -Utils.scrHeight * .045,
                  child: _isLogin
                      ? _drawerHeaderSection()
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

  FutureBuilder<ProfileModel> _userInfoSection() {
    return FutureBuilder<ProfileModel>(
        future: UserData.userProfile(_authToken!, context),
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
        });
  }

  FutureBuilder<ProfileModel> _drawerHeaderSection() {
    return FutureBuilder<ProfileModel>(
        future: UserData.userProfile(_authToken!, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
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
                  builder: (context, state, child) => CustomDrawerItem(
                    text: 'Notifications',
                    svgName: 'notification',
                    isToggleable: true,
                    switchProvider: Provider.of<NotificationProvider>(context),
                  ),
                )
              : Container(),
          isLogin
              ? CustomDrawerItem(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.editProfile);
                  },
                  text: 'Edit Profile',
                  svgName: 'edit',
                  icon: Icons.arrow_forward_ios)
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
          // isLogin
          //     ? CustomDrawerItem(
          //         onTap: () {
          //           Navigator.pushNamed(context, RoutesName.feedBack);
          //         },
          //         text: 'Feedback',
          //         svgName: 'feedback',
          //         icon: Icons.arrow_forward_ios)
          //     : Container(),
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
          SizedBox(height: Utils.scrHeight * .074),

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
    final sharedInstance = Provider.of<AuthService>(context, listen: false);
    await _authProvider.logoutUser(_authToken!).then((value) {
      sharedInstance.clearSessionData();
      sharedInstance.clearUserId();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.home,
        (route) => false,
      );
    });
  }
}

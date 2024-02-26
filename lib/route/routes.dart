import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/view/bookmarks/bookmarks_screen.dart';
import 'package:am_innn/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:am_innn/view/feedback/feedback_screen.dart';
import 'package:am_innn/view/drawer/drawer_screen.dart';
import 'package:am_innn/view/font/font_screen.dart';
import 'package:am_innn/view/home/home_screen.dart';
import 'package:am_innn/view/login/login_screen.dart';
import 'package:am_innn/view/privacy_policy/privacy_policy_screen.dart';
import 'package:am_innn/view/register/register_screen.dart';
import 'package:am_innn/view/search/search_screen.dart';
import 'package:am_innn/view/share/share_screen.dart';
import 'package:am_innn/view/splash/splash_screen.dart';
import 'package:am_innn/view/story/story_screen.dart';
import 'package:am_innn/view/terms_of_uses/terms_of_uses.dart';
import 'package:flutter/material.dart';

import '../view/change_password/change_password_screen.dart';
import '../view/forgot_password/forgot_password_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.search:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
      case RoutesName.font:
        return MaterialPageRoute(
          builder: (context) => const FontScreen(),
        );
      case RoutesName.bookmark:
        return MaterialPageRoute(
          builder: (context) => const BookMarksScreen(),
        );
      case RoutesName.share:
        return MaterialPageRoute(
          builder: (context) => const ShareScreen(),
        );
      case RoutesName.bottomNavigationBar:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationMenu(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case RoutesName.privacyPolicy:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyScreen(),
        );
      case RoutesName.feedBack:
        return MaterialPageRoute(
          builder: (context) => const FeedbackScreen(),
        );
      case RoutesName.termsOfUses:
        return MaterialPageRoute(
          builder: (context) => const TermsOfUses(),
        );
      case RoutesName.drawerScreen:
        return MaterialPageRoute(
          builder: (context) => const DrawerScreen(),
        );
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case RoutesName.changePassword:
        return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );
      case RoutesName.story:
        return MaterialPageRoute(
          builder: (context) => const StoryScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}

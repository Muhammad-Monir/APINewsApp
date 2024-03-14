import 'package:am_innnn/model/story_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/view/drawer/widget/edit_profile_screen.dart';
import 'package:am_innnn/view/login/widgets/verify_account.dart';
import 'package:flutter/material.dart';
import '../view/bookmarks/bookmarks_screen.dart';
import '../view/bottom_navigation/bottom_navigation_bar.dart';
import '../view/change_password/change_password_screen.dart';
import '../view/drawer/drawer_screen.dart';
import '../view/feedback/feedback_screen.dart';
import '../view/font/font_screen.dart';
import '../view/forgot_password/forgot_password_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/privacy_policy/privacy_policy_screen.dart';
import '../view/register/register_screen.dart';
import '../view/search/search_screen.dart';
import '../view/share/share_screen.dart';
import '../view/splash/splash_screen.dart';
import '../view/story/story_screen.dart';
import '../view/terms_of_uses/terms_of_uses.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        final Map<String, dynamic>? category =
            settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            category: category,
          ),
        );
      // case RoutesName.home2:
      //   final Map<String, dynamic>? category =
      //       settings.arguments as Map<String, dynamic>?;
      //   return MaterialPageRoute(
      //     builder: (context) => NewHomeScreen(
      //       category: category,
      //     ),
      //   );
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
      case RoutesName.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case RoutesName.changePassword:
        final uniqueString = settings.arguments as CombineEmailOtp;
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            emailOtp: uniqueString,
          ),
        );
      case RoutesName.verifyAccount:
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => VerifyAccountScreen(
            email: email,
          ),
        );
      case RoutesName.story:
        final List<Images>? imageUrl = settings.arguments as List<Images>?;
        return MaterialPageRoute(
          builder: (context) => StoryScreen(
            images: imageUrl,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}

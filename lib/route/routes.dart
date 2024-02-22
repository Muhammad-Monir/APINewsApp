

import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/view/bookmarks/bookmarks_screen.dart';
import 'package:am_innn/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:am_innn/view/drawer/drawer_screen.dart';
import 'package:am_innn/view/font/font_screen.dart';
import 'package:am_innn/view/home/home_screen.dart';
import 'package:am_innn/view/search/search_screen.dart';
import 'package:am_innn/view/share/share_screen.dart';
import 'package:am_innn/view/terms_of_uses/terms_of_uses.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
        case RoutesName.search:
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );
        case RoutesName.font:
        return MaterialPageRoute(
          builder: (context) => FontScreen(),
        );
        case RoutesName.bookmark:
        return MaterialPageRoute(
          builder: (context) => BookMarksScreen(),
        );
        case RoutesName.share:
        return MaterialPageRoute(
          builder: (context) => ShareScreen(),
        );
        case RoutesName.bottomNavigationBar:
        return MaterialPageRoute(
          builder: (context) => BottomNavigationMenu(),
        );
      case RoutesName.termsOfUses:
        return MaterialPageRoute(
          builder: (context) => TermsOfUses(),
        );
      case RoutesName.drawerScreen:
        return MaterialPageRoute(
          builder: (context) => DrawerScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        );
    }
  }
}

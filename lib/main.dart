import 'package:am_innn/provider/bookmark_provider.dart';
import 'package:am_innn/provider/bottom_navigation_provider.dart';
import 'package:am_innn/provider/drop_down_provider.dart';
import 'package:am_innn/provider/font_size_provider.dart';
import 'package:am_innn/provider/notification_provider.dart';
import 'package:am_innn/provider/obscure_provider.dart';
import 'package:am_innn/provider/timer_provider.dart';
import 'package:am_innn/route/routes.dart';
import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utils.initScreenSize(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarsVisibility()),
        ChangeNotifierProvider(create: (_) => ObscureProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
        ChangeNotifierProvider(create: (_) => DropDownProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Api News App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
          colorScheme: ColorScheme.fromSeed(seedColor: appThemeColor),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

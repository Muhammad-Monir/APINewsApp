import 'package:am_innn/provider/bottom_navigation_provider.dart';
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
    statusBarIconBrightness: Brightness.dark,
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
        ChangeNotifierProvider<BarsVisibility>(create: (_) => BarsVisibility()),
        ChangeNotifierProvider<BottomNavigationProvider>(create: (_) => BottomNavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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



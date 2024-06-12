import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/provider/bookmark_provider.dart';
import 'package:am_innnn/provider/bottom_navigation_provider.dart';
import 'package:am_innnn/provider/country_provider.dart';
import 'package:am_innnn/provider/drop_down_provider.dart';
import 'package:am_innnn/provider/font_size_provider.dart';
import 'package:am_innnn/provider/news_provider.dart';
import 'package:am_innnn/provider/notification_provider.dart';
import 'package:am_innnn/provider/obscure_provider.dart';
import 'package:am_innnn/provider/story_provider.dart';
import 'package:am_innnn/provider/timer_provider.dart';
import 'package:am_innnn/route/routes.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'provider/language_provider.dart';
import 'services/notification_service.dart';
import 'utils/helper.dart';
import 'utils/toast_util.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  diSetup();
  await GetStorage.init();
  initInternetChecker();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  LocalNotificationService.getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
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
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => CountryProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        // Provider(create: (_) => AuthService(preferences!)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Api News App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
          colorScheme: ColorScheme.fromSeed(seedColor: appThemeColor),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

void rotation() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> initInternetChecker() async {
  InternetConnectionChecker.createInstance(
          checkTimeout: const Duration(seconds: 1),
          checkInterval: const Duration(seconds: 2))
      .onStatusChange
      .listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        ToastUtil.showShortToast('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        ToastUtil.showNoInternetToast();
        break;
    }
  });
}

import 'package:am_innnn/data/auth_data.dart';
import 'package:am_innnn/provider/bookmark_provider.dart';
import 'package:am_innnn/provider/bottom_navigation_provider.dart';
import 'package:am_innnn/provider/drop_down_provider.dart';
import 'package:am_innnn/provider/font_size_provider.dart';
import 'package:am_innnn/provider/notification_provider.dart';
import 'package:am_innnn/provider/obscure_provider.dart';
import 'package:am_innnn/provider/timer_provider.dart';
import 'package:am_innnn/route/routes.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/services/auth_service.dart';
import 'package:am_innnn/utils/color.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  LocalNotificationService.getToken();
  runApp(MyApp(
    preferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? preferences;
  const MyApp({super.key, this.preferences});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    rotation();
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        Provider(create: (_) => AuthService(preferences!)),
        // ChangeNotifierProvider(create: (_) => UserProvider()),
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

import 'package:provider/provider.dart';

import '../data/auth_data.dart';
import '../provider/bookmark_provider.dart';
import '../provider/bottom_navigation_provider.dart';
import '../provider/drop_down_provider.dart';
import '../provider/font_size_provider.dart';
import '../provider/notification_provider.dart';
import '../provider/obscure_provider.dart';
import '../provider/timer_provider.dart';

var providers = [
  ChangeNotifierProvider(create: (_) => BarsVisibility()),
  ChangeNotifierProvider(create: (_) => ObscureProvider()),
  ChangeNotifierProvider(create: (_) => NotificationProvider()),
  ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
  ChangeNotifierProvider(create: (_) => FontSizeProvider()),
  ChangeNotifierProvider(create: (_) => DropDownProvider()),
  ChangeNotifierProvider(create: (_) => BookmarkProvider()),
  ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];

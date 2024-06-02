import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'app_constants.dart';
import 'di.dart';

Future<void> setInitValue() async {
  await appData.writeIfNull(kKeyIsLoggedIn, false);
  await appData.writeIfNull(kKeyCountryCode, 'us');
  await appData.writeIfNull(kKeyLanguageCode, 'en');
  await appData.writeIfNull(kKeyLanguageName, 'English');
  await appData.writeIfNull(kKeyLanguageId, 2);

  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    appData.writeIfNull(
        kKeyDeviceID, iosDeviceInfo.identifierForVendor); // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo =
        await deviceInfo.androidInfo; // unique ID on Android
    appData.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  }
  await Future.delayed(const Duration(seconds: 2));
}

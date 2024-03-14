import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class GetDeviceInfo {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static Future<String?> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        String deviceID = androidInfo.id;
        log("device id is: $deviceID");
        return deviceID;
      }
      // else if (Platform.isIOS) {
      //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      //   String deviceID = await iosInfo.data;
      //   return deviceID;
      // }
    } catch (e) {
      ('Failed to get device info: $e');
    }
    return null;
  }
}

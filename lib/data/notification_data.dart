import 'dart:convert';
import 'dart:developer';

import 'package:am_innnn/utils/api_url.dart';
import 'package:http/http.dart' as http;

class NotificationData {
  static Future<void> storeNotification(String fcmToken, String deviceId,
      {String? userId, bool? isActive}) async {
    try {
      Object body = (userId != null && isActive != null)
          ? jsonEncode(<String, dynamic>{
              'user_id': userId,
              'is_active': isActive ? '1' : '0',
              'token': fcmToken,
              'device_id': deviceId
            })
          : jsonEncode(
              <String, dynamic>{'token': fcmToken, 'device_id': deviceId});
      log(body.toString());
      final response = await http.post(Uri.parse(ApiUrl.storeNotification),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log(data.toString());
      } else {
        log(response.statusCode.toString());
        throw Exception(response.statusCode);
      }
    } catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }
}

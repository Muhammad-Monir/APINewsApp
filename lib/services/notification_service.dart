// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:am_innnn/data/notification_data.dart';
import 'package:am_innnn/services/get_device_info.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/di.dart';

//import '../networks/api_acess.dart';
//import 'di.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static void initialize() {
    // initializationSettings  for Android
    if (Platform.isAndroid) {
      _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.getNotificationSettings();
    }
    // 1. This method only call when App is terminated(closed)
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          FlutterAppBadger.updateBadgeCount(1);
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          FlutterAppBadger.removeBadge();
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {},
    );

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((details) {
      {}
    }));
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "plix",
          "plixpushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.black,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['url'],
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> getToken({bool? isActive}) async {
    _firebaseMessaging.getToken().then((token) async {
      log('[FCM]--> token: [ $token ]');
      await sendToken(token!, activeStatus: isActive);
    });

    _firebaseMessaging.onTokenRefresh.listen((token) async {
      log('[FCM]--> token: [ $token ]');
      await sendToken(token, activeStatus: isActive);
    });
  }

  static Future<void> sendToken(String token, {bool? activeStatus}) async {
    try {
      String? deviceId = await GetDeviceInfo.getDeviceInfo();
      log(deviceId.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool isLoggedIn = AuthService(prefs).isLoggedIn();
      // log(AuthService(prefs).isLoggedIn().toString());
      // if (isLoggedIn) {
      if (appData.read(kKeyIsLoggedIn)) {
        // log(AuthService(prefs).getUserID().toString());
        NotificationData.storeNotification(token, deviceId.toString(),
            // userId: AuthService(prefs).getUserID().toString(),
            userId: appData.read(kKeyUserID),
            isActive: activeStatus);
      } else {
        NotificationData.storeNotification(token, deviceId.toString());
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> removeToken() async {
    try {
      _firebaseMessaging.deleteToken();
    } catch (error) {
      rethrow;
    }
  }
}

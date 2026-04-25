import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:spjewellery/controllers/auth_controller.dart';

import '../firebase_options.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("backgroundHandler:");
  print(message.data.toString());
  print(message.notification?.title ?? "");
  /* HistoryController historyController = Get.find<HistoryController>();
  historyController.getOrderHistory();*/
}

class PushNotificationHelper {
  static String fcmToken = "";
  static Future<void> initialized() async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        name: "sb-jewel",
      );
      FirebaseMessaging.instance.requestPermission();
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        name: "sb-jewel",
      );
      FirebaseMessaging.instance.requestPermission();
    }

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.instance.subscribeToTopic("sb");
    getDeviceTokenToSendNotification();

    // If App is Terminated state & used click notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");

      if (message != null) {
        print("New Notification");
        print(message.data.toString());
        print(message.notification?.title ?? "");
      }
    });

    // App is Forground this method  work
    FirebaseMessaging.onMessage.listen((message) {
      AuthController authController = Get.find<AuthController>();
      authController.getUser(isInitial: false);
      /*HistoryController historyController = Get.find<HistoryController>();
      historyController.getOrderHistory();*/
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);

        if (Platform.isAndroid) {
          // Local Notification Code to Display Alert
          NotificationHelper.displayNotification(message);
        }
      }
    });

    // App on Backaground not Terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);

        openNotification(message.data);
      }
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<String> getDeviceTokenToSendNotification() async {
    fcmToken = (await FirebaseMessaging.instance.getToken()).toString();
    // print("FCM Token: $fcmToken");

    return fcmToken;
  }
}

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialized() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveNotificationResponse: (details) {
        try {
          var payloadObj = json.decode(details.payload ?? "{}") as Map? ?? {};
          openNotification(payloadObj);
        } catch (e) {
          print(e);
        }
      },
      onDidReceiveBackgroundNotificationResponse: localBackgroundHandler,
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "sea-standard",
          "sea-standard_channel",
          importance: Importance.max,
          priority: Priority.high,
          icon: "@mipmap/ic_launcher",
        ),
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

Future<void> localBackgroundHandler(NotificationResponse data) async {
  print(data.toString());
  print("localBackgroundHandler :");
  print(
    data.notificationResponseType ==
            NotificationResponseType.selectedNotification
        ? "selectedNotification"
        : "selectedNotificationAction",
  );
  print(data.payload);

  try {
    var payloadObj = json.decode(data.payload ?? "{}") as Map? ?? {};
    openNotification(payloadObj);
  } catch (e) {
    print(e);
  }
}

void openNotification(Map payloadObj) async {}

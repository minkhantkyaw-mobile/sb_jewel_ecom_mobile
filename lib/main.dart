import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:spjewellery/core/theme/my_theme_data.dart';
import 'package:spjewellery/firebase_options.dart';
import 'package:spjewellery/router/route_helper.dart';
import 'package:spjewellery/services/language.dart';
import 'package:spjewellery/services/push_notification_helper.dart';

import 'appbinding/app_binding.dart';

import 'controllers/auth_controller.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await PushNotificationHelper.initialized();
  // Initialize GetX dependencies
  await AppBinding().dependencies();
  // var fcmToken =
  //     await PushNotificationHelper.getDeviceTokenToSendNotification();
  // print("FCM TOKEN: $fcmToken");

  // Optional: small delay to smooth splash transition
  await Future.delayed(const Duration(milliseconds: 300));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController authController = Get.find<AuthController>();

  Future<void> changeLng() async {
    int? lng = await authController.authRepo.getAppLanguage();
    setState(() {
      Get.updateLocale(Locale(lng == 0 ? "en" : "mm"));
    });
  }

  @override
  void initState() {
    super.initState();
    changeLng();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SB Jewel Accessories',
      initialBinding: AppBinding(),
      theme: myThemeData(context),
      initialRoute: RouteHelper.nav,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = BotToastInit()(context, child);
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: child,
        );
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      getPages: RouteHelper.routes,
      translations: LocalString(),
      locale: const Locale('en', 'mm'),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../services/pref_service.dart';

// class AppStateController extends GetxController {
//   final prefService = Get.find<PrefService>();

//   @override
//   void onInit() {
//     super.onInit();

//     loadData();
//   }

//   void loadData() {
//     isSwitchedOn.value = prefService.getAppLanguage(); // mm true , eng false
//     // isEnableNotification.value = prefService.getNotificationStatus();
//   }

//   // RxBool isEnableNotification = true.obs;
//   // Future<void> enableNotification(bool value) async {
//   //   isEnableNotification.value = value;
//   //   prefService.saveNotificationStatus(isEnabled: value);

//   //   if (value) {
//   //     await PushNotificationHelper.enableNotifications();
//   //   } else {
//   //     await PushNotificationHelper.disableNotifications();
//   //   }
//   // }

//   RxBool isSwitchedOn = false.obs;

//   void onChangeLanguage(bool val) {
//     isSwitchedOn.value = val;

//     if (isSwitchedOn.value) {
//       Get.updateLocale(const Locale('mm', 'MM'));
//       prefService.saveAppLanguage(val: val);
//     } else {
//       Get.updateLocale(const Locale('en', 'US'));
//       prefService.saveAppLanguage(val: val);
//     }
//   }
// }

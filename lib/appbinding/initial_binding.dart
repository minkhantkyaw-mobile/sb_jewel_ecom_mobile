import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/api_route_constants.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class InitailBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    //*Shared Preference
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    Get.put<PrefService>(PrefService(sharedPreferences: sharedPreferences),
        permanent: true);
    //*Api Client
    Get.put<ApiClient>(
        ApiClient(
            appBaseUrl: RouteConstant.baseUrl,
            sharedPreferences: sharedPreferences),
        permanent: true);


  }
}

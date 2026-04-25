import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../core/constants/api_route_constants.dart';

class NotiRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  NotiRepo({required this.apiClient, required this.prefService});

  Future<Response> getNoti() async {
    return await apiClient.getData(RouteConstant.notifications);
  }

  Future<Response> getNotiRead({required String id}) async {
    return await apiClient.getData(RouteConstant.notiRead(id: id));
  }

  Future<String> getAppToken() async => await prefService.getAppToken();
}

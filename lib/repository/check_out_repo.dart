import 'package:get/get.dart';

import '../core/constants/api_route_constants.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class CheckOutRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  CheckOutRepo({required this.apiClient, required this.prefService});
  Future<Response> getRegions() async {
    return await apiClient.getData(RouteConstant.regions);
  }

  Future<Response> getTownShipCOD({required int page}) async {
    return await apiClient.getData(
      RouteConstant.getTownShips(page: page.toString(), limit: "25"),
    );
  }

  Future<Response> getSearchTownShipCOD({
    required int page,
    required String name,
  }) async {
    return await apiClient.getData("township-list?city=$name&page=1&limit=10");
  }

  Future<Response> getDeliveryFee({required int id}) async {
    return await apiClient.getData(RouteConstant.township(id: id));
  }

  Future<Response> getPayments() async {
    return await apiClient.getData(RouteConstant.payments);
  }

  Future<Response> postOrder({required FormData data}) async {
    return await apiClient.postFormData(RouteConstant.orders, data);
  }

  Future<Response> postExchangeOrder({required FormData data}) async {
    return await apiClient.postFormData(RouteConstant.exchange_order, data);
  }

  /*

  Future<Response> getTownships({required int regionId}) async {
    return await apiClient.getData(RouteConstant.townships(regionId: regionId));
  }

  Future<Response> getDelivery({required int townId}) async {
    return await apiClient.getData(RouteConstant.delivery(townshipId: townId));
  }

  Future<Response> getSearchDelivery(
      {required int townId, required int deliveryId}) async {
    return await apiClient.postFormData(RouteConstant.deliverySearch,
        FormData({"township_id": townId, "delivery_id": deliveryId}));
  }



  */
}

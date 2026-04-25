import 'package:get/get.dart';

import '../core/constants/api_route_constants.dart';
import '../services/api_service.dart';

class OrderHisRepo {
  final ApiClient apiClient;
  OrderHisRepo({required this.apiClient});

  Future<Response> getOrderDetail({required int id}) async {
    return await apiClient.getData(RouteConstant.orderDetail(id: id));
  }

  Future<Response> getOrder() async {
    return await apiClient.getData(RouteConstant.orders);
  }

  Future<Response> getPointHistory() async {
    return await apiClient.getData(RouteConstant.point_history);
  }
}

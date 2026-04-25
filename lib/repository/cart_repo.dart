import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../core/constants/api_route_constants.dart';

class CartRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  CartRepo({required this.apiClient, required this.prefService});
  Future<Response> getCarts() async {
    return await apiClient.getData(RouteConstant.cart);
  }

  Future<Response> addCart({
    required int productId,
    required int quantity,
    int? sizeID,
  }) async {
    // Build the request body dynamically
    Map<String, dynamic> body = {
      "product_id": productId,
      "quantity": quantity,
      if (sizeID != null && sizeID > 0)
        "size_id": sizeID, // only include if > 0
    };

    // Send the body to the API
    return await apiClient.postData(
      RouteConstant.addToCartWithParams(body), // just the endpoint
      body, // <-- send body here
    );
  }

  /*



  updateHeader(String token) {
    apiClient.updateHeader(token);
  }


  */
  Future<Response> deleteCart({required int cartId}) async {
    return await apiClient.deleteData(RouteConstant.cartUpdate(id: cartId));
  }

  Future<Response> deleteAllCart() async {
    return await apiClient.deleteData(RouteConstant.cart_clear);
  }

  Future<Response> updateCart({
    required FormData formData,
    required int cartId,
  }) async {
    return await apiClient.postFormData(
      RouteConstant.cartUpdate(id: cartId),
      formData,
    );
  }

  Future<String> getAppToken() async => await prefService.getAppToken();
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spjewellery/models/point_history_model.dart';

import '../models/order_detail_model.dart';
import '../models/order_history_model.dart';
import '../services/toast_service.dart';
import '../repository/order_his_repo.dart';

class OrderHisController extends GetxController {
  final OrderHisRepo orderHisRepo;
  OrderHisController({required this.orderHisRepo});
  @override
  void onInit() {
    // getOrderHis();
    super.onInit();
  }

  Rx<OrderDetailData> orderDetailData = OrderDetailData().obs;
  RxBool isLoading = false.obs;
  RxList<OrderHistoryData> orderList = <OrderHistoryData>[].obs;
  RxList<PointHistoryData> pointHistoryList = <PointHistoryData>[].obs;

  var allOrders = <OrderHistoryData>[];
  var selectedDate = ''.obs;

  RxBool canLoadMore = true.obs;
  RxInt page = 1.obs;

  Future<void> getOrder() async {
    isLoading.value = true;
    try {
      final response = await orderHisRepo.getOrder();
      if (response.statusCode == 200) {
        final OrderHistoryModel orderModel = OrderHistoryModel.fromJson(
          response.body,
        );
        allOrders = List.from(orderModel.data!); // 👈 backup
        orderList.assignAll(allOrders);
        // canLoadMore.value = orderModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      print("Error>>>" + e.toString());
      //ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void filterByDate(String date) {
    selectedDate.value = date;

    if (date.isEmpty) {
      orderList.assignAll(allOrders);
      return;
    }

    orderList.assignAll(
      allOrders.where((order) {
        if (order.createdAt == null) return false;

        try {
          DateTime orderDate = DateTime.parse(order.createdAt!);
          String orderDay = DateFormat('yyyy-MM-dd').format(orderDate);

          return orderDay == date;
        } catch (e) {
          return false;
        }
      }).toList(),
    );
  }

  void resetDateFilter() {
    selectedDate.value = '';
    orderList.assignAll(allOrders); // restore original data
  }

  Future<void> getPointHistory() async {
    isLoading.value = true;
    try {
      final response = await orderHisRepo.getPointHistory();
      if (response.statusCode == 200) {
        final PointHistoryModel orderModel = PointHistoryModel.fromJson(
          response.body,
        );
        pointHistoryList.assignAll(orderModel.data!);
        // canLoadMore.value = orderModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      //ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOrderDetail({required int id}) async {
    isLoading.value = true;
    try {
      final response = await orderHisRepo.getOrderDetail(id: id);
      if (response.statusCode == 200) {
        final OrderDetailModel orderModel = OrderDetailModel.fromJson(
          response.body,
        );
        orderDetailData.value = orderModel.data!;
        // canLoadMore.value = orderModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      //ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Color orderColor(String orderStatus) {
    switch (orderStatus) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancel":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}

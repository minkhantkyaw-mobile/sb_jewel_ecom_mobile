import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';
import 'package:spjewellery/models/point_history_model.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/data_constant.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/order_history_model.dart';

class OrderInfoCardWidget extends StatelessWidget {
  final OrderHistoryData orderData;
  final Color orderColor;
  const OrderInfoCardWidget({
    super.key,
    required this.orderColor,
    required this.orderData,
  });

  Color orderColors(String orderStatus) {
    switch (orderStatus) {
      case "pending":
        return Colors.orange;
      case "complete":
        return Colors.green;
      case "cancel":
        return Colors.red;
      case "confirm":
        return Colors.green;
      case "processing":
        return Colors.red;
      case "delivered":
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late String orderStatusText;

    String orderText(String orderText) {
      print("OrderStatus>>>" + orderText);
      switch (orderText) {
        case "pending":
          return orderStatusText = "Pending";
        case "complete":
          return orderStatusText = "Complete";
        case "cancel":
          return orderStatusText = 'Cancel';
        case "confirm":
          return orderStatusText = 'Confirm';
        case "processing":
          return orderStatusText = 'Processing';
        case "delivered":
          return orderStatusText = 'Delivered';
        default:
          return orderStatusText = "";
      }
    }

    print("Order Data Status " + orderData.status.toString());
    print("Order Data" + orderData.toString());

    return Container(
      padding: EdgeInsets.all(Dimesion.width10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${orderData.id}".tr,
                style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "${DataConstant.priceFormat.format(int.parse(orderData.grandTotal.toString()))} Ks"
                    .tr,
                style: context.titleMedium.copyWith(color: orderColor),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (orderData.refundDate!.isEmpty &&
                  orderData.refundMessage!.isEmpty)
                Text(
                  // orderData.status ?? "",
                  orderText(orderData.status.toString()),
                  style: context.titleMedium.copyWith(
                    color: orderColors(orderData.status.toString()),
                  ),
                )
              else
                Text(
                  "Refund".tr,
                  style: context.titleMedium.copyWith(color: Colors.blue),
                ),
              Text(
                "Date: ${DataConstant.dateFormat.format(DateTime.parse(orderData.createdAt.toString()))}"
                    .tr,
                style: context.labelMedium,
              ),
            ],
          ),
          Gap(Dimesion.width5),
          Icon(
            Icons.chevron_right_rounded,
            size: Dimesion.iconSize16,
            color: AppColor.primaryClr,
          ),
        ],
      ),
    );
  }
}

class PointInfoCardWidget extends StatelessWidget {
  final PointHistoryData orderData;
  final Color orderColor;
  const PointInfoCardWidget({
    super.key,
    required this.orderColor,
    required this.orderData,
  });

  Color orderColors(String orderStatus) {
    switch (orderStatus) {
      case "pending":
        return Colors.orange;
      case "complete":
        return Colors.green;
      case "cancel":
        return Colors.red;
      case "confirm":
        return Colors.green;
      case "processing":
        return Colors.red;
      case "delivered":
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late String orderStatusText;

    String orderText(String orderText) {
      print("OrderStatus>>>" + orderText);
      switch (orderText) {
        case "pending":
          return orderStatusText = "Pending";
        case "complete":
          return orderStatusText = "Complete";
        case "cancel":
          return orderStatusText = 'Cancel';
        case "confirm":
          return orderStatusText = 'Confirm';
        case "processing":
          return orderStatusText = 'Processing';
        case "delivered":
          return orderStatusText = 'Delivered';
        default:
          return orderStatusText = "";
      }
    }

    return Container(
      padding: EdgeInsets.all(Dimesion.width10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${orderData.id}".tr,
                style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "${DataConstant.priceFormat.format(int.parse(orderData.points.toString()))} Points"
                    .tr,
                style: context.titleMedium.copyWith(color: orderColor),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (orderData.order.toString() != "null")
                if (orderData.order!.refundDate!.isEmpty &&
                    orderData.order!.refundMessage!.isEmpty)
                  Text(
                    // orderData.status ?? "",
                    orderText(orderData.order!.status.toString()),
                    style: context.titleMedium.copyWith(
                      color: orderColors(orderData.order!.status.toString()),
                    ),
                  )
                else
                  Text(
                    "Refund".tr,
                    style: context.titleMedium.copyWith(color: Colors.blue),
                  ),
              Text(
                "Date: ${DataConstant.dateFormat.format(DateTime.parse(orderData.createdAt.toString()))}"
                    .tr,
                style: context.labelMedium,
              ),
            ],
          ),
          Gap(Dimesion.width5),
          Icon(
            Icons.chevron_right_rounded,
            size: Dimesion.iconSize16,
            color: AppColor.primaryClr,
          ),
        ],
      ),
    );
  }
}

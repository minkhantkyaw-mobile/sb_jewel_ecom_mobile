import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../../controllers/order_his_controller.dart';
import '../../core/app_data.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/row_text_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../../models/order_history_model.dart';
import '../../router/route_helper.dart';
import '../checkout_screen/checkout_widgets/selected_payment_widget.dart';
import '../product_detail_screen/product_detail_screen.dart';
import 'ordet_his_widgets/order_info_card_widget.dart';
import 'ordet_his_widgets/order_item_widget.dart';
import 'ordet_his_widgets/transition_image_widget.dart';

class OrderHisDetailScreen extends StatefulWidget {
  final OrderHistoryData orderData;
  final Color orderColor;
  const OrderHisDetailScreen({
    super.key,
    required this.orderColor,
    required this.orderData,
  });

  @override
  State<OrderHisDetailScreen> createState() => _OrderHisDetailScreenState();
}

class _OrderHisDetailScreenState extends State<OrderHisDetailScreen> {
  final OrderHisController controller = Get.find<OrderHisController>();
  late bool isPayment = false;
  @override
  void initState() {
    setState(() {
      if (widget.orderData.payment == null) {
        isPayment = false;
      } else {
        isPayment = true;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getOrderDetail(id: widget.orderData.id!);
    });
    super.initState();
  }

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

  // ignore: unused_local_variable
  late String orderStatusText;

  String orderText(String orderText) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(Dimesion.radius15),
          ),
        ),
        toolbarHeight: Dimesion.screenHeight / 11,
        leading: backButton(),
        backgroundColor: AppColor.primaryClr,
        centerTitle: true,
        title: Text(
          "Order History Detail".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.all(Dimesion.width10),
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimesion.width5),
            ),
            color: Colors.grey.shade100,
            surfaceTintColor: Colors.grey.shade100,
            child: Container(
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
                        "ID: ${widget.orderData.id}".tr,
                        style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${DataConstant.priceFormat.format(int.parse(widget.orderData.grandTotal.toString()))} MMK"
                            .tr,
                        style: context.titleMedium.copyWith(
                          color: widget.orderColor,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   widget.orderData.status ?? "",
                      //   style: context.titleMedium.copyWith(
                      //     color: widget.orderColor,
                      //   ),
                      // ),
                      if (widget.orderData.refundDate!.isEmpty &&
                          widget.orderData.refundMessage!.isEmpty)
                        Text(
                          // orderStatusText,
                          orderText(widget.orderData.status.toString()),
                          style: context.titleMedium.copyWith(
                            color: orderColors(
                              widget.orderData.status.toString(),
                            ),
                          ),
                        )
                      else
                        Text(
                          "Refund".tr,
                          style: context.titleMedium.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      Text(
                        "Date: ${DataConstant.dateFormat.format(DateTime.parse(widget.orderData.createdAt.toString()))}"
                            .tr,
                        style: context.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimesion.width5),
          Text(
            "Order Items".tr,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Dimesion.width5),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.orderData.orderItem!.length,
            itemBuilder: (_, index) {
              OrderItem orderItem = widget.orderData.orderItem![index];
              return InkWell(
                onTap:
                    () => {
                      /*Get.toNamed(RouteHelper.product_detail,
                          arguments: ProductDetailScreen(
                            id: 1, data: null,
                          ))*/
                    },
                child: OrderItemWidget(orderItem: orderItem),
              );
            },
          ),
          SizedBox(height: Dimesion.width5),

          // Visibility(
          //   visible: isPayment,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Payment Type".tr,
          //         style: context.titleSmall.copyWith(
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       SizedBox(height: Dimesion.width5),
          //       if (widget.orderData.payment != null)
          //         SelectPaymentWidget(paymentData: widget.orderData.payment!),
          //       SizedBox(height: Dimesion.width5),
          //       if (widget.orderData.payment != null)
          //         OrderImageWidget(
          //           imgUrl: widget.orderData.paymentPhoto.toString(),
          //           title: "Order Slip",
          //         ),
          //     ],
          //   ),
          // ),
          // if (isPayment == false && widget.orderData.payment == null)
          //   RowTextWidget(title: "Payment Type".tr, val: "Cash On Delivery"),
          Divider(color: Colors.grey[300]),
          RowTextWidget(title: "Name", val: widget.orderData.name ?? ""),
          RowTextWidget(
            title: "Phone Number",
            val: widget.orderData.phone ?? "",
          ),
          RowTextWidget(title: "Address", val: "${widget.orderData.address}"),
          Divider(color: Colors.grey[300]),
          RowTextWidget(
            title: "Sub Total",
            val:
                "${DataConstant.priceFormat.format(int.parse(widget.orderData.subTotal.toString()))} MMK",
          ),
          // RowTextWidget(
          //   title: "Delivery Fees",
          //   val:
          //       "${DataConstant.priceFormat.format(int.parse(widget.orderData.deliveryFee.toString()))} MMK",
          // ),
          RowTextWidget(
            title: "Grand Total",
            val:
                "${DataConstant.priceFormat.format(int.parse(widget.orderData.grandTotal.toString()))} MMK",
          ),
        ],
      ),
    );
  }
}

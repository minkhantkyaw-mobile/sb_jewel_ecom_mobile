import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/row_text_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../../services/toast_service.dart';
import 'checkout_widgets/selected_payment_widget.dart';
import 'checkout_widgets/upload_photo_widget.dart';

class PayNowCheckOutScreen extends StatefulWidget {
  /*final String name;
  final String phone;
  final String address;
  final double subTotal;
  final double deliveryFee;
  final PaymentData paymentData;*/
  const PayNowCheckOutScreen({
    super.key,
    /*required this.name,
      required this.phone,
      required this.address,
      required this.subTotal,
      required this.deliveryFee,
      required this.paymentData*/
  });

  @override
  State<PayNowCheckOutScreen> createState() => _PayNowCheckOutScreenState();
}

class _PayNowCheckOutScreenState extends State<PayNowCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: true,
        leading: backButton(color: Colors.white),
        title: Text(
          "Confirm Payment".tr,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.primaryClr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimesion.height10),
            Text(
              "Upload Screenshot of Payment Transaction".tr,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: Dimesion.height10),
            const CheckOutUploadPhotoWidget(),
            SizedBox(height: Dimesion.height10),
            Text(
              "Note: Please upload the screenshot of your payment transaction to confirm your payment."
                  .tr
                  .tr,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: Dimesion.width5),
            // SelectPaymentWidget(orderData: widget.o,),
            const Divider(),
            RowTextWidget(title: "Name", val: "PaymentName"),
            RowTextWidget(title: "Phone Number", val: "0987654321"),
            RowTextWidget(title: "Address", val: "Address"),
            const Divider(),
            RowTextWidget(
              title: "Sub Total",
              val: "${DataConstant.priceFormat.format(1000)} KS",
            ),
            RowTextWidget(
              title: "Delivery Fees",
              val: "${DataConstant.priceFormat.format(1000)} KS",
            ),
            /*RowTextWidget(
                title: "Grand Total",
                val:
                    "${DataConstant.priceFormat.format(widget.subTotal + widget.deliveryFee)} KS"),*/
            RowTextWidget(
              title: "Grand Total",
              val: "${DataConstant.priceFormat.format(1000)} KS",
            ),
            const Spacer(),
            AppButtonWidget(
              color: AppColor.primaryClr,
              title: Text(
                "Order Now".tr,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
              onTap: () {
                CheckOutController controller = Get.find<CheckOutController>();
                if (controller.pickedImagePath == null) {
                  ToastService.errorToast("Please upload payment screenshot");
                } else {
                  //controller.postOrder(isCod: false);
                }
              },
              minWidth: Dimesion.screeWidth,
              height: Dimesion.height40 * 1.1,
              borderRadius: Dimesion.radius20,
            ),
            SizedBox(height: Dimesion.height40),
          ],
        ),
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

import '../../controllers/checkout_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/app_widgets/my_text_filed.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../../models/payment_model.dart';
import '../../services/toast_service.dart';
import 'checkout_widgets/confirm_item_widget.dart';
import 'checkout_widgets/payment_sheet.dart';

class ConfirmCheckoutScreen extends StatefulWidget {
  final bool isCod;
  const ConfirmCheckoutScreen({super.key, required this.isCod});

  @override
  State<ConfirmCheckoutScreen> createState() => _ConfirmCheckoutScreenState();
}

class _ConfirmCheckoutScreenState extends State<ConfirmCheckoutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CheckOutController controller = Get.find<CheckOutController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.pickedImagePath = null;

      controller.getPayments();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
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
              "Confirm CheckOut".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimesion.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Obx(
            () => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimesion.width5),
                      Text(
                        "Name".tr,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Phone Number".tr,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Address".tr,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: Dimesion.width5),
                      if (controller.paymentList.length != 0 &&
                          widget.isCod == false)
                        Container(
                          width: Dimesion.screeWidth,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.paymentList.length,
                            itemBuilder:
                                (
                                  _,
                                  index,
                                ) => RadioListTile<PaymentData>.adaptive(
                                  value: controller.paymentList[index],
                                  groupValue: controller.selectedPayment.value,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val != null) {
                                        controller.onSelectPayment(val);
                                      }
                                    });
                                  },
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      MyCacheImg(
                                        url:
                                            controller
                                                .paymentList[index]
                                                .paymentLogo
                                                .toString() ??
                                            "",
                                        boxfit: BoxFit.cover,
                                        height: Dimesion.height40,
                                        width: Dimesion.height40,
                                        borderRadius: BorderRadius.circular(
                                          Dimesion.radius15 / 2,
                                        ),
                                      ),
                                      Gap(Dimesion.width5),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                    .paymentList[index]
                                                    .name ??
                                                "",
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                          ),
                                          Text(
                                            controller
                                                    .paymentList[index]
                                                    .number ??
                                                "",
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.labelMedium,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text:
                                                  controller
                                                      .paymentList[index]
                                                      .number
                                                      .toString(),
                                            ),
                                          );
                                          Get.snackbar(
                                            'Copied!',
                                            controller.paymentList[index].number
                                                .toString(),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        },
                                        icon: Icon(Icons.copy),
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                        ),
                      Gap(Dimesion.height10),
                      if (widget.isCod == false) Gap(Dimesion.height30),
                      Container(
                        padding: EdgeInsets.all(Dimesion.width10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${DataConstant.priceFormat.format(controller.totalAmt.value)} MMK"
                                      .tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Delivery Fees".tr,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .titleMedium!
                            //           .copyWith(color: Colors.black),
                            //     ),
                            //     Text("${DataConstant.priceFormat.format(controller.selectedDeliFee.value)} MMK".tr,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .titleMedium!
                            //           .copyWith(color: Colors.black),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Grand Total".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  "${DataConstant.priceFormat.format(controller.totalAmt.value + controller.selectedDeliFee.value)} MMK"
                                      .tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimesion.height15),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AppButtonWidget(
                                color: AppColor.primaryClr,
                                title: Text(
                                  "Submit".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                onTap: () {
                                  controller.postOrder(isCod: widget.isCod);
                                },
                                minWidth: Dimesion.screeWidth,
                                height: Dimesion.height40 * 1.1,
                              ),
                            ),
                            Gap(Dimesion.height30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

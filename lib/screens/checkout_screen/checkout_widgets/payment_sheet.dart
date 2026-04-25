import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../controllers/checkout_controller.dart';
import '../../../core/app_data.dart';
import '../../../core/app_widgets/app_button.dart';
import '../../../core/app_widgets/custom_loading_widget.dart';
import '../../../core/app_widgets/my_cache_img.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/payment_model.dart';
import '../../../router/route_helper.dart';
import '../../../services/toast_service.dart';
import '../../chat_screen/widgets/cached_image_widget.dart';
import '../pay_now_check_out_screen.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({super.key});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  final CheckOutController checkOutController = Get.find<CheckOutController>();
  String? _selectedPaymentMethod;
  String? payment_id="";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkOutController.pickedImagePath = null;
      payment_id="";
      checkOutController.getPayments();
    });
    super.initState();
  }

  Widget _buildPaymentCheckOption({required String imagePath, required PaymentData data}) {
    final isSelected = _selectedPaymentMethod == data.paymentType;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkOutController.onSelectPayment(data);
          _selectedPaymentMethod = data.paymentType;
          payment_id=data.id.toString();
        });
      },
      child: Container(
          margin: EdgeInsets.only(right: 6,bottom: 6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyCacheImg(
                url:
                data.paymentLogo
                    .toString() ??
                    "",
                boxfit: BoxFit.contain,
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
                    data.name ??
                        "",
                    style:
                    Theme.of(
                      context,
                    ).textTheme.titleMedium,
                  ),
                  Text(
                    data.number ??
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
                      data.number
                          .toString(),
                    ),
                  );
                  ToastService.successToast('Copied!'+data.number
                      .toString(),
                      );
                },
                icon: Icon(Icons.copy),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(builder: (controller){
      return Obx(()=>checkOutController.paymentList.length!=0?
      Container(
        padding: EdgeInsets.all(15),
        width: Dimesion.screeWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Payment Method".tr,
                  style: TextStyle(color: AppColor.black,fontSize: Dimesion.font14-2,fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel".tr,
                    style: TextStyle(color: Colors.red,fontSize: Dimesion.font14-2,fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: Dimesion.height15),
            Obx(()=>Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.paymentList.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  PaymentData payment=controller.paymentList[index];
                  return _buildPaymentCheckOption(
                    imagePath: payment.paymentLogo.toString(), // Replace with your asset
                    data: payment,
                  );
                },
              ),
            )),
            Gap(17),
            Text("Please upload your payment screenshoot".tr,
              style: TextStyle(color: AppColor.black,fontSize: Dimesion.font14-2,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Dimesion.height10),
            InkWell(
              onTap: () {
                setState(() {
                  controller.pickImage();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimesion.radius15 / 2,
                  ),
                  border: Border.all(
                    color: Colors.grey.shade100,
                    width: 1,
                  ),
                  color: Colors.grey.shade100,
                ),
                child:
                controller.pickedImagePath == null
                    ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),
                  child: Container(
                    height: Dimesion.screenHeight / 4,
                    width: Dimesion.screeWidth,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text("Click here image upload".tr),
                        Icon(
                          Icons
                              .add_photo_alternate_outlined,
                          size: Dimesion.iconSize25 + 17,
                        ),
                      ],
                    ),
                  ),
                )
                    : DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimesion.radius15 / 2,
                    ),
                    child: Stack(
                      children: [
                        Image.file(
                          controller.pickedImagePath!,
                          fit: BoxFit.cover,
                          height: Dimesion.screenHeight / 4,
                          width: Dimesion.screeWidth,
                        ),
                        Positioned(
                          right: 1,
                          child: IconButton(
                            onPressed: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder:
                                    (context) => Scaffold(
                                  body: Container(
                                    color:
                                    AppColor
                                        .black,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,
                                      children: [
                                        Gap(
                                          Dimesion
                                              .height15,
                                        ),

                                        Flexible(
                                          child: Image.file(
                                            controller
                                                .pickedImagePath!,
                                            alignment:
                                            Alignment
                                                .center,
                                          ),
                                        ),
                                        Gap(
                                          Dimesion
                                              .height15,
                                        ),
                                        Container(
                                          height:
                                          Dimesion
                                              .height40 +
                                              8,
                                          child: AppButtonWidget(
                                            title: Text("OK".tr,
                                              style: TextStyle(
                                                color:
                                                Colors.white,
                                                fontSize:
                                                Dimesion.font16,
                                              ),
                                            ),
                                            minWidth:
                                            Dimesion
                                                .screeWidth,
                                            height:
                                            Dimesion
                                                .height40,
                                            color:
                                            AppColor
                                                .primaryClr,
                                            onTap: () {
                                              Navigator.pop(
                                                context,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(CupertinoIcons.eye),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimesion.height10),
            AppButtonWidget(
              color: AppColor.bottomColor,
              title: Text("Done".tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  controller.validatePayNowForConfirmCheckout();
                });
              },
              minWidth: Dimesion.screeWidth,
              height: Dimesion.height40 * 1.1,
              borderRadius: Dimesion.radius10,
            ),
            SizedBox(height: Dimesion.height30),
          ],
        ),
      ):Container());
    });
  }
}

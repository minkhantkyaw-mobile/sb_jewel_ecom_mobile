import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../../../controllers/checkout_controller.dart';
import '../../../core/app_data.dart';
import '../../../core/app_widgets/my_cache_img.dart';
import '../../../core/constants/dimesions.dart';

class SelectDeliveryWidget extends StatelessWidget {
  final CheckOutController controller;
  const SelectDeliveryWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    /*return Container(
      padding: EdgeInsets.all(Dimesion.width5),
      child: Obx(() => controller.deliState.value==DeliveryState.empty || controller.deliveryList.isEmpty?
      Container(
        height: 150,
        child: Center(
          child: LottieBuilder.asset("assets/lottie/empty.json",
              height: Dimesion.screenHeight * 0.2,
              width: Dimesion.screeWidth * 0.5),
        ),
      ):SizedBox(
        height: Dimesion.screenHeight * 0.2,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: controller.deliveryList.length,
            itemBuilder: (context, index) => Obx(
                  () => RadioListTile<String>.adaptive(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyCacheImg(
                          height: Dimesion.screenHeight * 0.05,
                          width: Dimesion.screeWidth * 0.2,
                          url:
                          controller.deliveryList[index].logo ?? "",
                          boxfit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(
                              Dimesion.radius15 / 2)),
                      SizedBox(
                        width: Dimesion.width5,
                      ),
                      Text(
                        controller.deliveryList[index].name ?? "",
                        style: context.titleSmall
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  value: controller.deliveryList[index],
                  groupValue: controller.selectedDelivery.value,
                  onChanged: (String? val) =>
                      controller.onChangeDelivery(val!)),
            )),
      )
      ),
    );*/
    return Container(
      padding: EdgeInsets.all(Dimesion.width5),
      child: SizedBox(
        height: Dimesion.screenHeight * 0.2,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder:
              (context, index) => RadioListTile<String>.adaptive(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyCacheImg(
                      height: Dimesion.screenHeight * 0.05,
                      width: Dimesion.screeWidth * 0.2,
                      url: AppPngs.testNetworkDeliImg ?? "",
                      boxfit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(
                        Dimesion.radius15 / 2,
                      ),
                    ),
                    SizedBox(width: Dimesion.width5),
                    Text(
                      "DeliveryName".tr ?? "",
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                value: "",
                groupValue: "",
                onChanged: (String? val) => {},
              ),
        ),
      ),
    );
  }
}

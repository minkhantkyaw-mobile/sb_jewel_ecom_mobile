import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../../router/route_helper.dart';
import '../constants/app_color.dart';
import '../constants/dimesions.dart';
import 'app_button.dart';

class NoLoginWidget extends StatelessWidget {
  const NoLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*LottieBuilder.asset(
            "assets/lottie/sleep_panda.json",
            height: Dimesion.screenHeight * 0.3,
          ),*/
          Text(
            "Looks like you are not logged in yet.".tr,
            style: context.titleSmall,
          ),
          SizedBox(height: Dimesion.height10),
          AppButtonWidget(
            color: AppColor.primaryClr,
            title: Text(
              "Go to login".tr,
              style: context.titleSmall.copyWith(color: Colors.white),
            ),
            onTap: () => Get.toNamed(RouteHelper.login),
            borderRadius: Dimesion.radius15 / 2,
            minWidth: Dimesion.screeWidth * 0.5,
          ),
        ],
      ),
    );
  }
}

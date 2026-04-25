import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../constants/app_color.dart';
import '../constants/dimesions.dart';
import 'app_button.dart';

class EmptyViewWidget extends StatelessWidget {
  final void Function()? refresh;
  const EmptyViewWidget({super.key, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Dimesion.screenHeight * 0.4,
        child: Column(
          children: [
            LottieBuilder.asset(
              "assets/lottie/empty.json",
              height: Dimesion.screenHeight * 0.2,
              fit: BoxFit.contain,
            ),
            refresh == null
                ? Text("No Data Found".tr, style: context.titleSmall)
                : AppButtonWidget(
                  color: Colors.transparent,
                  title: Column(
                    children: [
                      Icon(
                        Icons.refresh,
                        color: AppColor.primaryClr,
                        size: Dimesion.iconSize16,
                      ),
                      Text(
                        "Refresh".tr,
                        style: context.titleSmall.copyWith(
                          color: AppColor.primaryClr,
                        ),
                      ),
                    ],
                  ),
                  onTap: refresh ?? () {},
                  borderRadius: 0,
                  minWidth: Dimesion.screeWidth * 0.3,
                ),
          ],
        ),
      ),
    );
  }
}

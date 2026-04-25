import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../../../controllers/checkout_controller.dart';
import '../../../core/app_widgets/row_text_widget.dart';
import '../../../core/constants/data_constant.dart';
import '../../../core/constants/dimesions.dart';

class SummerizeOrderInfoWidget extends GetView<CheckOutController> {
  const SummerizeOrderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowTextWidget(
          title: "Delivery Fees".tr,
          val: "${DataConstant.priceFormat.format(1000 ?? 0)} MMK",
        ),
        SizedBox(height: Dimesion.width5),
        RowTextWidget(title: "Remark".tr, val: "remark" ?? "--"),
        SizedBox(height: Dimesion.width5),
        "0" == "0"
            ? Text(
              "* Cash on delivery service not avaliable in this region .".tr,
              style: context.labelMedium.copyWith(color: Colors.red),
            )
            : SizedBox.shrink(),
      ],
    );
  }
}

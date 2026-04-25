import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/color_ext.dart';

import '../../../core/app_widgets/my_cache_img.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/dimesions.dart';

class ConfirmItemWIdget extends StatelessWidget {
  final String imgUrl;
  final List<String> variables;
  final String unitPrice;
  final String quantity;
  const ConfirmItemWIdget({
    super.key,
    required this.imgUrl,
    required this.variables,
    required this.unitPrice,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimesion.width5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          MyCacheImg(
            height: Dimesion.height40 * 2,
            width: Dimesion.height40 * 2,
            url: imgUrl,
            boxfit: BoxFit.contain,
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
          ),
          SizedBox(width: Dimesion.width10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name".tr,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: Dimesion.width5),
                Text(
                  "$unitPrice x $quantity".tr,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: AppColor.primaryClr),
                ),
                SizedBox(height: Dimesion.width5),
                Row(
                  children: [
                    ...List.generate(variables.length, (i) {
                      if (variables[i].toString().startsWith("#")) {
                        return CircleAvatar(
                          backgroundColor: variables[i].toColor(),
                          radius: Dimesion.radius15 * 0.5,
                        );
                      } else {
                        return Container(
                          margin:
                              (i == 0)
                                  ? EdgeInsets.only(right: Dimesion.width5)
                                  : EdgeInsets.only(left: Dimesion.width5),
                          child: Text(
                            variables[i].toString(),
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: AppColor.primaryClr),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

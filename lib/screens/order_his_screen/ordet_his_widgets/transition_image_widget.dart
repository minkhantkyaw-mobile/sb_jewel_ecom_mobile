import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../../../core/app_data.dart';
import '../../../core/app_widgets/my_cache_img.dart';
import '../../../core/app_widgets/underline_text_button.dart';
import '../../../core/app_widgets/view_image_screen.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/dimesions.dart';

class OrderImageWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  const OrderImageWidget({
    super.key,
    required this.imgUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimesion.width5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Dimesion.width5),
          // Image.network(imgUrl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyCacheImg(
                url: imgUrl,
                boxfit: BoxFit.cover,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                height: Dimesion.height40 + 30,
                width: Dimesion.height40 + 30,
              ),
              SizedBox(width: Dimesion.width5),
              UnderLineTextButton(
                color: AppColor.primaryClr,
                title: "View Image",
                ontap: () => Get.to(() => ViewImagePage(imgUrl: imgUrl)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';

class ShopSliderWidget extends StatelessWidget {
  final ProductController controller;
  const ShopSliderWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>controller.bannerList.length!=0?
    Container(
      width: Dimesion.screeWidth,
      height: Dimesion.screenHeight/5.6,
      child: CarouselSlider(
        options: CarouselOptions(autoPlay: true,),
        items: controller.bannerList
            .map((item) => Container(
          margin: EdgeInsets.only(left: Dimesion.width5,right: Dimesion.width5),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(Dimesion.width10)
          ),
          child: MyCacheImg(url: item.image.toString(), boxfit: BoxFit.cover, borderRadius: BorderRadius.circular(Dimesion.radius5)),
        ))
            .toList(),
      ),
    ):Container());
  }
}

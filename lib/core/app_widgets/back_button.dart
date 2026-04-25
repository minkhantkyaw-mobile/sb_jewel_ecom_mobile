import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_color.dart';
import '../constants/dimesions.dart';

Widget backButton({Color? color}) => Container(
  padding: EdgeInsets.only(
    top: Dimesion.height15,
    bottom: Dimesion.height15,
    left: Dimesion.width10,
    right: Dimesion.width5,
  ),
  child: Container(
    decoration: BoxDecoration(
      color: AppColor.blackless,
      borderRadius: BorderRadius.circular(Dimesion.radius10),
    ),
    child: IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.white,
        size: Dimesion.iconSize16,
      ),
      onPressed: () {
        Get.back();
      },
    ),
  ),
);

Widget backButtonBlack({Color? color}) => Container(
  padding: EdgeInsets.only(
    top: Dimesion.height15,
    bottom: Dimesion.height15,
    right: Dimesion.width5,
  ),
  child: Container(
    decoration: BoxDecoration(
      //color: Color(0xFFFAB83E),
      borderRadius: BorderRadius.circular(Dimesion.radius5),
    ),
    child: IconButton(
      icon: Icon(
        Icons.arrow_circle_left_rounded,
        color: Colors.white,
        size: Dimesion.iconSize25,
      ),
      onPressed: () {
        Get.back();
      },
    ),
  ),
);

import 'package:get/get.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';

Widget menuListTitle({
  required String text,
  required String subText,
  required String imgAsset,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(color: AppColor.bgColor),
      child: ListTile(
        leading: Container(
          height: Dimesion.height20 * 2,
          padding: EdgeInsets.only(right: Dimesion.height10 + 2),
          child: Image.asset(
            imgAsset,
            width: Dimesion.iconSize25,
            height: Dimesion.iconSize25,
            color: AppColor.primaryClr,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: AppColor.black,
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.normal,
          ),
        ),
        // subtitle: Text("Intermediate".tr, style: TextStyle(color: Colors.white)),
        subtitle: Row(
          children: <Widget>[
            Icon(
              Icons.circle,
              color: AppColor.primaryClr,
              size: Dimesion.iconSize16 - 11,
            ),
            Gap(Dimesion.width5),
            Text(
              subText,
              style: TextStyle(
                color: AppColor.blackless,
                fontSize: Dimesion.font12 - 1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: AppColor.primaryClr,
          size: Dimesion.iconSize25,
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../../../controllers/checkout_controller.dart';
import '../../../core/constants/dimesions.dart';


class CheckOutUploadPhotoWidget extends GetView<CheckOutController> {
  const CheckOutUploadPhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /*return GetBuilder<CheckOutController>(
      builder: (controller) => badges.Badge(
        badgeStyle: const badges.BadgeStyle(badgeColor: Colors.transparent),
        badgeContent: controller.pickedImagePath != null
            ? InkWell(
                onTap: () => controller.onClearImage(),
                child: Icon(
                  Icons.remove_circle_outlined,
                  color: Colors.red,
                  size: Dimesion.iconSize16 * 1.2,
                ),
              )
            : SizedBox.shrink(),
        child: Container(
            height: Dimesion.screenHeight * 0.3,
            width: Dimesion.screeWidth,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
            child: controller.pickedImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                    child: Image.file(controller.pickedImagePath!,
                        fit: BoxFit.cover))
                : IconButton(
                    icon: Icon(
                      Icons.cloud_upload,
                      color: Colors.black,
                      size: Dimesion.iconSize16,
                    ),
                    onPressed: () {
                      controller.pickImage();
                    },
                  )),
      ),
    );*/
    return GetBuilder<CheckOutController>(
      builder: (controller) => badges.Badge(
        badgeStyle: const badges.BadgeStyle(badgeColor: Colors.transparent),
        badgeContent: InkWell(
          onTap: () => controller.onClearImage(),
          child: Icon(
            Icons.remove_circle_outlined,
            color: Colors.red,
            size: Dimesion.iconSize16 * 1.2,
          ),
        ),
        child: Container(
            height: Dimesion.screenHeight * 0.3,
            width: Dimesion.screeWidth,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
            child: controller.pickedImagePath != null
                ? ClipRRect(
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                child: Image.file(controller.pickedImagePath!,
                    fit: BoxFit.cover))
                : IconButton(
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.black,
                size: Dimesion.iconSize16,
              ),
              onPressed: () {
                controller.pickImage();
              },
            )),
      ),
    );
  }
}

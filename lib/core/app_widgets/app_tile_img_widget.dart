import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../constants/app_color.dart';
import '../constants/dimesions.dart';
import 'app_delete_button.dart';
import 'my_cache_img.dart';

class AppTileImgWidget extends StatelessWidget {
  final String? img;
  final String title;
  final String? subTitle;
  final double? width;
  final void Function()? onDelete;
  final void Function()? onTap;
  final int index;
  final BoxFit? boxFit;
  final double? height;
  final bool? showDelete;
  final int? active;
  final bool? hideIndex;

  const AppTileImgWidget({
    super.key,
    required this.img,
    required this.title,
    this.onDelete,
    this.index = 0,
    this.width,
    this.boxFit,
    this.height,
    this.showDelete,
    this.subTitle,
    this.onTap,
    this.active,
    this.hideIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
      ),
      tileColor: Colors.grey.shade100,
      onTap: onTap,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          hideIndex ?? false
              ? SizedBox.shrink()
              : SizedBox(
                width: Dimesion.width30,
                child: Text(
                  "${index + 1} .".tr,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          hideIndex ?? false
              ? SizedBox.shrink()
              : SizedBox(width: Dimesion.width5),
          img == null
              ? Icon(
                Icons.person,
                size: Dimesion.iconSize25,
                color: AppColor.primaryClr,
              )
              : MyCacheImg(
                width: width ?? Dimesion.screeWidth * 0.4,
                height: height ?? Dimesion.height40 * 1.5,
                url: img!,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                boxfit: boxFit ?? BoxFit.cover,
              ),
        ],
      ),
      title: Text(
        title,
        style: context.titleSmall.copyWith(
          color: subTitle != null ? AppColor.primaryClr : Colors.black,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle:
          subTitle != null
              ? Text(
                subTitle!,
                style: context.titleSmall.copyWith(color: Colors.grey),
              )
              : null,
      trailing:
          active != null
              ? Text(
                active == 1 ? "Active" : "Inactive",
                style: context.labelSmall.copyWith(
                  color: active == 1 ? Colors.green : Colors.red,
                ),
              )
              : showDelete ?? false
              ? AppDeleteButton(onTap: onDelete)
              : SizedBox.shrink(),
    );
  }
}

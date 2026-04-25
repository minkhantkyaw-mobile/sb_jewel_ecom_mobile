import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../constants/dimesions.dart';
import 'app_delete_button.dart';

class AppTileTextWidget extends StatelessWidget {
  final String title;

  final void Function()? onDelete;
  final void Function()? onTap;
  final int index;

  final bool? showDelete;
  const AppTileTextWidget({
    super.key,
    required this.title,
    this.onDelete,
    this.index = 0,
    this.showDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
      ),
      tileColor: Colors.grey.shade100,
      onTap: onTap,
      leading: SizedBox(
        width: Dimesion.width30,
        child: Text(
          "${index + 1} .".tr,
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        title,
        style: context.titleSmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing:
          showDelete ?? false
              ? AppDeleteButton(onTap: onDelete)
              : SizedBox.shrink(),
    );
  }
}

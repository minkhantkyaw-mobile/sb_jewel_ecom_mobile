import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_color.dart';
import '../core/constants/dimesions.dart';

class DialogService {
  static void showDialog({
    required String message,
    required DialogType dialogType,
    required BuildContext context,
    void Function()? onContinue,
    required bool isDelete,
  }) {
    IconData? willUseIcon;
    Color? willUseColor;
    if (dialogType == DialogType.success) {
      willUseIcon = Icons.check_circle;
      willUseColor = Colors.green;
    } else if (dialogType == DialogType.error) {
      willUseIcon = Icons.error;
      willUseColor = Colors.red;
    } else if (dialogType == DialogType.warning) {
      willUseIcon = Icons.warning;
      willUseColor = Colors.amber;
    } else if (dialogType == DialogType.info) {
      willUseIcon = Icons.info;
      willUseColor = Colors.blue;
    }

    Get.dialog(
      AlertDialog.adaptive(
        scrollable: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title: Icon(willUseIcon, color: willUseColor),
        contentPadding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        content: Container(
          height: Dimesion.height40,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: Dimesion.height10 / 2),
          child: Text(
            message,
            style: context.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          isDelete
              ? TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Close',
                  style: context.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryClr,
                  ),
                ),
              )
              : TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Close',
                  style: context.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        dialogType == DialogType.error
                            ? Colors.grey
                            : Colors.red,
                  ),
                ),
              ),
          isDelete
              ? TextButton(
                onPressed: onContinue,
                child: Text(
                  'Continue',
                  style: context.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              )
              : onContinue != null
              ? TextButton(
                onPressed: onContinue,
                child: Text(
                  'Continue',
                  style: context.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryClr,
                  ),
                ),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

enum DialogType { success, error, warning, info }

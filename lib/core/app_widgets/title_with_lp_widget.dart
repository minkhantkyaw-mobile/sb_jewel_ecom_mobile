import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import '../constants/app_color.dart';
import '../constants/dimesions.dart';

class TitleWithLeftPaddingWidget extends StatelessWidget {
  final String title;
  const TitleWithLeftPaddingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimesion.width5),
      padding: EdgeInsets.only(left: Dimesion.width5),
      child: Text(
        title,
        style: context.titleSmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColor.primaryClr,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_color.dart';
import '../constants/dimesions.dart';

class AppLoadingWidget extends StatelessWidget {
  final Color? color;
  const AppLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitFadingCube(
      color: color ?? AppColor.primaryClr,
      size: Dimesion.iconSize16,
      duration: const Duration(milliseconds: 800),
    ));
  }
}

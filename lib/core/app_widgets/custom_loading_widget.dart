import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/dimesions.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimesion.height10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
      child: CupertinoActivityIndicator(
        radius: Dimesion.radius10-1,
        color: Colors.grey[100],
        animating: true,
      ),
    );
  }
}

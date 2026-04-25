import 'package:flutter/material.dart';

import '../constants/dimesions.dart';

class AppDeleteButton extends StatelessWidget {
  final void Function()? onTap;
  const AppDeleteButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          Icons.delete,
          color: Colors.red,
          size: Dimesion.iconSize16,
        ));
  }
}

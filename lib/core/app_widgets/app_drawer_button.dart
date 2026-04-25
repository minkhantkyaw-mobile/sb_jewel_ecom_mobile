import 'package:flutter/material.dart';

import '../constants/dimesions.dart';

class AppDrawerButton extends StatelessWidget {
  final void Function()? onPress;
  const AppDrawerButton({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        Icons.menu,
        color: Colors.white,
        size: Dimesion.iconSize16,
      ),
    );
  }
}

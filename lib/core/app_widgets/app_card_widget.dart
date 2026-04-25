import 'package:flutter/material.dart';

import '../constants/dimesions.dart';

class AppCardWidget extends StatelessWidget {
  final Widget child;
  const AppCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
      child: child,
    );
  }
}

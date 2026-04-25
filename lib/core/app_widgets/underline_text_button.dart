import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

class UnderLineTextButton extends StatelessWidget {
  final String title;
  final void Function() ontap;
  final Color? color;
  const UnderLineTextButton({
    super.key,
    required this.title,
    required this.ontap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontap,
      child: Text(
        title,
        style: context.titleSmall.copyWith(
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(offset: const Offset(0, -5), color: color ?? Colors.white),
          ],
          decorationColor: color,
        ),
      ),
    );
  }
}

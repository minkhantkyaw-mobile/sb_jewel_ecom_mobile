import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/dimesions.dart';


class ColorWidget extends StatelessWidget {
  //final Variation variations;
  final int? selectedColorIndex;
  final List<String>? avaliableVariables;
  final void Function(int index) onSelectColor;
  final String selectedValue;

  const ColorWidget(
      {super.key,
      this.selectedColorIndex,
      this.avaliableVariables,
      required this.selectedValue,
      required this.onSelectColor});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Color',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
        Wrap(
          spacing: Dimesion.width5,
          children: List.generate(4, (index) {
            return InkWell(
              onTap: () => onSelectColor(index),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColorIndex == index
                        ? AppColor.primaryClr
                        : Colors.transparent),
                child: CircleAvatar(
                  backgroundColor: AppColor.primaryClr,
                  radius: Dimesion.radius15 / 1.1,
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
      ],
    );
  }
}


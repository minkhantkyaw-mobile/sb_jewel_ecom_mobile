import 'package:flutter/material.dart';

import '../../../core/constants/dimesions.dart';

class FirstRow extends StatelessWidget {
  final String name;
  final String unit;
  final Widget price;
  const FirstRow(
      {super.key, required this.name, required this.unit, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: Dimesion.screeWidth * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  unit,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            )),
        price
      ],
    );
  }
}

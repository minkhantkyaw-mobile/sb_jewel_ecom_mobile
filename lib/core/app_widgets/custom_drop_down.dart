import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spjewellery/core/constants/app_color.dart';
import 'package:spjewellery/models/township_cod_model.dart';

import '../../models/deli_fee_model.dart';
import '../../models/region_model.dart';
import '../../models/township_model.dart';
import '../constants/dimesions.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String hintText;
  final RegionData? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.grey, width: 0.4),
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedValue,
          dropdownColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: items.length != 0 ? Colors.black : AppColor.bgColor,
          ),
          hint: Text(hintText, style: TextStyle(fontSize: Dimesion.font14)),
        ),
      ),
    );
  }
}

class CustomDropdownTownShip extends StatelessWidget {
  const CustomDropdownTownShip({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String hintText;
  final TownShipCodData? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.grey, width: 0.4),
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedValue,
          dropdownColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
          hint: Text(hintText, style: TextStyle(fontSize: Dimesion.font14)),
        ),
      ),
    );
  }
}

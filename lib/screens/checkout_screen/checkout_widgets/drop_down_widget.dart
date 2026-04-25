import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/deli_fee_model.dart';
import '../../../models/region_model.dart';

class DropDownWidget extends StatelessWidget {
  final String title;
  final String hint;
  final List<DeliveryFeeData>? townshipList;
  final List<RegionData>? regionList;
  final Function(RegionData?)? onChangedRegion;
  final Function(DeliveryFeeData?)? onChangedTownship;
  final void Function()? onTapTownShip;

  const DropDownWidget(
      {super.key,
      required this.title,
      required this.hint,
      this.regionList,
      this.townshipList,
      this.onTapTownShip,
      this.onChangedRegion,
      this.onChangedTownship});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: Dimesion.width5,
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!,
      ),
      Container(
        margin: EdgeInsets.only(top: Dimesion.width5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimesion.radius15)),
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: townshipList == null
            ? DropdownButtonFormField(
                hint: Text("Please Select Your Region".tr,style: TextStyle(fontSize: Dimesion.font14)),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey)),
                items: regionList!
                    .map((e) => DropdownMenuItem<RegionData>(
                          value: e,
                          child: Text(e.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColor.black)),
                        ))
                    .toList(),
                onChanged: onChangedRegion)
            : DropdownButtonFormField(
                hint: Text("Please Select Your Township".tr,style: TextStyle(fontSize: Dimesion.font14),),
                onTap: onTapTownShip,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.grey)),
                items: townshipList!
                    .map((e) => DropdownMenuItem<DeliveryFeeData>(
                          value: e,
                          child: Text(e.city ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColor.black)),
                        ))
                    .toList(),
                onChanged: onChangedTownship),
      ),
    ]);
  }
}

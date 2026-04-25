import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spjewellery/screens/nav/brandCategoryPage.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';

class BrandWidget extends StatelessWidget {
  final ProductController controller;

  const BrandWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// Print error in console (if exists)
      if (controller.brandError.isNotEmpty) {
        print("❌ Brand Error: ${controller.brandError.value}");
      }

      /// If error exists, show error message on screen
      if (controller.brandError.isNotEmpty) {
        return Center(
          child: Text(
            "Error: ${controller.brandError.value}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimesion.font14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }

      /// If no error but brand list empty → show no data
      if (controller.brandlist.isEmpty) {
        return Center(
          child: Text(
            "No brands available".tr,
            style: TextStyle(fontSize: Dimesion.font14, color: Colors.grey),
          ),
        );
      }

      /// Show Brand Grid
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimesion.width10),
        child: MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: Dimesion.screenHeight / 45,
          crossAxisSpacing: Dimesion.screeWidth / 17,
          itemCount: controller.brandlist.length,
          itemBuilder: (context, index) {
            final brand = controller.brandlist[index];
            final brandName = brand.name ?? "Unknown";

            return ElevatedButton(
              onPressed: () {
                Get.to(
                  BrandCategoryPage(
                    brandCategoryId: brand.id ?? 0,
                    title: brand.name ?? 'Unknown',
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.bottomBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                brandName,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: AppColor.white,
                    fontSize: Dimesion.font14 - 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

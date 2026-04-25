import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/nav/allpopularproduct.dart';
import 'package:spjewellery/screens/nav/productcard.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../product_detail_screen/product_detail_screen.dart';
import '../search_page.dart';

class PopularProduct extends StatelessWidget {
  final ProductController controller;
  const PopularProduct({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: Dimesion.height15),
        padding: EdgeInsets.all(Dimesion.width10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Products".tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => Allpopularproduct(controller: controller));
                  },

                  child: Row(
                    children: [
                      Text(
                        "All Products",
                        style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                            color: AppColor.blackless,
                            fontSize: Dimesion.font12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 15,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Horizontal list of products
            controller.allPopularProducts.isNotEmpty
                ? SizedBox(
                  height: Dimesion.screenHeight / 3, // adjust height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: controller.allPopularProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.allPopularProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.product_detail,
                            arguments: ProductDetailScreen(
                              data: controller.allPopularProducts[index],
                            ),
                          );

                          // Get.to(() => ProductDetailsPage());
                        },
                        child: Container(
                          width:
                              Dimesion.screeWidth /
                              2, // half screen width per card
                          margin: EdgeInsets.only(right: Dimesion.width10),
                          child: ProductCardWidget(
                            data: product,
                            controller: controller,
                          ),
                        ),
                      );
                    },
                  ),
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/nav/productcard.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../product_detail_screen/product_detail_screen.dart';
import '../search_page.dart';

class AllProductWidget extends StatelessWidget {
  final ProductController controller;
  const AllProductWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: Dimesion.height15),
        padding: EdgeInsets.all(Dimesion.width10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "all_product".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            controller.allProducts.length != 0
                ? Container(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.allProducts.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimesion.screenHeight / 45,
                    // crossAxisSpacing: Dimesion.screeWidth/19,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.product_detail,
                            arguments: ProductDetailScreen(
                              data: controller.allProducts[index],
                            ),
                          );

                          //Get.to(() => ProductDetailsPage());
                        },
                        child: ProductCardWidget(
                          data: controller.allProducts[index],
                          controller: controller,
                        ),
                      );
                    },
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class HorizontalMasonrySingleRow extends StatelessWidget {
  final List<Widget> items;

  const HorizontalMasonrySingleRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            items.map((item) {
              return Container(
                width: Dimesion.screeWidth / 2, // Fixed width per column
                margin: EdgeInsets.all(4),
                child: item,
              );
            }).toList(),
      ),
    );
  }
}

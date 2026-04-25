import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spjewellery/core/app_widgets/back_button.dart';
import 'package:spjewellery/models/product_model.dart';
import 'package:spjewellery/screens/nav/productcard.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../product_detail_screen/product_detail_screen.dart';
import '../search_page.dart';

class NewArrivalAllScreen extends StatelessWidget {
  final List<ProductData> products;
  final ProductController controller;

  const NewArrivalAllScreen({required this.products, required this.controller});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimesion.screenHeight / 10,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: backButtonBlack(),
        centerTitle: true,
        title: Text(
          "Popular Products".tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: Column(
          children: [
            SizedBox(height: Dimesion.height10),

            // 🔍 Search + Filter bar
            InkWell(
              onTap: () {
                Get.toNamed(
                  RouteHelper.search,
                  arguments: SearchPage(
                    datalist: controller.productListBySubCategory,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimesion.width5,
                  horizontal: Dimesion.width10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimesion.width5),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColor.primaryClr,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        CupertinoIcons.search,
                        size: Dimesion.iconSize25,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(width: Dimesion.width10),
                    Expanded(
                      child: Text(
                        "search".tr,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimesion.font16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.filter);
                      },
                      child: Icon(
                        Icons.filter_list_alt,
                        size: Dimesion.iconSize25,
                        color: AppColor.primaryClr,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: Dimesion.height10),

            // 🧱 Product grid
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RouteHelper.product_detail,
                        //arguments: ProductDetailScreen(data: products[index]),
                      );
                    },
                    child: ProductCardWidget(
                      data: products[index],
                      controller: controller,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

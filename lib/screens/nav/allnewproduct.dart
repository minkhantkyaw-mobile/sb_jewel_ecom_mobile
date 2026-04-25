import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:spjewellery/controllers/product_controller.dart';
import 'package:spjewellery/core/constants/app_color.dart';
import 'package:spjewellery/core/constants/dimesions.dart';
import 'package:spjewellery/models/product_model.dart';
import 'package:spjewellery/router/route_helper.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';

class Allnewproduct extends StatelessWidget {
  final ProductController controller;
  const Allnewproduct({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ---------- APP BAR ----------
      appBar: AppBar(
        backgroundColor: AppColor.primaryClr,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "News Arrival",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
          ),
        ],
      ),

      /// ---------- BODY ----------
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(Dimesion.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Grid of products
              controller.allNewProducts.isNotEmpty
                  ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.allNewProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) {
                      final product = controller.allNewProducts[index];
                      return _buildGridItem(product);
                    },
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  /// ----- Product Card -----
  Widget _buildGridItem(ProductData product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RouteHelper.product_detail,
          arguments: ProductDetailScreen(data: product),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image + Heart
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xfffdeff1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                /// product image
                Center(
                  child: SizedBox(
                    height: 120,
                    child: CachedNetworkImage(
                      imageUrl: product.images?.first ?? "",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                /// wishlist button
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      controller.addWishList(id: product.id!.toInt());
                    },
                    child:
                        product.isWishlist == 0
                            ? Icon(
                              CupertinoIcons.heart,
                              size: Dimesion.iconSize16,
                              color: const Color(0xFFDD1504),
                            )
                            : Icon(
                              CupertinoIcons.heart_fill,
                              size: Dimesion.iconSize16,
                              color: const Color(0xFFDD1504),
                            ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// product name
          Text(
            product.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          /// product price
          Text(
            "${product.price} Ks",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

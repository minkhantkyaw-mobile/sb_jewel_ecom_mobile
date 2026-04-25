import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:spjewellery/controllers/product_controller.dart';
import 'package:spjewellery/core/constants/dimesions.dart';
import 'package:spjewellery/models/product_model.dart';
import 'package:spjewellery/router/route_helper.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';

class Allpopularproduct extends StatelessWidget {
  final ProductController controller;
  const Allpopularproduct({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ------------------ APP BAR ------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3A7B8), // Pink header color
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Popular Product",
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

      /// ------------------ BODY ------------------
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(Dimesion.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.allPopularProducts.isNotEmpty
                  ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.allPopularProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final product = controller.allPopularProducts[index];
                      return _buildProductCard(product, controller, index);
                    },
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------------ PRODUCT CARD ------------------
  Widget _buildProductCard(
    ProductData product,
    ProductController controller,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          RouteHelper.product_detail,
          arguments: ProductDetailScreen(data: product),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xfffdeff1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image + Favorite
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(product.images![0], fit: BoxFit.cover),
                  ),
                ),

                /// Heart Icon
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

            const SizedBox(height: 10),

            /// Name
            Text(
              product.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            /// Price
            Row(
              children: [
                Text(
                  "${product.price} Ks",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "${product.price} Ks",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

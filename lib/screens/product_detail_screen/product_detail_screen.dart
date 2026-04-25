import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/controllers/cart_controller.dart';
import 'package:spjewellery/screens/nav/cart.dart';
import 'package:spjewellery/screens/product_detail_screen/image_view_screen.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_body.dart';

import '../../controllers/checkout_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_widgets/back_button.dart';
// import '../../core/app_widgets/my_cache_img.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/cart_model.dart';
import '../../models/order_history_model.dart';
import '../../models/product_model.dart';
import '../../router/route_helper.dart';
import '../../services/cart_save.dart';
import '../../services/toast_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductData data;
  const ProductDetailScreen({super.key, required this.data});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CartController cartController = Get.find();
  final ProductController productController = Get.find();
  final CheckOutController checkOutController = Get.find();

  final GlobalKey<ShakeWidgetState> shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.qty.value = 1;
      cartController.stock.value = widget.data.stock ?? 0;
      cartController.detailQuantity.value = 1;

      /// ONLY fetch if productData not loaded yet
      if (productController.productData.value.id != widget.data.id) {
        productController.getProductDetail(id: widget.data.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: _buildAppBar(),

      body: Obx(() {
        if (productController.isDetailLoading.value ||
            productController.productData.value.id == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = productController.productData.value;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildImageSlider(product),
                  ProductDetailBodyView(data: product),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      }),

      bottomNavigationBar: Obx(() {
        /// Prevent null-crash when loading
        if (productController.isDetailLoading.value ||
            productController.productData.value.id == null) {
          return const SizedBox();
        }

        return _buildBottomBar();
      }),
    );
  }

  // ------------------- APP BAR -------------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.primaryClr,
      title: const Text(
        "Product Details",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      centerTitle: true,
      leading: const BackButton(color: Colors.white),
      actions: [_buildFavoriteButton(), _buildCartButton()],
    );
  }

  Widget _buildFavoriteButton() {
    return Obx(() {
      final pd = productController.productData.value;
      final isFav = productController.favList.any((item) => item.id == pd.id);

      return IconButton(
        icon: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
        onPressed: () {
          if (pd.id != null) {
            productController.addWishList(id: pd.id!);
          }
        },
      );
    });
  }

  Widget _buildCartButton() {
    return ShakeMe(
      key: shakeKey,
      shakeOffset: 10,
      child: Obx(() {
        // final count = cartController.cartList.length;
        final count = cartController.totalQty.value;

        return Stack(
          alignment: Alignment.topRight,
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.cart, color: Colors.white),
              onPressed: () => Get.to(() => CartPage()),
            ),
            if (count > 0)
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  // ------------------- IMAGE SLIDER -------------------
  Widget _buildImageSlider(ProductData data) {
    final images = data.images ?? [];

    if (images.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            size: 80,
            color: Colors.grey.shade400,
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 300,
          child: CarouselSlider.builder(
            itemCount: images.length,
            carouselController: productController.carouselController,
            options: CarouselOptions(
              height: 300,

              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: false,
              onPageChanged: (index, reason) {
                productController.imgIndex.value = index; // update observable
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final imageUrl = images[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => FullScreenImageView(imageUrl: imageUrl));
                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder:
                        (_, __, ___) => Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey.shade400,
                            size: 60,
                          ),
                        ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Only the indicator needs Obx
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  color:
                      productController.imgIndex.value == index
                          ? AppColor.myGreen
                          : Colors.grey.shade300,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ------------------- BOTTOM BAR -------------------
  Widget _buildBottomBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildQuantitySelector()],
        ),
      ),
    );
  } // ------------------- QTY -------------------

  Widget _buildQuantitySelector() {
    return Obx(() {
      final int stock = cartController.stock.value;
      final int qty = cartController.detailQuantity.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Text(
          //   "Quantity",
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          // ),

          // Make the quantity box flexible
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _qtyButton(Icons.remove, () {
                    cartController.changeQuantity(
                      isIncrease: false,
                      maxStock: stock,
                    );
                  }),

                  Expanded(
                    child: Obx(() {
                      return Text(
                        cartController.stock.value == 0
                            ? "0"
                            : cartController.detailQuantity.value.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign:
                            TextAlign.center, // optional, centers the text
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                  ),

                  _qtyButton(Icons.add, () {
                    cartController.changeQuantity(
                      isIncrease: true,
                      maxStock: stock,
                    );
                  }),
                ],
              ),
            ),
          ),

          SizedBox(width: Dimesion.width30),

          // Add to Cart button
          GestureDetector(
            onTap:
                stock == 0
                    ? null
                    : () {
                      final product = productController.productData.value;

                      // Check variation only if product has variations
                      final bool hasVariation =
                          product.sizes != null && product.sizes!.isNotEmpty;

                      if (hasVariation && cartController.sizeId.value == 0) {
                        ToastService.warningToast("Please Select Size");
                        return;
                      }

                      // if (cartController.sizeId.value == 0) {
                      //   ToastService.warningToast("Please Select Size");
                      //   return;
                      // }

                      // final product = productController.productData.value;

                      if (product.id != null) {
                        cartController.addCart(
                          productId: product.id!,
                          isBuyNow: false,
                        );
                      }
                    },
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: stock == 0 ? Colors.grey : AppColor.myRed,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                stock == 0 ? "Unavailable" : "Add to Cart",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColor.primaryClr,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  // ------------------- ADD TO CART -------------------
  Widget _buildAddToCartButton() {
    return GestureDetector(
      onTap: () {
        if (cartController.sizeId.value == 0) {
          ToastService.warningToast("Please Select Size");
          return;
        }

        final product = productController.productData.value;

        if (product.id != null) {
          cartController.addCart(productId: product.id!, isBuyNow: false);
        }
      },
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.myRed),
        ),
        child: const Text(
          "Add to Cart",
          style: TextStyle(
            color: AppColor.myRed,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

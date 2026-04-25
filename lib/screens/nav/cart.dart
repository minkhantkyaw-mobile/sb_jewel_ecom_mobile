import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spjewellery/controllers/cart_controller.dart';
import 'package:spjewellery/core/app_widgets/empty_view.dart';

// import 'package:power_nine/models/product_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timer_snackbar/timer_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/app_widgets/app_button.dart';
import '../../core/app_widgets/no_login_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../../models/cart_model.dart';
import '../../router/route_helper.dart';
import '../../services/cart_save.dart';
import 'nav_controller.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find<CartController>();
  final AuthController authController = Get.find<AuthController>();
  final NavController navController = Get.find<NavController>();

  final CheckOutController checkOutController = Get.find<CheckOutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryClr,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Add to Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => cartController.deleteAllCart(),
            child: const Text(
              "Remove all",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),

      // ========================= BODY ============================
      body: Obx(() {
        if (cartController.cartList.isEmpty) {
          return EmptyViewWidget();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- CART TITLE ----------------
              const Text(
                "Cart Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),

              // ------------ CART ITEM LIST ----------------
              ListView.builder(
                itemCount: cartController.cartList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = cartController.cartList[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        // ---------- IMAGE ----------
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.product!.images![0],
                            width: 90,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // ---------------- DETAILS ----------------
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TITLE + PRICE
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.product!.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${item.product!.price ?? 0} Ks",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              // Size
                              Text(
                                item.size != null ? "${item.size}" : "Size: -",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // QUANTITY ROW
                              Row(
                                children: [
                                  // minus
                                  InkWell(
                                    onTap:
                                        () => cartController.updateCartQuantity(
                                          isIncrease: false,
                                          index: index,
                                          cartId: item.product!.id!,
                                          inc: item.product!.increment_step!,
                                        ),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColor.primaryClr,
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  // Text(
                                  //   "${item.quantity}",
                                  //   style: const TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Obx(
                                    () => Text(
                                      "${cartController.cartQuantityList[index]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  // plus
                                  InkWell(
                                    onTap:
                                        () => cartController.updateCartQuantity(
                                          isIncrease: true,
                                          index: index,
                                          cartId: item.product!.id!,
                                          inc: item.product!.increment_step!,
                                        ),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColor.primaryClr,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // REMOVE BUTTON
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap:
                                      () => cartController.delecteCart(
                                        cartId: item.product!.id!,
                                      ),
                                  child: const Text(
                                    "Remove",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // =============== CART TOTAL CARD ===================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Cart Total",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    totalRow(
                      "Sub Total",
                      "${cartController.subTotal.value} Ks",
                    ),

                    // totalRow(
                    //   "Delivery fees",
                    //   "${cartController.delifee.value} Ks",
                    // ),
                    const Divider(height: 25),

                    totalRow(
                      "Grand Total",
                      // "${cartController.totalAmount.value + cartController.delifee.value} Ks",
                      "${cartController.totalAmount.value} Ks",

                      isBold: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 120),
            ],
          ),
        );
      }),

      // ===================== CHECKOUT BUTTON =====================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Visibility(
          visible: cartController.cartList.isNotEmpty,
          child: ElevatedButton(
            onPressed: () async {
              if (authController.appToken.isNotEmpty) {
                checkOutController.isExchange.value = 0;
                await Get.toNamed(RouteHelper.selectDeliveryScreen);
              } else {
                await Get.toNamed(RouteHelper.login);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryClr,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Continue to Checkout",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget totalRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

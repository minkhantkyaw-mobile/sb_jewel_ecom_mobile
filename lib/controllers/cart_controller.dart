import 'package:bot_toast/bot_toast.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_widgets/custom_loading_widget.dart';
import '../models/cart_api_model.dart';
import '../repository/cart_repo.dart';
import '../router/route_helper.dart';
import '../services/toast_service.dart';
import 'fav_controller.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  @override
  void onInit() {
    loadIfHasToken();
    super.onInit();
  }

  RxInt qty = 1.obs;
  RxInt detailQuantity = 1.obs;
  RxInt stock = 0.obs;

  void changeQuantity({
    required bool isIncrease,
    TextEditingController? quantityController,
    int? manualValue,
    bool clear = false,
    int? maxStock,
    BuildContext? context,
  }) {
    // Clear quantity
    if (clear) {
      quantityController?.clear();
      detailQuantity.value = 1;
      return;
    }

    // Manual input
    if (manualValue != null) {
      if (manualValue < 1) {
        ToastService.warningToast("Quantity must be at least 1");
        return;
      }

      if (maxStock != null && manualValue > maxStock) {
        if (context != null) {
          showDialog(
            context: context,
            builder:
                (ctx) => AlertDialog(
                  title: const Text("Not enough stock"),
                  content: Text("Only $maxStock items available."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                ),
          );
        }
        return;
      }

      detailQuantity.value = manualValue;
      return;
    }
    // Increase
    if (isIncrease) {
      // 🔥 If stock zero → cannot increase
      if (maxStock != null && maxStock == 0) {
        ToastService.warningToast("Out of Stock");
        return;
      }

      // 🔥 Prevent exceeding stock
      if (maxStock != null && detailQuantity.value >= maxStock) {
        ToastService.warningToast("Only $maxStock items available");
        return;
      }

      detailQuantity.value++;
    }
    // Decrease
    else {
      if (detailQuantity.value > 1) {
        detailQuantity.value--;
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
  }

  loadIfHasToken() async {
    var token = await cartRepo.getAppToken();

    if (token.isNotEmpty) {
      // cartRepo.updateHeader(token);
      getCarts(isInitial: true);
    }
  }
  //* For Product Details --------------->

  RxInt sizeId = 0.obs;
  Future<void> addCart({required int productId, required bool isBuyNow}) async {
    var loading = BotToast.showCustomLoading(
      toastBuilder: (_) => const CustomLoadingWidget(),
    );
    try {
      print(
        "Adding product to cart: productId=$productId, quantity=${qty.value}, sizeID=${sizeId.value == 0 ? null : sizeId.value}",
      );

      // Response response = await cartRepo.addCart(
      //   productId: productId,
      //   quantity: detailQuantity.value,
      //   // sizeID: sizeId.value,
      //   sizeID: sizeId.value == 0 ? null : sizeId.value,
      // );
      Response response;
      if (sizeId.value == 0) {
        // Do NOT pass sizeID
        response = await cartRepo.addCart(
          productId: productId,
          quantity: detailQuantity.value,
        );
      } else {
        // Pass sizeID
        response = await cartRepo.addCart(
          productId: productId,
          quantity: detailQuantity.value,
          sizeID: sizeId.value,
        );
      }

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        getCarts(isInitial: true);
        if (isBuyNow == false) {
          ToastService.successToast(response.body["message"]);
        } else {
          Get.toNamed(RouteHelper.selectDeliveryScreen);
        }
      } else {
        print("Add to cart failed: ${response.body}");
        ToastService.errorToast(response.body["message"] ?? "Unknown error");
      }
    } catch (e, stacktrace) {
      print("Exception occurred while adding to cart: $e");
      print("Stacktrace: $stacktrace");
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
  }

  //* Get  Carts  ------------->
  RxList<CartData> cartList = <CartData>[].obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble subTotal = 0.0.obs;

  RxDouble delifee = 0.0.obs;
  RxInt totalQty = 0.obs;
  RxInt totalEarnPoints = 0.obs;
  RxString totalDiscount = "0".obs;

  RxList<int> cartQuantityList = <int>[].obs;
  Future<void> getCarts({required bool isInitial}) async {
    if (!isInitial) {
      BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget(),
      );
    }
    try {
      Response response = await cartRepo.getCarts();

      if (response.statusCode == 200) {
        CartModel cartModel = CartModel.fromJson(response.body);
        cartList.value = cartModel.data!;
        print("CartListLength>>>" + cartList.length.toString());
        cartQuantityList.value = List.generate(
          cartList.length,
          (index) => cartList[index].quantity!,
        );
        int tamt = 0;
        int qty = 0;

        for (var item in cartList) {
          tamt += item.subtotal;
          qty += item.quantity;
        }

        subTotal.value = tamt.toDouble();
        totalAmount.value = cartModel.totalAmount.toDouble();
        totalQty.value = cartModel.totalQuantity;
        totalEarnPoints.value = cartModel.totalPoints;
        totalDiscount.value = cartModel.totalDiscount.toString();
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      debugPrint("Get Cart Error $e");
      //ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  //* Delete Cart --------------->
  Future<void> delecteCart({required int cartId}) async {
    BotToast.showCustomLoading(
      toastBuilder: (_) => const CustomLoadingWidget(),
    );
    try {
      Response response = await cartRepo.deleteCart(cartId: cartId);
      if (response.statusCode == 200) {
        ToastService.successToast(response.body["message"]);
        getCarts(isInitial: false);
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future<void> deleteAllCart() async {
    BotToast.showCustomLoading(
      toastBuilder: (_) => const CustomLoadingWidget(),
    );
    try {
      Response response = await cartRepo.deleteAllCart();
      if (response.statusCode == 200) {
        ToastService.successToast(response.body["message"]);
        getCarts(isInitial: false);
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  //* Update Cart ------------->
  Future<void> updateCart({required int cartId, required int quantity}) async {
    BotToast.showCustomLoading(
      toastBuilder: (_) => const CustomLoadingWidget(),
    );
    FormData formData = FormData({"quantity": quantity});
    print("FormData fields: ${formData.fields}");
    try {
      Response response = await cartRepo.updateCart(
        formData: formData,
        cartId: cartId,
      );
      if (response.statusCode == 200) {
        ToastService.successToast(response.body["message"]);
        getCarts(isInitial: false);
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  //* For Cart --------------->
  updateCartQuantity({
    required bool isIncrease,
    required int index,
    required int cartId,
    required int inc,
  }) {
    if (isIncrease) {
      cartQuantityList[index] = cartQuantityList[index] + inc;
      EasyDebounce.debounce(
        "cart",
        const Duration(seconds: 1),
        () => updateCart(cartId: cartId, quantity: cartQuantityList[index] + 1),
      );
    } else {
      if (cartQuantityList[index] > 1) {
        cartQuantityList[index] = cartQuantityList[index] - inc;
        EasyDebounce.debounce(
          "cart",
          const Duration(seconds: 1),
          () =>
              updateCart(cartId: cartId, quantity: cartQuantityList[index] - 1),
        );
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
  }

  //* For Detail Quantity --------------->
  /*changeQuantity({required bool isIncrease}) {
    if (isIncrease) {
      detailQuantity.value++;
    } else {
      if (detailQuantity.value > 1) {
        detailQuantity.value--;
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
  }*/
}

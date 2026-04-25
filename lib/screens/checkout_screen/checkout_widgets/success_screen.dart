import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:spjewellery/controllers/cart_controller.dart';

import '../../../core/app_widgets/app_button.dart';
import '../../../core/app_widgets/row_text_widget.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/data_constant.dart';
import '../../../core/constants/dimesions.dart';
import '../../../router/route_helper.dart';

// class SuccessScreen extends StatefulWidget {
//   // final List<Cart> cartList;
//   final bool isCod;
//   const SuccessScreen({super.key, required this.isCod});

//   @override
//   State<SuccessScreen> createState() => _SuccessScreenState();
// }

// class _SuccessScreenState extends State<SuccessScreen> {
//   final CheckOutController controller = Get.find<CheckOutController>();
//   final CartController cartController = Get.find<CartController>();
//   final AuthController authController = Get.find<AuthController>();

//   @override
//   void initState() {
//     authController.getUser(isInitial: false);
//     cartController.getCarts(isInitial: false);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: Colors.white,
//       extendBodyBehindAppBar: true,
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             LottieBuilder.asset(
//               "assets/lottie/thank.json",
//               height: Dimesion.screenHeight * 0.4,
//               fit: BoxFit.contain,
//             ),

//             SizedBox(height: Dimesion.height10),
//             RowTextWidget(
//               title: "Order Type",
//               val: widget.isCod ? "Cash on Delivery" : "Online Payment",
//             ),
//             SizedBox(height: Dimesion.width5),
//             if(controller.isExchange.value==1)
//               RowTextWidget(
//                 title: "Exchange Points",
//                 val:controller.exchangePoints.toString()+" Points".tr,
//               ),
//             if(controller.isExchange.value==0)
//               RowTextWidget(
//                 title: "Earned Points",
//                 val:cartController.totalEarnPoints.toString()+" Points".tr,
//               ),
//             RowTextWidget(
//               title: "Delivery Fees".tr,
//               val:
//               "${DataConstant.priceFormat.format(controller.selectedDeliFee.value ?? 0)} Ks",
//             ),
//             if(controller.isExchange.value==0)
//               RowTextWidget(
//                 title: "Discount",
//                 val:cartController.totalDiscount.toString()+" Ks",
//               ),
//             if(controller.isExchange.value==0)
//               RowTextWidget(
//                 title: "Subtotal",
//                 val:"${DataConstant.priceFormat.format(cartController.totalAmount.value ?? 0)} Ks",
//               ),
//             if(controller.isExchange.value==1)
//               RowTextWidget(
//                 title: "Subtotal",
//                 val:controller.exchangePoints.toString()+" Points".tr,
//               ),
//             Divider(),
//             if(controller.isExchange.value==0)
//               RowTextWidget(
//                 title: "Grand Total",
//                 val:"${DataConstant.priceFormat.format(controller.selectedDeliFee.value+cartController.totalAmount.value-int.parse(cartController.totalDiscount.toString()) ?? 0)} Ks",
//               ),
//             if(controller.isExchange.value==1)
//               RowTextWidget(
//                 title: "Grand Total",
//                 val:"${DataConstant.priceFormat.format(controller.selectedDeliFee.value ?? 0)} Ks",
//               ),
//             SizedBox(height: Dimesion.height20),
//             AppButtonWidget(
//               color: AppColor.primaryClr,
//               title: Text("Go to Home".tr,
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleSmall!.copyWith(color: Colors.white),
//               ),
//               onTap: () async {
//                 controller.totalAmt.value = 0;
//                 controller.totalQty.value = 0;
//                 /*notiController.getNotiList();
//                 CheckOutController checkOutController =
//                     Get.find<CheckOutController>();
//                 checkOutController.resetCheckoutSelection();*/
//                 await Get.offNamed(RouteHelper.nav);
//               },
//               minWidth: Dimesion.screeWidth,
//               height: Dimesion.height40 * 1.1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _showSuccessDialog(context);
    });

    return const Scaffold(backgroundColor: Colors.white);
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColor.primaryClr,
                  size: 80,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Order Successful!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your order has been placed successfully.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: AppColor.primaryClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Clear the cart
                      final cartController = Get.find<CartController>();
                      cartController.cartList.clear();

                      // Navigate to main navigation page and remove all previous routes
                      Get.offAllNamed(RouteHelper.nav);
                    },

                    child: const Text(
                      "Back to Home",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

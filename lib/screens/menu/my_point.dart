import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/controllers/auth_controller.dart';
import 'package:spjewellery/controllers/checkout_controller.dart';
import 'package:spjewellery/controllers/product_controller.dart';
import 'package:spjewellery/core/app_widgets/empty_view.dart';
import 'package:spjewellery/models/payment_model.dart';
import 'package:spjewellery/router/route_helper.dart';
import 'package:spjewellery/screens/chat_screen/widgets/cached_image_widget.dart';
import 'package:spjewellery/screens/product_detail_screen/product_exchange_detail_screen.dart';

import 'package:toastification/toastification.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../nav/productcard.dart';
import '../product_detail_screen/product_detail_screen.dart';

class MyPointPage extends StatefulWidget {
  const MyPointPage({super.key});

  @override
  State<MyPointPage> createState() => _MyPointPageState();
}

class _MyPointPageState extends State<MyPointPage> {
  final AuthController authController = Get.find<AuthController>();
  final ProductController productController = Get.find<ProductController>();
  final CheckOutController checkOutController = Get.find<CheckOutController>();

  void _showPointsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the sheet to be taller than half the screen
      backgroundColor:
          Colors.transparent, // Make background transparent for custom shape
      builder: (context) {
        return const PointsBottomSheet();
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getExchangePoint(isLoadmore: true);
      productController.getPointSetting();
      checkOutController.getPayments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: Dimesion.screenHeight / 11,
            leading: backButton(),
            backgroundColor: AppColor.primaryClr,
            centerTitle: true,
            title: Text(
              "Exchange Products".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimesion.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.center,
                  width: Dimesion.screeWidth,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Current Points".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimesion.font14 - 2,
                        ),
                      ),
                      Obx(
                        () => Text(
                          authController.userData.value.currentPointAmount
                                  .toString() +
                              " Points",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimesion.font14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showPointsBottomSheet(context);
                      });
                    },
                    child: Text("Withdraw Money".tr),
                  ),
                ),
                Gap(Dimesion.height10),
                Divider(color: Colors.black12),
                if (controller.exchangeProducts.length != 0)
                  Text(
                    "Exchange Products".tr,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: Dimesion.font14,
                    ),
                  ),
                Gap(Dimesion.height10),
                controller.exchangeProducts.length != 0
                    ? Container(
                      child: MasonryGridView.count(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.exchangeProducts.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: Dimesion.screenHeight / 45,
                        // crossAxisSpacing: Dimesion.screeWidth/19,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.productexchangeDetail,
                                arguments: ProductExchangeDetailScreen(
                                  data: controller.exchangeProducts[index],
                                ),
                              );
                            },
                            child: ProductExchangeCardWidget(
                              data: controller.exchangeProducts[index],
                              controller: controller,
                            ),
                          );
                        },
                      ),
                    )
                    : Container(child: EmptyViewWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PointsBottomSheet extends StatefulWidget {
  const PointsBottomSheet({super.key});

  @override
  State<PointsBottomSheet> createState() => _PointsBottomSheetState();
}

class _PointsBottomSheetState extends State<PointsBottomSheet> {
  String? _selectedPaymentMethod;
  final AuthController authController = Get.find<AuthController>();
  final ProductController productController = Get.find<ProductController>();
  final CheckOutController checkOutController = Get.find<CheckOutController>();
  final TextEditingController pointController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? payment_id = "";
  @override
  void initState() {
    setState(() {
      payment_id = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Withdraw Money',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 48), // To balance the IconButton
                ],
              ),
              SizedBox(height: 16),
              // Title
              SizedBox(height: 8),
              // Current Points Info
              Obx(
                () => Text(
                  'Your current point - ' +
                      authController.userData.value.currentPointAmount
                          .toString() +
                      " Points",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 16),
              // Form Section
              TextFormField(
                controller: pointController,
                decoration: InputDecoration(
                  hintText: "Point Amount".tr,
                  hintStyle: const TextStyle(color: Colors.black45),
                  filled: true,
                  fillColor: const Color(0xFFFAF2C7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),

              SizedBox(height: 8),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    '1 point - ' +
                        "${DataConstant.priceFormat.format(int.parse(productController.pointPerPrice.value.toString() != "null" ? productController.pointPerPrice.value.toString() : "0"))} Ks",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Payment Method Selection
              Text(
                'Choose payment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Obx(
                () => Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: checkOutController.paymentList.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      PaymentData payment =
                          checkOutController.paymentList[index];
                      return _buildPaymentOption(
                        imagePath:
                            payment.paymentLogo
                                .toString(), // Replace with your asset
                        method: payment,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Account Details
              Text(
                'Your Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: accountController,
                decoration: InputDecoration(
                  hintText: "Account Number".tr,
                  hintStyle: const TextStyle(color: Colors.black45),
                  filled: true,
                  fillColor: const Color(0xFFFAF2C7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Account Name".tr,
                  hintStyle: const TextStyle(color: Colors.black45),
                  filled: true,
                  fillColor: const Color(0xFFFAF2C7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (pointController.text == "") {
                          toastification.show(
                            type: ToastificationType.warning,
                            context: context,
                            title: Text("Enter Point Amount".tr),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        } else if (accountController.text == "") {
                          toastification.show(
                            type: ToastificationType.warning,
                            context: context,
                            title: Text("Enter Account Number".tr),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        } else if (nameController.text == "") {
                          toastification.show(
                            type: ToastificationType.warning,
                            context: context,
                            title: Text("Enter Account Name".tr),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        } else if (payment_id == "") {
                          toastification.show(
                            type: ToastificationType.warning,
                            context: context,
                            title: Text("Select Payment Method".tr),
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                        } else {
                          // Navigator.of(context).pop();
                          productController.withdrawPoint(
                            points: pointController.text,
                            payment_id: payment_id,
                            account_number: accountController.text,
                            account_name: nameController.text,
                            context: context,
                          );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child:
                        productController.isWithDrawLoading.value
                            ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              'Claim',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  // Helper widget for TextFields to reduce repetition

  // Helper widget for payment options
  Widget _buildPaymentOption({
    required String imagePath,
    required PaymentData method,
  }) {
    final isSelected = _selectedPaymentMethod == method.paymentType;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method.paymentType;
          payment_id = method.id.toString();
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF2C7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: CachedImageWidget(imgUrl: imagePath, height: 50, width: 50),
      ),
    );
  }
}

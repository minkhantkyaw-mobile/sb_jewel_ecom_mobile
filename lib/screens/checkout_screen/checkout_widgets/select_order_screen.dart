import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spjewellery/controllers/auth_controller.dart';
import 'package:spjewellery/core/app_widgets/my_cache_img.dart';
import 'package:spjewellery/models/payment_model.dart';
import 'package:spjewellery/models/township_cod_model.dart';
import 'package:spjewellery/screens/checkout_screen/checkout_widgets/payment_sheet.dart';
import 'package:spjewellery/screens/checkout_screen/township_alert.dart';

import 'package:shimmer/shimmer.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/checkout_controller.dart';
import '../../../core/app_widgets/app_button.dart';
import '../../../core/app_widgets/back_button.dart';
import '../../../core/app_widgets/custom_drop_down.dart';
import '../../../core/app_widgets/custom_loading_widget.dart';
import '../../../core/app_widgets/my_text_filed.dart';
import '../../../core/app_widgets/row_text_widget.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/data_constant.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/cart_model.dart';
import '../../../models/township_model.dart';
import '../../../services/toast_service.dart';
import 'drop_down_widget.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:shimmer/shimmer.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/checkout_controller.dart';
import '../../../core/app_widgets/app_button.dart';
import '../../../core/app_widgets/back_button.dart';
import '../../../core/app_widgets/custom_drop_down.dart';
import '../../../core/app_widgets/custom_loading_widget.dart';
import '../../../core/app_widgets/my_text_filed.dart';
import '../../../core/app_widgets/row_text_widget.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/data_constant.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/cart_model.dart';
import '../../../models/township_model.dart';
import '../../../services/toast_service.dart';
import 'drop_down_widget.dart';

class SelectDeliveryScreen extends StatefulWidget {
  const SelectDeliveryScreen({super.key});

  @override
  State<SelectDeliveryScreen> createState() => _SelectDeliveryScreenState();
}

// -------- SAFE PARSER --------
double safeParseDouble(dynamic value) {
  if (value == null) return 0.0;
  return double.tryParse(value.toString()) ?? 0.0;
}

class _SelectDeliveryScreenState extends State<SelectDeliveryScreen> {
  final CheckOutController controller = Get.find<CheckOutController>();
  final CartController cartController = Get.find<CartController>();
  final AuthController authController = Get.find<AuthController>();

  // String selectedPayment = "online"; // default

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.regionList.clear();
      controller.townShipList.clear();
      controller.pageTownShip.value = 1;
      // controller.selectedPayment();
      controller.getTownShipCOD(regionId: controller.selectedRegionId.value);
      controller.getPayments();
      controller.getRegions();

      controller.selectedPayment.value = PaymentData();

      controller.nameController.text =
          authController.userData.value.name.toString();
      controller.phoneController.text =
          authController.userData.value.phone.toString();
    });

    //For default payment
    // selectedPayment = 'payment';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bottomColor,
          toolbarHeight: Dimesion.screenHeight / 11,
          leading: backButton(),
          centerTitle: true,
          title: Text(
            "Check Out".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimesion.font16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        bottomNavigationBar: builderBottomBar(),

        body: ListView(
          padding: EdgeInsets.all(Dimesion.width10),
          children: [
            SizedBox(height: Dimesion.height10),
            contactInfoSection(),
            SizedBox(height: Dimesion.height20),
            addressSection(),
            SizedBox(height: 25),
            cartItemsSection(),
            SizedBox(height: 25),
            cartTotalSection(),
            SizedBox(height: Dimesion.height30),
            // PaymentMethodSelector(
            //   selectedMethod: selectedPayment,
            //   onSelect: (method) => setState(() => selectedPayment = method),
            // ),
            const SizedBox(height: 25),
            // if (selectedPayment == "online")
            // onlinePaymentSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget builderBottomBar() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, -1),
            ),
          ],
          color: AppColor.white,
        ),
        padding: EdgeInsets.all(Dimesion.radius15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.isCold.value == "1")
              OrderButtonWidget(
                color: AppColor.myRed,
                title: Text(
                  "Checkout Order".tr,
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimesion.font16 - 3,
                  ),
                ),
                // onTap: () {
                //   print(selectedPayment);
                //   selectedPayment = 'online';
                //   if (selectedPayment == "cod") {
                //     controller.validateCodForConfirmCheckout();
                //   } else {
                //     controller.validatePayNowForConfirmCheckout();
                //   }
                // },
                onTap: () {
                  // if (controller.selectedPayment.value.id == null) {
                  //   ToastService.warningToast("Please select payment method");
                  //   return;
                  // }

                  controller.validatePayNowForConfirmCheckout();
                },

                minWidth: Dimesion.screeWidth,
                height: Dimesion.height40 * 1.1,
              ),
          ],
        ),
      ),
    );
  }

  Widget contactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Information",
          style: TextStyle(
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimesion.height10),
        MyTextFieldOrderWidget(
          hideIcon: false,
          controller: controller.nameController,
          isPasswords: false,
          hintText: "Enter Your Name".tr,
          prefixIcon: Icons.person_outline,
          inputType: TextInputType.text,
          fieldValidator: (value) {
            if (value!.isEmpty) {
              ToastService.errorToast("Please enter your name");
              return "";
            }
            return null;
          },
          inputAction: TextInputAction.done,
          height: Dimesion.height40,
        ),
        MyTextFieldOrderWidget(
          hideIcon: false,
          controller: controller.phoneController,
          isPasswords: false,
          prefixIcon: CupertinoIcons.phone,
          hintText: "Enter Your Phone Number".tr,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.done,
          fieldValidator: (value) {
            if (value!.isEmpty) {
              ToastService.errorToast("Please enter your phone number");
              return "";
            }
            if (!value.toString().isPhoneNumber) {
              ToastService.errorToast("Please enter valid phone number");
              return "";
            }
            return null;
          },
          height: Dimesion.height40,
        ),
      ],
    );
  }

  Widget addressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: TextStyle(
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimesion.height10),
        townshipSelector(),
        SizedBox(height: Dimesion.height10),
        fullAddressField(),
        SizedBox(height: Dimesion.height15),
        // remarkField(),
      ],
    );
  }

  Widget townshipSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ---------------- REGION DROPDOWN ----------------
        if (controller.regionList.isNotEmpty)
          CustomDropdown(
            hintText:
                (controller.regionData.value != null &&
                        controller.regionData.value!.name != null &&
                        controller.regionData.value!.name!.isNotEmpty)
                    ? controller.regionData.value!.name!
                    : "Please Select Your Region",

            items:
                controller.regionList
                    .map(
                      (region) => DropdownMenuItem(
                        value: region,
                        child: Text(
                          region.name ?? "",
                          style: TextStyle(fontSize: Dimesion.font14),
                        ),
                      ),
                    )
                    .toList(),

            onChanged: (value) async {
              // Update selected region
              controller.regionDropdownOnChanged(value);

              // Reset township
              controller.townShipData.value = null;
              controller.townShipController.clear();
              controller.townShipList.clear();

              // Load townships by region using the region ID (value.id)
              await controller.paymentList(value.id);

              controller.update();
            },
          ),

        Gap(Dimesion.height15),

        /// ---------------- TOWNSHIP DROPDOWN ----------------
        // The Township Dropdown only appears IF a region is selected AND the list is populated
        //  if (controller.townShipList
        // .where((town) => town.regionId == controller.selectedRegionId.value)
        // .isNotEmpty)
        CustomDropdownTownShip(
          hintText:
              controller.townShipData.value?.city ??
              "Please Select Your Township",

          // Filter townships by selected regionId
          items:
              controller.townShipList
                  .where(
                    (town) =>
                        town.regionId == controller.selectedRegionId.value,
                  )
                  .map(
                    (town) => DropdownMenuItem<TownShipCodData?>(
                      value: town,
                      child: Text(
                        town.city ?? "",
                        style: TextStyle(fontSize: Dimesion.font14),
                      ),
                    ),
                  )
                  .toList(),

          onChanged: (value) {
            if (value == null) return; // null check
            controller.onChangeTownShip(value); // value is non-nullable here
          },
        ),
        // ... (Rest of the conditional UI: "Please select region first" and Shimmer)
        if (controller.regionData.value == null)
          Container(
            height: Dimesion.height40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Please select region first",
              style: TextStyle(color: Colors.grey),
            ),
          ),

        if (controller.regionData.value != null &&
            controller.townShipList.isEmpty)
          Shimmer.fromColors(
            baseColor: CupertinoColors.lightBackgroundGray,
            highlightColor: Colors.white,
            child: Container(
              height: Dimesion.height40,
              decoration: BoxDecoration(
                color: AppColor.grey,
                borderRadius: BorderRadius.circular(Dimesion.radius5),
              ),
            ),
          ),
      ],
    );
  }

  Widget fullAddressField() {
    return Container(
      padding: EdgeInsets.only(left: Dimesion.width10),
      height: Dimesion.height40 + 60,
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        border: Border.all(color: AppColor.grey, width: 0.4),
        borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
      ),
      child: TextField(
        controller: controller.addressController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Full Address",
        ),
      ),
    );
  }

  // Widget remarkField() {
  //   return Container(
  //     padding: EdgeInsets.only(left: Dimesion.width10),
  //     height: Dimesion.height40 + 60,
  //     decoration: BoxDecoration(
  //       color: AppColor.bgColor,
  //       border: Border.all(color: AppColor.grey, width: 0.4),
  //       borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
  //     ),
  //     child: TextField(
  //       controller: controller.remarkController,
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //         hintText: "Remark",
  //       ),
  //     ),
  //   );
  // }

  Widget cartItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cart Items",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          itemCount: cartController.cartList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = cartController.cartList[index];
            return cartItemTile(item, index);
          },
        ),
      ],
    );
  }

  Widget cartItemTile(cartItem, int index) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              cartItem.product!.images![0],
              width: 90,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE + PRICE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.product!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${cartItem.product!.price ?? 0} Ks",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  cartItem.size != null ? "${cartItem.size}" : "Size: -",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 6),
                quantityRow(cartItem, index),
                const SizedBox(height: 8),
                removeButton(cartItem),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityRow(cartItem, int index) {
    return Row(
      children: [
        InkWell(
          onTap:
              () => cartController.updateCartQuantity(
                isIncrease: false,
                index: index,
                cartId: cartItem.product!.id!,
                inc: cartItem.product!.increment_step!,
              ),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColor.primaryClr,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          "${cartItem.quantity}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 14),
        InkWell(
          onTap:
              () => cartController.updateCartQuantity(
                isIncrease: true,
                index: index,
                cartId: cartItem.product!.id!,
                inc: cartItem.product!.increment_step!,
              ),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColor.primaryClr,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget removeButton(cartItem) {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () => cartController.delecteCart(cartId: cartItem.product!.id!),
        child: const Text(
          "Remove",
          style: TextStyle(
            color: Colors.red,
            fontSize: 13,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget cartTotalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cart Total",
          style: TextStyle(
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColor.bottomBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (controller.isExchange.value == 1)
                RowTextWidget(
                  title: "Exchange Points",
                  val: "${controller.exchangePoints} Points",
                ),
              // if (controller.isExchange.value == 0)
              //   RowTextWidget(
              //     title: "Earned Points",
              //     val: "${cartController.totalEarnPoints} Points",
              //   ),
              // RowTextWidget(
              //   title: "Delivery Fees",
              //   val:
              //       "${DataConstant.priceFormat.format(controller.selectedDeliFee.value)} Ks",
              // ),
              // if (controller.isExchange.value == 0)
              //   RowTextWidget(
              //     title: "Discount",
              //     val: "${safeParseDouble(cartController.totalDiscount)} Ks",
              //   ),
              RowTextWidget(
                title: "Subtotal",
                val:
                    "${DataConstant.priceFormat.format(cartController.totalAmount.value)} Ks",
              ),
              const Divider(),
              RowTextWidget(
                title: "Grand Total",
                val:
                    "${DataConstant.priceFormat.format(safeParseDouble(cartController.totalAmount.value) - safeParseDouble(cartController.totalDiscount))} Ks",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedOnlinePaymentTile() {
    return Obx(() {
      final selectedPayment = controller.selectedPayment.value;

      if (selectedPayment == null) {
        return GestureDetector(
          // onTap: _showPointsBottomSheet,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black26, width: 1),
              color: Colors.grey.shade50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tap to Select Online Bank",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        );
      }

      // Found the selected payment
      const Color selectedColor = Colors.blue;

      return GestureDetector(
        // onTap: _showPointsBottomSheet, // Allow user to change payment method
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selectedColor, width: 2),
            color: selectedColor.withOpacity(0.1),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildPaymentImage(selectedPayment.paymentLogo),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedPayment.name ?? "Selected Bank",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: selectedColor,
                      ),
                    ),
                    Text(
                      selectedPayment.number ?? "Account Number",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.check_circle, size: 24, color: selectedColor),
            ],
          ),
        ),
      );
    });
  }

  Widget onlinePaymentSection() {
    return GetBuilder<CheckOutController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Your method to checkout",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),

            // ---------------- PAYMENT LIST ----------------
            Obx(
              () =>
                  controller.paymentList.isNotEmpty
                      ? ListView.builder(
                        itemCount: controller.paymentList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          PaymentData payment = controller.paymentList[index];
                          return _buildPaymentCheckOption(
                            imagePath: payment.paymentLogo ?? "",
                            data: payment,
                          );
                        },
                      )
                      : const SizedBox(),
            ),

            const SizedBox(height: 20),

            // ---------------- UPLOAD TEXT ----------------
            Text(
              "Please upload your payment screenshot".tr,
              style: TextStyle(
                color: AppColor.black,
                fontSize: Dimesion.font14 - 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Dimesion.height10),

            // ---------------- IMAGE PICKER ----------------
            InkWell(
              onTap: () {
                controller.pickImage();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  color: Colors.grey.shade100,
                ),
                child:
                    controller.pickedImagePath == null
                        ? DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            height: Dimesion.screenHeight / 4,
                            width: Dimesion.screeWidth,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Click here image upload".tr),
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: Dimesion.iconSize25 + 17,
                                ),
                              ],
                            ),
                          ),
                        )
                        : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Dimesion.radius15 / 2,
                            ),
                            child: Stack(
                              children: [
                                Image.file(
                                  controller.pickedImagePath!,
                                  fit: BoxFit.cover,
                                  height: Dimesion.screenHeight / 4,
                                  width: Dimesion.screeWidth,
                                ),
                                Positioned(
                                  right: 1,
                                  child: IconButton(
                                    icon: const Icon(CupertinoIcons.eye),
                                    onPressed: () {
                                      showCupertinoModalBottomSheet(
                                        context: context,
                                        builder:
                                            (context) => Scaffold(
                                              body: Container(
                                                color: AppColor.black,
                                                child: Column(
                                                  children: [
                                                    Gap(Dimesion.height15),
                                                    Flexible(
                                                      child: Image.file(
                                                        controller
                                                            .pickedImagePath!,
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                    ),
                                                    Gap(Dimesion.height15),
                                                    SizedBox(
                                                      height:
                                                          Dimesion.height40 + 8,
                                                      child: AppButtonWidget(
                                                        title: Text(
                                                          "OK".tr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                Dimesion.font16,
                                                          ),
                                                        ),
                                                        minWidth:
                                                            Dimesion.screeWidth,
                                                        height:
                                                            Dimesion.height40,
                                                        color:
                                                            AppColor.primaryClr,
                                                        onTap: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              ),
            ),

            SizedBox(height: Dimesion.height20),
          ],
        );
      },
    );
  }

  Widget _buildPaymentCheckOption({
    required String imagePath,
    required PaymentData data,
  }) {
    final CheckOutController controller = Get.find<CheckOutController>();

    return Obx(() {
      final bool isSelected =
          controller.selectedPayment.value.id != null &&
          controller.selectedPayment.value.id == data.id;

      return GestureDetector(
        onTap: () {
          controller.onSelectPayment(data);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColor.primaryClr : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              MyCacheImg(
                url: data.paymentLogo ?? "",
                boxfit: BoxFit.contain,
                height: Dimesion.height40,
                width: Dimesion.height40,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
              ),
              Gap(Dimesion.width10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    data.number ?? "",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: data.number ?? ""));
                  ToastService.successToast("Copied! ${data.number}");
                },
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPaymentImage(String? url) {
    if (url == null || url.isEmpty || !url.startsWith("http")) {
      return Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.account_balance_wallet,
          size: 28,
          color: Colors.black54,
        ),
      );
    }
    return Image.network(
      url,
      width: 55,
      height: 55,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.broken_image, size: 28),
        );
      },
    );
  }
}

Widget _buildPaymentImage(String? url) {
  if (url == null || url.isEmpty || !url.startsWith("http")) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        size: 28,
        color: Colors.black54,
      ),
    );
  }
  return Image.network(
    url,
    width: 55,
    height: 55,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.broken_image, size: 28),
      );
    },
  );
}

class PaymentMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onSelect;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildOption(
          label: "Online Payment",
          value: "online",
          selected: selectedMethod == "online",
          icon: Icons.wallet_outlined,
        ),
        const SizedBox(height: 10),
        _buildOption(
          label: "Cash on Delivery",
          value: "cod",
          selected: selectedMethod == "cod",
          icon: Icons.attach_money,
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _buildOption({
    required String label,
    required String value,
    required bool selected,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => onSelect(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.white : Colors.black26,
            width: selected ? 2 : 1,
          ),
          color: selected ? AppColor.primaryClr : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: selected ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? Colors.white : Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentSheetState extends State<PaymentSheet> {
  final CheckOutController checkOutController = Get.find<CheckOutController>();
  String? _selectedPaymentMethod;
  String? payment_id = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkOutController.pickedImagePath = null;
      payment_id = "";
      checkOutController.getPayments();
    });
    super.initState();
  }

  Widget _buildPaymentCheckOption({
    required String imagePath,
    required PaymentData data,
  }) {
    final isSelected = _selectedPaymentMethod == data.paymentType;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkOutController.onSelectPayment(data);
          _selectedPaymentMethod = data.paymentType;
          payment_id = data.id.toString();
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyCacheImg(
              url: data.paymentLogo.toString() ?? "",
              boxfit: BoxFit.contain,
              height: Dimesion.height40,
              width: Dimesion.height40,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
            ),
            Gap(Dimesion.width5),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  data.number ?? "",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: data.number.toString()));
                ToastService.successToast('Copied!' + data.number.toString());
              },
              icon: Icon(Icons.copy),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(
      builder: (controller) {
        return Obx(
          () =>
              checkOutController.paymentList.length != 0
                  ? Container(
                    padding: EdgeInsets.all(15),
                    width: Dimesion.screeWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Payment Method".tr,
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: Dimesion.font14 - 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel".tr,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Dimesion.font14 - 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimesion.height15),
                        // --- 👇 CORRECTION APPLIED HERE 👇 ---
                        Obx(
                          () => Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.paymentList.length,
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                PaymentData payment =
                                    controller.paymentList[index];
                                return _buildPaymentCheckOption(
                                  imagePath: payment.paymentLogo.toString(),
                                  data: payment,
                                );
                              },
                            ),
                          ),
                        ),
                        // --- 👆 CORRECTION APPLIED HERE 👆 ---
                        Gap(17),
                        Text(
                          "Please upload your payment screenshoot".tr,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: Dimesion.font14 - 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimesion.height10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              controller.pickImage();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimesion.radius15 / 2,
                              ),
                              border: Border.all(
                                color: Colors.grey.shade100,
                                width: 1,
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child:
                                controller.pickedImagePath == null
                                    ? DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      padding: EdgeInsets.all(6),
                                      child: Container(
                                        height: Dimesion.screenHeight / 4,
                                        width: Dimesion.screeWidth,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Click here image upload".tr),
                                            Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              size: Dimesion.iconSize25 + 17,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    : DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      padding: EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          Dimesion.radius15 / 2,
                                        ),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              controller.pickedImagePath!,
                                              fit: BoxFit.cover,
                                              height: Dimesion.screenHeight / 4,
                                              width: Dimesion.screeWidth,
                                            ),
                                            Positioned(
                                              right: 1,
                                              child: IconButton(
                                                onPressed: () {
                                                  showCupertinoModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (context) => Scaffold(
                                                          body: Container(
                                                            color:
                                                                AppColor.black,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Gap(
                                                                  Dimesion
                                                                      .height15,
                                                                ),
                                                                Flexible(
                                                                  child: Image.file(
                                                                    controller
                                                                        .pickedImagePath!,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                  ),
                                                                ),
                                                                Gap(
                                                                  Dimesion
                                                                      .height15,
                                                                ),
                                                                Container(
                                                                  height:
                                                                      Dimesion
                                                                          .height40 +
                                                                      8,
                                                                  child: AppButtonWidget(
                                                                    title: Text(
                                                                      "OK".tr,
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                        fontSize:
                                                                            Dimesion.font16,
                                                                      ),
                                                                    ),
                                                                    minWidth:
                                                                        Dimesion
                                                                            .screeWidth,
                                                                    height:
                                                                        Dimesion
                                                                            .height40,
                                                                    color:
                                                                        AppColor
                                                                            .primaryClr,
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  );
                                                },
                                                icon: Icon(CupertinoIcons.eye),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                          ),
                        ),
                        SizedBox(height: Dimesion.height10),
                        AppButtonWidget(
                          color: AppColor.bottomColor,
                          title: Text(
                            "Done".tr,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              controller.validatePayNowForConfirmCheckout();
                            });
                          },
                          minWidth: Dimesion.screeWidth,
                          height: Dimesion.height40 * 1.1,
                          borderRadius: Dimesion.radius10,
                        ),
                        SizedBox(height: Dimesion.height30),
                      ],
                    ),
                  )
                  : Container(),
        );
      },
    );
  }
}

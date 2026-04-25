import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/models/exchange_post_model.dart';
import 'package:spjewellery/screens/product_detail_screen/widgets/image_slider_widget.dart';

import 'package:shimmer/shimmer.dart';
import '../../controllers/cart_controller.dart';
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
import '../nav/nav_controller.dart';
import 'exchange_product_detail_body.dart';

class ProductExchangeDetailScreen extends StatefulWidget {
  final int? id;
  final ProductData data;
  const ProductExchangeDetailScreen({super.key, this.id, required this.data});
  @override
  State<ProductExchangeDetailScreen> createState() =>
      _ProductExchangeDetailScreenState();
}

class _ProductExchangeDetailScreenState
    extends State<ProductExchangeDetailScreen> {
  final CheckOutController checkOutController = Get.find<CheckOutController>();
  final NavController navController = Get.find<NavController>();
  final ProductController productController = Get.find<ProductController>();

  int code_index = 0;
  final shakeKey = GlobalKey<ShakeWidgetState>();

  final controller = Get.find<ProductController>();
  String selectedValue = "";
  String selectedValue2 = "";

  bool isWholeSale = false;
  bool isCheck = false;
  int totalWholeSale = 0;
  int actucalWholeSaleQuantity = 0;

  List<String> images = [];

  List<Variations> varientList = [];
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    varientList.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.isDetailLoading.value = true;

      productController.getProductDetail(id: widget.data.id!);

      cartController.stock.value = widget.data.stock!;

      cartController.qty.value = 1;
    });
    images.add(widget.data.images![0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: AppColor.bgColor,
          appBar: AppBar(
            toolbarHeight: Dimesion.height40 + 27,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(Dimesion.radius15),
              ),
            ),
            backgroundColor: AppColor.white,
            centerTitle: true,
            title: Text(
              "Product Detail".tr,
              style: TextStyle(
                fontSize: Dimesion.font18,
                color: AppColor.black,
              ),
            ),
            leading: backButtonBlack(),
            elevation: 0,
            scrolledUnderElevation: 0,
            actions: [
              //heart
              Container(
                width: 35,
                height: 30,

                child: Center(
                  child: Obx(
                    () => IconButton(
                      padding: EdgeInsets.only(
                        left: Dimesion.width5 - 2,
                        right: Dimesion.width5 - 2,
                      ),
                      onPressed: () {
                        // Toggle favorite state or call wishlist API
                        controller.addWishList(id: widget.data.id!.toInt());
                      },
                      icon: Icon(
                        controller.favList.any(
                              (item) => item.id == widget.data.id,
                            )
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color:
                            controller.favList.any(
                                  (item) => item.id == widget.data.id,
                                )
                                ? Colors.red
                                : AppColor.primaryClr,
                        size: Dimesion.iconSize25,
                      ),
                    ),
                  ),
                ),
              ),

              ShakeMe(
                // 4. pass the GlobalKey as an argument
                key: shakeKey,
                // 5. configure the animation parameters
                shakeCount: 3,
                shakeOffset: 10,
                shakeDuration: Duration(milliseconds: 500),
                // 6. Add the child widget that will be animated
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      navController.tabIndex.value = 3;
                      Get.toNamed(RouteHelper.nav);
                    },
                    child: Badge(
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.topRight,
                      label: Text(
                        checkOutController.cartList.length.toString() != "0"
                            ? checkOutController.cartList.length.toString()
                            : "",
                        //  cont.unReadNotiList.length.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(color: Colors.white),
                      ),
                      backgroundColor:
                          checkOutController.cartList.length.toString() != "0"
                              ? Colors.redAccent
                              : Colors.transparent,
                      child: Container(
                        width: Dimesion.height40,
                        height: Dimesion.height40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(Dimesion.size10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Dimesion.radius10),
                          child: Icon(
                            CupertinoIcons.cart,
                            color: Color(0xFFFAB83E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(Dimesion.height20),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: Dimesion.screenHeight * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                  background: ImageSlider(
                    carouselController: controller.carouselController,
                    images: widget.data.images!,
                    activeIndex: controller.imgIndex.value,
                    onPageChanged: (val, _) {
                      controller.imgIndex.value = val;
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ExchangeProductDetailBodyView(data: widget.data),
                ]),
              ),
              SliverToBoxAdapter(child: SizedBox(height: Dimesion.height10)),
            ],
          ),
          bottomNavigationBar: _buildBottomBar(),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: AppColor.bottomBgColor,
      padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 35),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (cartController.sizeId.value == 0) {
              ToastService.warningToast("Please Select Size");
            } else {
              checkOutController.isExchange.value = 1;
              checkOutController.exchangePoints.value =
                  widget.data.requiredPoint!;
              ExchangePostModel model = new ExchangePostModel(
                productId: widget.data.id!,
                productVariationId: null,
                sizeId: cartController.sizeId.value,
                optionId: null,
                quantity: cartController.qty.value,
                price: widget.data.price,
                totalPrice: widget.data.price,
              );
              checkOutController.exchangeData.add(model);
              Get.toNamed(RouteHelper.selectDeliveryScreen);
              // cartController.addCart(productId: widget.data.id!, isBuyNow: true);
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          height: Dimesion.height30,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColor.buttonColor),
            color: AppColor.buttonColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "Exchange".tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(left: 6, right: 6),
        alignment: Alignment.center,
        height: Dimesion.height30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Quantity', style: TextStyle(color: Colors.black)),
            SizedBox(height: 8),
            Row(
              children: [
                _buildQuantityButton(
                  icon: Icons.remove,
                  onPressed: () {
                    setState(() {
                      cartController.changeQuantity(isIncrease: false);
                    });
                  },
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    cartController.qty.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Dimesion.font14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildQuantityButton(
                  icon: Icons.add,
                  onPressed: () {
                    setState(() {
                      cartController.changeQuantity(isIncrease: false);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.yellow.shade700,
          shape: BoxShape.rectangle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}

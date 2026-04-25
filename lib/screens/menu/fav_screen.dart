import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';

import '../../controllers/fav_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/empty_view.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../nav/productcard.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getWishList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: Dimesion.screenHeight / 11,
            leading: backButton(),
            backgroundColor: AppColor.primaryClr,
            centerTitle: true,
            title: Text(
              "Whitelist".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimesion.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: Obx(
            () =>
                productController.favList.length != 0
                    ? Container(
                      margin: EdgeInsets.only(bottom: Dimesion.height10),
                      padding: EdgeInsets.only(
                        left: Dimesion.size10,
                        right: Dimesion.size10,
                        top: Dimesion.height10,
                      ),
                      child: MasonryGridView.count(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: productController.favList.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: Dimesion.screenHeight / 45,
                        crossAxisSpacing: Dimesion.screeWidth / 17,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.toNamed(RouteHelper.product_detail);
                              // To fix prodcut Details Screen in Whitelist
                              Get.toNamed(
                                RouteHelper.product_detail,
                                arguments: ProductDetailScreen(
                                  data: productController.favList[index],
                                ),
                              );
                            },
                            child: ProductCardWidget(
                              data: productController.favList[index],
                              controller: productController,
                            ),
                          );
                        },
                      ),
                    )
                    : Center(
                      child:
                          productController.isFavLoading.value == true
                              ? Container(
                                padding: EdgeInsets.all(Dimesion.height10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    Dimesion.radius15 / 2,
                                  ),
                                ),
                                child: CupertinoActivityIndicator(
                                  radius: Dimesion.radius10 - 1,
                                  color: Colors.grey,
                                  animating: true,
                                ),
                              )
                              : Container(
                                child:
                                    productController.favList.isEmpty
                                        ? EmptyViewWidget()
                                        : Container(),
                              ),
                    ),
          ),
        );
      },
    );
  }
}

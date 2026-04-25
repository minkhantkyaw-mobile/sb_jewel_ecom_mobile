import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/nav/productcard.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/search_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/custom_loading_widget.dart';
import '../../core/app_widgets/empty_view.dart';
import '../../core/app_widgets/footer_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../search_page.dart';

class CategoryBrandPage extends StatefulWidget {
  final int id;
  final String name;
  final bool isCategory;
  const CategoryBrandPage({
    super.key,
    required this.id,
    required this.isCategory,
    required this.name,
  });

  @override
  State<CategoryBrandPage> createState() => _CategoryBrandPageState();
}

class _CategoryBrandPageState extends State<CategoryBrandPage> {
  final MySearchController controller = Get.find<MySearchController>();
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getByCategoryBrand(
        isCategory: widget.isCategory,
        id: widget.id,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(
      builder: (builder) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Dimesion.screenHeight / 11,
            leading: backButton(),
            backgroundColor: AppColor.myGreen,
            centerTitle: true,
            title: Text(
              widget.name.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimesion.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(
                    RouteHelper.search,
                    arguments: SearchPage(
                      datalist: productController.allProducts,
                    ),
                  );
                },
                icon: Icon(CupertinoIcons.search, color: Colors.white),
              ),
            ],
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CustomLoadingWidget());
            } else if (controller.results.isEmpty) {
              return const EmptyViewWidget();
            } else {
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: controller.onRefresh,
                footer: Obx(
                  () => footer(canLoadMore: controller.canLoadMore.value),
                ),
                onLoading: controller.onLoading,
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                physics: const BouncingScrollPhysics(),
                child:
                    controller.results.length != 0
                        ? Container(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(Dimesion.width10),
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.results.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: Dimesion.screenHeight / 45,
                            crossAxisSpacing: Dimesion.screeWidth / 17,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    RouteHelper.product_detail,
                                    arguments: ProductDetailScreen(
                                      data: controller.results[index],
                                    ),
                                  );
                                },
                                child: ProductCardWidget(
                                  data: controller.results[index],
                                  controller: productController,
                                ),
                              );
                            },
                          ),
                        )
                        : Container(),
              );
            }
          }),
        );
      },
    );
  }
}

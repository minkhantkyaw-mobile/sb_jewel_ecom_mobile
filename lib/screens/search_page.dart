import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../controllers/product_controller.dart';
import '../controllers/search_controller.dart';
import '../core/app_widgets/back_button.dart';
import '../core/app_widgets/custom_loading_widget.dart';
import '../core/app_widgets/empty_view.dart';
import '../core/app_widgets/footer_widget.dart';
import '../core/app_widgets/my_text_filed.dart';
import '../core/constants/app_color.dart';
import '../core/constants/dimesions.dart';
import '../models/product_model.dart';
import '../router/route_helper.dart';
import 'nav/productcard.dart';

class SearchPage extends StatefulWidget {
  final List<ProductData> datalist;
  SearchPage({super.key, required this.datalist});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MySearchController searchController = Get.find<MySearchController>();
  final ProductController productController = Get.find<ProductController>();
  final ScrollController scroll_Controller = new ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.page.value = 1;
      searchController.results.assignAll(widget.datalist);
      ;
      print("ProductList>>>" + searchController.results.length.toString());
      //controller.getAllProducts(isLoadmore: false);

      scroll_Controller.addListener(() {
        if (scroll_Controller.position.pixels ==
            scroll_Controller.position.maxScrollExtent) {
          searchController.onLoading();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Dimesion.screenHeight / 10,
            leading: backButtonBlack(),
            backgroundColor: AppColor.myGreen,
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.only(right: Dimesion.width10),
              child: PreferredSize(
                preferredSize: Size.fromHeight(Dimesion.height40),

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimesion.width10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: controller.searchController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      prefixIcon: Padding(
                        padding: EdgeInsets.all(Dimesion.width5),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColor.primaryClr,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            CupertinoIcons.search,
                            size: Dimesion.iconSize25,
                            color: AppColor.white,
                          ),
                        ),
                      ),

                      suffixIcon: InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.filter);
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimesion.width5),
                          child: Icon(
                            Icons.filter_list_alt,
                            size: Dimesion.iconSize25,
                            color: AppColor.primaryClr,
                          ),
                        ),
                      ),
                      hintText: "Search Product".tr,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onChanged: (val) {
                      controller.page.value = 1;
                      EasyDebounce.debounce(
                        'search',
                        const Duration(milliseconds: 500),
                        () async {
                          controller.results.clear();
                          await controller.getSearchProducts(isLoadMore: false);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          body: Obx(() {
            if (controller.isLoading.value == true) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(Dimesion.height10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: Dimesion.radius10 - 1,
                    color: Colors.grey,
                    animating: true,
                  ),
                ),
              );
            } else if (controller.results.isEmpty) {
              return const EmptyViewWidget();
            } else {
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: controller.onRefresh,
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                scrollController: scroll_Controller,
                physics: const BouncingScrollPhysics(),
                child:
                    controller.results.length != 0
                        ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.searchController.text != "")
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: Dimesion.width5,
                                    bottom: Dimesion.width5,
                                    left: Dimesion.width10,
                                  ),
                                  child: Text(
                                    "${controller.results.length} Products found"
                                        .tr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimesion.font16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.all(Dimesion.width10),
                                child: MasonryGridView.count(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.results.length,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: Dimesion.screenHeight / 45,
                                  // crossAxisSpacing: Dimesion.screeWidth / 17,
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
                              ),
                            ],
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

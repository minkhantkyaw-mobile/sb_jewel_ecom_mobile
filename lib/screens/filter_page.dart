import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';
import 'package:spjewellery/screens/search_page.dart';

import '../controllers/product_controller.dart';
import '../controllers/search_controller.dart';
import '../core/app_widgets/app_button.dart';
import '../core/app_widgets/back_button.dart';
import '../core/app_widgets/custom_loading_widget.dart';
import '../core/app_widgets/empty_view.dart';
import '../core/app_widgets/my_text_filed.dart';
import '../core/constants/app_color.dart';
import '../core/constants/dimesions.dart';
import '../router/route_helper.dart';
import 'nav/productcard.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final ProductController productController = Get.find<ProductController>();
  final MySearchController searchController = Get.find<MySearchController>();

  late int select_category = -1;
  late int select_brand = -1;

  late int category_id = -1;
  late int brand_id = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.filterList.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimesion.screenHeight / 11,
        leading: backButtonBlack(),
        centerTitle: false,
        title: Text(
          "filter".tr,
          style: TextStyle(color: Colors.black, fontSize: Dimesion.font16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                RouteHelper.search,
                arguments: SearchPage(datalist: productController.allProducts),
              );
            },
            icon: Icon(CupertinoIcons.search, color: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColor.bgColor,
        padding: EdgeInsets.all(Dimesion.width10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppButtonWidget(
                height: Dimesion.height40,
                title: Text(
                  "reset_filter".tr,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: Dimesion.font14,
                  ),
                ),
                color: Colors.white,
                onTap: () {
                  setState(() {
                    select_category = -1;
                    select_brand = -1;
                    category_id = -1;
                    brand_id = -1;
                    searchController.minController.text = "";
                    searchController.maxController.text = "";
                  });
                },
              ),
            ),
            Gap(Dimesion.width10),
            Flexible(
              child: AppButtonWidget(
                height: Dimesion.height40,
                title: Text(
                  "search".tr,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: Dimesion.font14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: AppColor.primaryClr,
                onTap: () {
                  searchController.getSearchAll(
                    category_id: category_id,
                    brand_id: brand_id,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimesion.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "categories".tr,
              style: GoogleFonts.outfit(
                textStyle: TextStyle(
                  color: AppColor.black,
                  fontSize: Dimesion.font14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(Dimesion.height5),
            GetBuilder<ProductController>(
              builder: (builder) {
                return Obx(
                  () => Container(
                    height: Dimesion.height40 - 3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: builder.categorylist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (select_category != index) {
                                select_category = index;
                                category_id = builder.categorylist[index].id!;
                              } else {
                                select_category = -1;
                                category_id = -1;
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  select_category == index
                                      ? AppColor.primaryClr
                                      : AppColor.white,
                              borderRadius: BorderRadius.circular(
                                Dimesion.radius5,
                              ),
                            ),
                            margin: EdgeInsets.only(right: Dimesion.width5),
                            padding: EdgeInsets.only(
                              left: Dimesion.width15,
                              right: Dimesion.width15,
                            ),
                            child: Text(
                              builder.categorylist[index].name.toString(),
                              style: TextStyle(
                                color:
                                    select_category == index
                                        ? Colors.white
                                        : AppColor.blackless,
                                fontSize: Dimesion.font14 - 2,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Gap(Dimesion.height15),

            Row(
              children: [
                Flexible(
                  child: MyTextFieldWidget(
                    hideIcon: true,
                    controller: searchController.minController,
                    isPasswords: false,
                    prefixIcon: CupertinoIcons.phone,
                    inputType: TextInputType.number,
                    hintText: "price_lowest".tr,
                    inputAction: TextInputAction.next,
                    height: Dimesion.height40,
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.end,
                    "to".tr,
                    style: GoogleFonts.outfit(
                      textStyle: TextStyle(
                        color: AppColor.black,
                        fontSize: Dimesion.font14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Gap(Dimesion.width20),
                Flexible(
                  child: MyTextFieldWidget(
                    hideIcon: true,
                    controller: searchController.maxController,
                    isPasswords: false,
                    prefixIcon: CupertinoIcons.phone,
                    inputType: TextInputType.number,
                    hintText: "price_highest".tr,
                    inputAction: TextInputAction.next,
                    height: Dimesion.height40,
                  ),
                ),
              ],
            ),
            GetBuilder<MySearchController>(
              builder: (builder) {
                return Obx(() {
                  if (searchController.isLoading.value) {
                    return Center(child: CustomLoadingWidget());
                  } else if (searchController.filterList.isEmpty) {
                    return const EmptyViewWidget();
                  } else {
                    return searchController.filterList.length != 0
                        ? Container(
                          margin: EdgeInsets.only(top: Dimesion.height5),
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(Dimesion.width10),
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: searchController.filterList.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: Dimesion.screenHeight / 45,
                            crossAxisSpacing: Dimesion.screeWidth / 17,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    RouteHelper.product_detail,
                                    arguments: ProductDetailScreen(
                                      data: searchController.filterList[index],
                                    ),
                                  );
                                },
                                child: ProductCardWidget(
                                  data: searchController.filterList[index],
                                  controller: productController,
                                ),
                              );
                            },
                          ),
                        )
                        : Container();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

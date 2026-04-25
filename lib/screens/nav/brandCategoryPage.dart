import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/nav/productcard.dart';
import 'package:spjewellery/screens/product_detail_screen/product_detail_screen.dart';

import '../../controllers/product_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import '../search_page.dart';

class BrandCategoryPage extends StatefulWidget {
  final int brandCategoryId;
  final String title;

  const BrandCategoryPage({
    super.key,
    required this.title,
    required this.brandCategoryId,
  });

  @override
  State<BrandCategoryPage> createState() => _BrandCategoryPageState();
}

class _BrandCategoryPageState extends State<BrandCategoryPage> {
  final ProductController controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    controller.getProductsByBrand(widget.brandCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: Dimesion.screenHeight / 10,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: backButtonBlack(),
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimesion.font16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Dimesion.width10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(
                    RouteHelper.search,
                    arguments: SearchPage(
                      datalist: controller.productListByBrand,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimesion.width5,
                    horizontal: Dimesion.width10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimesion.width5),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColor.primaryClr,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          CupertinoIcons.search,
                          size: Dimesion.iconSize25,
                          color: AppColor.white,
                          semanticLabel: "Search Icon",
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "search".tr,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimesion.font16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.filter);
                        },
                        child: Icon(
                          Icons.filter_list_alt,
                          size: Dimesion.iconSize25,
                          color: AppColor.primaryClr,
                          semanticLabel: "Filter Icon",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (controller.isLoadingProducts.value)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (controller.productListByBrand.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "No products found".tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                Expanded(
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimesion.height10,
                    crossAxisSpacing: Dimesion.width10,
                    itemCount: controller.productListByBrand.length,
                    itemBuilder: (context, index) {
                      final product = controller.productListByBrand[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ProductDetailScreen(data: product));
                        },
                        child: ProductCardWidget(
                          data: product,
                          controller: controller,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spjewellery/core/app_widgets/my_cache_img.dart';
import 'package:spjewellery/router/route_helper.dart';
import 'package:spjewellery/screens/chat_screen/chat_screen.dart';
import 'package:spjewellery/screens/nav/cart.dart';
import 'package:spjewellery/screens/nav/newproduct.dart';
import 'package:spjewellery/screens/nav/popular_product.dart';
import 'package:spjewellery/screens/nav/shop_category.dart';
import 'package:spjewellery/screens/nav/shopbrand.dart';
import 'package:spjewellery/screens/search_page.dart';

import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/product_controller.dart';
import '../../core/app_widgets/custom_loading_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import 'all_product.dart';
import 'nav_controller.dart';

import 'package:carousel_slider/carousel_slider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ProductController controller = Get.find<ProductController>();
  final NavController navController = Get.find<NavController>();
  final ScrollController scrollController = ScrollController();

  bool _showSlider = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    double offset = scrollController.offset;

    if (offset > 0 && _showSlider) {
      setState(() => _showSlider = false);
    }

    if (offset <= 0 && !_showSlider) {
      setState(() => _showSlider = true);
    }

    _lastScrollOffset = offset;

    // Load more when reach bottom
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      controller.onLoadMoreProduct();
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.onInit();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.bgColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => ChatScreen());
            },
            backgroundColor: AppColor.primaryClr,
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ---------------- SCROLLABLE CONTENT ----------------
                CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // ---------------- HEADER ----------------
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      expandedHeight: Dimesion.screenHeight / 4,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryClr,
                                Color.fromARGB(255, 236, 75, 121),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimesion.width20,
                                vertical: Dimesion.height10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 18,
                                            backgroundImage: AssetImage(
                                              "assets/img/pe.png",
                                            ),
                                          ),
                                          SizedBox(width: Dimesion.width10),
                                          const Text(
                                            "Enjoy with SB!",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap:
                                                () => Get.to(() => CartPage()),
                                            child: const Icon(
                                              Icons.shopping_bag_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: Dimesion.width15),
                                          InkWell(
                                            onTap:
                                                () => Get.toNamed(
                                                  RouteHelper.noti,
                                                ),
                                            child: const Icon(
                                              Icons.notifications_none,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimesion.height15),
                                  // Search bar
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        RouteHelper.search,
                                        arguments: SearchPage(
                                          datalist: controller.allProducts,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              "Search for products...",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          Icon(Icons.tune, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ---------------- PRODUCT LIST ----------------
                    Obx(() {
                      if (controller.isProductLoading.value) {
                        return const SliverToBoxAdapter();
                      }

                      final items = [
                        SizedBox(
                          height: Dimesion.height40 + 90,
                        ), // leave space for slider
                        ShopCategoryWidget(controller: controller),
                        SizedBox(height: Dimesion.height10),
                        Shopbrand(controller: controller),
                        SizedBox(height: Dimesion.height5),
                        Newproduct(controller: controller),
                        PopularProduct(controller: controller),
                        AllProductWidget(controller: controller),
                        SizedBox(height: 120),
                        if (controller.isProductMoreLoading.value)
                          SizedBox(
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryClr,
                              ),
                            ),
                          ),
                      ];

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => items[index],
                          childCount: items.length,
                        ),
                      );
                    }),
                  ],
                ),

                // ---------------- FLOATING SLIDER ----------------
                // ---------------- FLOATING SLIDER (FADE OUT) ----------------
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: 0,
                  right: 0,
                  // banner ၏ နေရာသည် fixed ဖြစ်နေမည်။
                  top: Dimesion.screenHeight / 4 - 10,
                  height: Dimesion.height40 + 90,
                  child: AnimatedOpacity(
                    // opacity က _showSlider တန်ဖိုးအပေါ် မူတည်ပြီး ၀ သို့မဟုတ် ၁ ဖြစ်မည်။
                    opacity: _showSlider ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: IgnorePointer(
                      ignoring: !_showSlider,
                      child: ShopSliderWidget(controller: controller),
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

// --------------------------------------------------------------------------
// SLIDER WIDGET
// --------------------------------------------------------------------------
class ShopSliderWidget extends StatelessWidget {
  final ProductController controller;
  const ShopSliderWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = 0.obs;

    return Obx(() {
      if (controller.bannerList.isEmpty) return const SizedBox.shrink();

      return SizedBox(
        height: 200, // FIX: Prevent overflow
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 6,
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                  },
                ),
                items:
                    controller.bannerList.map((item) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimesion.width5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(Dimesion.width10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimesion.radius10,
                          ),
                          child: MyCacheImg(
                            url: item.image.toString(),
                            boxfit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 10),
            // Indicator
            Obx(() {
              return AnimatedSmoothIndicator(
                activeIndex: currentIndex.value,
                count: controller.bannerList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  dotColor: Colors.grey.shade300,
                  activeDotColor: AppColor.primaryClr,
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:spjewellery/screens/chat_screen/chat_screen.dart';
import 'package:spjewellery/screens/nav/cart.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import 'brands.dart';
import 'categorys.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  final ProductController controller = Get.find<ProductController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.primaryClr,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              centerTitle: true,
              title: Text(
                "category".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimesion.font16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.to(() => CartPage()),
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: HexColor("#E6A9B0"),
                    indicatorWeight: 2.5,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [Tab(text: "category".tr), Tab(text: "brand".tr)],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              CategoryWidget(controller: controller),
              BrandWidget(controller: controller),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => ChatScreen());
            },
            backgroundColor: AppColor.primaryClr,
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
        );
      },
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/nav/profile.dart';
import 'package:spjewellery/screens/nav/shop.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../force_update.dart';
import 'cart.dart';
import 'category.dart';
import 'home.dart';
import 'nav_controller.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final productController = Get.find<ProductController>();
  final navController = Get.find<NavController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdatesAndShowCustomDialog(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NavController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            backgroundColor: AppColor.primaryClr,
            bottomNavigationBar: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Obx(
                  () => MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: SizedBox(
                      child: BottomNavigationBar(
                        showUnselectedLabels: true,
                        backgroundColor: Colors.white,
                        showSelectedLabels: true,
                        onTap: controller.changeTabIndex,
                        currentIndex: controller.tabIndex.value,
                        unselectedItemColor: AppColor.black.withOpacity(0.7),
                        selectedItemColor: AppColor.primaryClr,
                        items: [
                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/img/home.png"),
                              size: Dimesion.size24,
                            ),
                            label: "blog".tr,
                            activeIcon: Container(
                              width: 60.0,
                              padding: EdgeInsets.only(top: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: ImageIcon(
                                AssetImage("assets/img/home.png"),
                                size: Dimesion.size24,
                                color: AppColor.red,
                              ),
                            ),
                          ),

                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/img/shop_f.png"),
                              size: Dimesion.size24,
                            ),
                            label: "shop".tr,
                            activeIcon: Container(
                              width: 60.0,
                              padding: EdgeInsets.only(top: 7.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: ImageIcon(
                                AssetImage("assets/img/shop_f.png"),
                                size: Dimesion.size24,
                                color: AppColor.red,
                              ),
                            ),
                          ),

                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/img/category.png"),
                              size: Dimesion.size24,
                            ),
                            label: "category".tr,
                            activeIcon: Container(
                              width: 60.0,
                              padding: EdgeInsets.only(top: 7.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: ImageIcon(
                                AssetImage("assets/img/category.png"),
                                size: Dimesion.size24,
                                color: AppColor.red,
                              ),
                            ),
                          ),

                          BottomNavigationBarItem(
                            icon: Badge(
                              padding: const EdgeInsets.all(3),
                              alignment: Alignment.topRight,
                              label: Text(
                                navController.cartController.cartList.length !=
                                        0
                                    ? navController.cartController.totalQty
                                        .toString()
                                    : "",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                              backgroundColor:
                                  navController
                                              .cartController
                                              .cartList
                                              .length !=
                                          0
                                      ? Colors.red
                                      : Colors.transparent,
                              child: Icon(
                                Icons.shopping_cart,
                                size: Dimesion.size24,
                              ),
                            ),
                            label: "my_cart".tr,
                            activeIcon: Container(
                              width: 60.0,
                              padding: EdgeInsets.only(top: 7.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Badge(
                                // Ensure Badge is also wrapped for consistency
                                padding: const EdgeInsets.all(3),
                                alignment: Alignment.topRight,
                                label: Text(
                                  navController
                                              .cartController
                                              .cartList
                                              .length !=
                                          0
                                      ? navController.cartController.totalQty
                                          .toString()
                                      : "",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                                backgroundColor:
                                    navController
                                                .cartController
                                                .cartList
                                                .length !=
                                            0
                                        ? Colors.red
                                        : Colors.transparent,
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: AppColor.red,
                                  size: Dimesion.size24,
                                ),
                              ),
                            ),
                          ),

                          // BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/img/account.png"),
                          // size: Dimesion.size24,),
                          // label: "Account".tr,
                          //  backgroundColor: AppColor.white,
                          //  activeIcon: ImageIcon(AssetImage("assets/img/account.png"),
                          //  size: 24,)
                          //  ),

                          // Category Tab
                          BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/img/account.png"),
                              size: Dimesion.size24,
                            ),
                            label: "account".tr,
                            activeIcon: Container(
                              width: 60.0,
                              padding: EdgeInsets.only(top: 7.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: ImageIcon(
                                AssetImage("assets/img/account.png"),
                                size: Dimesion.size24,
                                color: AppColor.red,
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
            body: IndexedStack(
              index: navController.tabIndex.value,
              children: [
                const HomePage(),
                const ShopPage(),
                const CategoryPage(),
                CartPage(),
                const ProfilePage(),
              ],
            ),
          ),
        );
      },
    );
  }

  void showNoInterNet() {
    setState(() {
      navController.noInterNet.value = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                'No, Internet Connection',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
          ],
        ),
        backgroundColor: AppColor.blackless,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showRestoreInternet() {
    productController.init();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.wifi, color: Colors.white),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                'Internet Connection Restored',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppColor.blackless,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

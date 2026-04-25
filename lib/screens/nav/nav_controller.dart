import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spjewellery/controllers/cart_controller.dart';
import 'package:spjewellery/screens/nav/profile.dart';
import 'package:spjewellery/screens/nav/shop.dart';

import '../../controllers/checkout_controller.dart';
import '../../services/pref_service.dart';
import 'cart.dart';
import 'category.dart';
import 'home.dart';

class NavController extends GetxController {
  var tabIndex = 0.obs;

  final CartController cartController = Get.find<CartController>();
  RxBool noInterNet = false.obs;

  List<Widget> screens =
      <Widget>[
        const HomePage(),
        const ShopPage(),
        const CategoryPage(),
        CartPage(),
        ProfilePage(),
      ].obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    noInterNet.value = false;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*Future<bool> checkLoginOrNot() async {
    var token = await prefService.getAppToken();
    if (token.isEmpty) {
      return false;
    } else {
      return true;
    }
  }*/
}

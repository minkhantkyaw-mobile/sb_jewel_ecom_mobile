import 'package:get/get.dart';
import 'package:spjewellery/screens/advertisement_page.dart';
import 'package:spjewellery/screens/chat_screen/chat_screen.dart';
import 'package:spjewellery/screens/menu/my_point.dart';
import 'package:spjewellery/screens/no_internet_page.dart';
import 'package:spjewellery/screens/order_his_screen/point_his_screen.dart';
import 'package:spjewellery/screens/product_detail_screen/product_exchange_detail_screen.dart';

import '../core/app_widgets/view_all_images.dart';
import '../core/app_widgets/view_image_screen.dart';
import '../screens/auth/forgot_pass.dart';
import '../screens/auth/login.dart';
import '../screens/auth/profile_update.dart';
import '../screens/auth/register.dart';
import '../screens/auth/verify_otp.dart';
import '../screens/checkout_screen/checkout_widgets/select_order_screen.dart';
import '../screens/checkout_screen/checkout_widgets/success_screen.dart';
import '../screens/checkout_screen/confirm_checkout_screen.dart';
import '../screens/checkout_screen/pay_now_check_out_screen.dart';
import '../screens/filter_page.dart';
import '../screens/menu/change_password.dart';
import '../screens/menu/contact_us.dart';
import '../screens/menu/fav_screen.dart';
import '../screens/menu/privacy.dart';
import '../screens/menu/update_password.dart';
import '../screens/nav/category_brand_page.dart';
import '../screens/nav/nav_screen.dart';
import '../screens/nav/newfeed_detail.dart';
import '../screens/noti/noti.dart';
import '../screens/order_his_screen/order_his_detail_screen.dart';
import '../screens/order_his_screen/order_his_screen.dart';
import '../screens/product_detail_screen/product_detail_screen.dart';
import '../screens/search_page.dart';
import '../screens/splash.dart';
import '../screens/nav/sub_category.dart';
import '../screens/nav/all_product.dart';

class RouteHelper {
  static const String splash = "/splash";
  static const String main = "/main";
  static const String nav = "/nav";
  static const String feeddetail = "/feeddetail";
  static const String noti = "/noti";
  static const String search = "/search";
  static const String filter = "/filter";
  static const String orderhistory = "/orderhistory";
  static const String product_detail = "/product_detail";
  static const String confirmCheckoutScreen = "/confirmCheckoutScreen";
  static const String payNowCheckOutScreen = "/payNowCheckOutScreen";
  static const String selectDeliveryScreen = "/selectDeliveryScreen";
  static const String success = "/success";
  static const String fav = "/fav";
  static const String login = "/login";
  static const String register = "/register";

  static const String changePass = "/changePass";
  static const String updatePass = "/updatePass";

  static const String forgotPass = "/forgotPass";
  static const String verifyOTP = "/verifyOTP";
  static const String profileUpdate = "/profileUpdate";

  static const String orderHistoryDetail = "/orderHistoryDetail";
  static const String view_Image = "/view_Image";
  static const String view_Images = "/view_Images";
  static const String category_brand = "/category_brand";
  static const String privacy = "/privacy";
  static const String contact_us = "/contact_us";
  static const String chat = "/chat";
  static const String myPoint = "/myPoint";
  static const String productexchangeDetail = "/productexchangeDetail";
  static const String pointHistory = "/pointHistory";
  static const String advertisement = "/advertisement";

  static const String noInternet = "/noInternet";
  static const String selectTownShip = "/selectTownShip";

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: nav,
      page: () => const NavScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: chat,
      page: () => const ChatScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: noti,
      page: () => const NotiPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: myPoint,
      page: () => const MyPointPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: search,
      page: () {
        Get.arguments;
        SearchPage searchPage = Get.arguments;
        return searchPage;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: filter,
      page: () => const FilterPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: login,
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: register,
      page: () => RegisterPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: orderhistory,
      page: () => const OrderHisScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: changePass,
      page: () => ChangePasswordPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: forgotPass,
      page: () => ForgotPassPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: verifyOTP,
      page: () => VerifyOtpPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: orderHistoryDetail,
      page: () {
        Get.arguments;
        OrderHisDetailScreen orderhisDetail = Get.arguments;
        return orderhisDetail;
      },
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: product_detail,
      page: () {
        Get.arguments;
        ProductDetailScreen detailPage = Get.arguments;
        return detailPage;
      },
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: productexchangeDetail,
      page: () {
        Get.arguments;
        ProductExchangeDetailScreen detailPage = Get.arguments;
        return detailPage;
      },
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: feeddetail,
      page: () {
        Get.arguments;
        NewfeedDetailPage newfeedDetailPage = Get.arguments;
        return newfeedDetailPage;
      },
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: profileUpdate,
      page: () {
        Get.arguments;
        UpdateProfilePage updateProfile = Get.arguments;
        return updateProfile;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: selectDeliveryScreen,
      page: () => const SelectDeliveryScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    // Success Checkout
    GetPage(
      name: success,
      // page: () => const SuccessScreen(),
      page: () {
        Get.arguments;
        SuccessScreen successCheckout = Get.arguments;
        return successCheckout;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: fav,
      page: () => FavScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: contact_us,
      page: () => const ContactScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: updatePass,
      page: () => UpdatePasswordPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: view_Image,
      page: () {
        Get.arguments;
        ViewImagePage updateProfile = Get.arguments;
        return updateProfile;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: view_Images,
      page: () {
        Get.arguments;
        ViewAllImagesScreen updateProfile = Get.arguments;
        return updateProfile;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: category_brand,
      page: () {
        Get.arguments;
        CategoryBrandPage page = Get.arguments;
        return page;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),

    GetPage(
      name: confirmCheckoutScreen,
      page: () {
        Get.arguments;
        ConfirmCheckoutScreen confirmCheckoutScreen = Get.arguments;
        return confirmCheckoutScreen;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: payNowCheckOutScreen,
      page: () {
        Get.arguments;
        PayNowCheckOutScreen noticBoardDetailScreen = Get.arguments;
        return noticBoardDetailScreen;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: privacy,
      page: () => const PrivacyPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),

    GetPage(
      name: pointHistory,
      page: () => const PointHisScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: advertisement,
      page: () {
        Get.arguments;
        AdvertisementScreen advertisement = Get.arguments;
        return advertisement;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: noInternet,
      page: () => const NoInternetPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
  ];
}

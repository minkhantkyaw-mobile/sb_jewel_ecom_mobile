import 'package:get/get.dart';
import 'package:spjewellery/screens/chat_screen/chat_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';
import '../controllers/fav_controller.dart';
import '../controllers/order_his_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/search_controller.dart';
import '../core/constants/api_route_constants.dart';
import '../repository/auth_repo.dart';
import '../repository/cart_repo.dart';
import '../repository/check_out_repo.dart';
import '../repository/fav_repo.dart';
import '../repository/order_his_repo.dart';
import '../repository/product_repo.dart';
import '../repository/search_repo.dart';
import '../screens/nav/nav_controller.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class AppBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    Get.put<PrefService>(
      PrefService(sharedPreferences: sharedPreferences),
      permanent: true,
    );
    //*Api Client
    Get.put<ApiClient>(
      ApiClient(
        appBaseUrl: RouteConstant.baseUrl,
        sharedPreferences: sharedPreferences,
      ),
      permanent: true,
    );
    Get.put(
      AuthRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>(),
      ),
      permanent: true,
    );

    Get.put(
      ProductRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>(),
      ),
      permanent: true,
    );
    Get.put(SearchRepo(apiClient: Get.find<ApiClient>()), permanent: true);
    Get.put(
      CartRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>(),
      ),
      permanent: true,
    );

    Get.put(OrderHisRepo(apiClient: Get.find<ApiClient>()), permanent: true);
    Get.lazyPut(
      () => CheckOutRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>(),
      ),
    );
    Get.put(
      NotiRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>(),
      ),
    );

    Get.put(AuthController(authRepo: Get.find<AuthRepo>()), permanent: true);

    Get.put(NotiController(favRepo: Get.find<NotiRepo>()), permanent: true);
    Get.put(CartController(cartRepo: Get.find<CartRepo>()), permanent: true);
    Get.put(
      CheckOutController(
        checkOutRepo: Get.find<CheckOutRepo>(),
        cartController: Get.find<CartController>(),
      ),
    );

    Get.put(NavController(), permanent: true);
    Get.put(ChatController(), permanent: true);

    Get.put(
      ProductController(
        productRepo: Get.find<ProductRepo>(),
        cartController: Get.find<CartController>(),
        authController: Get.find<AuthController>(),
        navController: Get.find<NavController>(),
      ),
      permanent: true,
    );
    Get.put(
      MySearchController(searchRepo: Get.find<SearchRepo>()),
      permanent: true,
    );
    Get.put(OrderHisController(orderHisRepo: Get.find<OrderHisRepo>()));
  }
}

class RouteConstant {
  // static const String mainBaseUrl = "https://mpp.ecommyanmar.com/";
  static const String mainBaseUrl = "https://sb-jewel.hapeyeapp.com/";

  static const String baseUrl = mainBaseUrl + apiV;
  static const String apiUrl = "$baseUrl/$apiV";
  // static const String base_ChatUrl =
  //     "https://mpp.ecommyanmar.com/";

  static const String base_ChatUrl =
      "https://sb-jewel.hapeyeapp.com/chatify/api/";

  // static const String chat_storage_url =
  //     "https://mpp.ecommyanmar.com/";
  static const String chat_storage_url =
      "https://sb-jewel.hapeyeapp.com/storage/attachments/";
  static const String pusher = "pusher-account";

  static const String apiV = "api/v1/";
  static const String login = "login";
  static const String logout = "logout";
  static const String deleteAccount = "delete-account";
  static const String register = "register";
  static const String customer = "customer";
  static const String update_profile = "customer?_method=PUT";
  static const String change_password = "customer/update-password?_method=PUT";
  static const String posts = "posts";
  static String regions = "regions";
  static String banners = "banners";
  static String socialMedia = "social-media";

  static const String contactDetail = "contact-detail";
  static String deliveryFee = "delivery-fees";
  static String wishlist = "wishlist";
  static String point_setting = "point-setting";
  static String withdraw_requests = "withdraw-requests";
  static String notifications = "notifications";
  static String cart = "cart/list";
  static String cart_clear = "all-carts/clear";
  static String cartUpdate({required int id}) => "cart/$id";
  static String addToCart({
    required int productId,
    required int quantity,
    int? sizeID,
  }) => "cart/add?product_id=$productId&quantity=$quantity&size_id=$sizeID";

  static String addToCartWithParams(Map<String, dynamic> params) {
    return "cart/add";
  }

  static String subCategoryByProducts = "/";
  static String wishlist_change = "wishlist/change";
  static String notiRead({required String id}) => "notifications/$id/read";
  static String township({required int id}) => "delivery-fees/regions/$id";
  static String comment({required int id}) => "posts/$id/comment";

  //*Banner
  static const String banner = "dashboard/banners";
  static String updateBanner({required int bannerid}) =>
      "dashboard/banners/$bannerid";

  //*Variations
  static String getVariatrions({required int page, required String keywords}) =>
      "variations?keyword=$keywords&page=$page";
  static String updateVariation({required int id, required String val}) =>
      "variations/$id?name=$val";
  static String deleteVariation({required int id}) => "variations/$id";
  static String createVariation = "dashboard/variations";
  //*Products
  static String getProducts({required String page, required String limit}) =>
      "products?page=$page&limit=$limit";

  static String getPropularProducts({
    required String page,
    required String limit,
  }) => "popular/product?page=$page&limit=$limit";

  static String getnewproducts({required String page, required String limit}) =>
      "popular/product?page=$page&limit=$limit";

  static String getExchangeProducts({
    required String page,
    required String limit,
  }) => "my-points?page=$page&limit=$limit";

  static String getProductDetail({required int id}) => "products/$id";

  static String getCategory({
    required String page,
    required String limit,
    required int id,
  }) => "products?page=$page&limit=$limit&category_id=$id";

  static String getBrand({
    required String page,
    required String limit,
    required int id,
  }) => "products?page=$page&limit=$limit&brand_id=$id";

  static String getProductsSearch({
    required String page,
    required String limit,
    required String search_key,
  }) => "products?page=$page&limit=$limit&search_key=$search_key";
  static String getPosts({required String page, required String limit}) =>
      "posts?page=$page&limit=$limit";
  static String getPostDetail({required int postID}) => "posts/$postID";

  //* Product Images
  static String forgotpassword = "forgot-password";
  static String verify_forgotpassword = "forgot-password-code/verify";
  static const String update_password = "update-password";

  static String deleteProductImage({required int id}) => "product-images/$id";
  //* Product Voice
  static String orders = "orders";
  static String point_history = "customer/point-history";
  static String getTownShips({required String page, required String limit}) =>
      "township-list?page=$page&limit=$limit";
  static String getSearchTownShips({
    required String page,
    required String limit,
    required String name,
  }) => "township-list?city=$name?page=$page&limit=$limit";
  static String advertisementList = "advertisement/list";
  static String exchange_order = "exchange-orders";

  static String orderDetail({required int id}) => "orders/$id";
  //* Product Variations
  static String createProductVariation = "product-variations";
  static String updateProductVariation({required int id}) =>
      "product-variations/$id";

  //*Brands
  static String brands = "brands";

  //*Member
  static String member = "memberships";

  static String version = "version";

  static String updateBrand({required int id}) => "brands/$id";

  //* Categories
  static String categories = "categories";
  static String upDateCategory({required int id}) => "categories/$id";

  //* SubCategory
  static String subCategory = "sub-categories";

  static String getProductsBySubCategory(int subCategoryId) =>
      "sub-categories/$subCategoryId";

  // //* SubBrandCategory
  // static String subBrand = "sub-brands";

  // static String getProductsByBrandCategory(int subBrandId) =>
  //     "$subBrand/$subBrandId";

  //* Payments
  static String payments = "payments";
}

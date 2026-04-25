import 'package:get/get.dart';

import '../core/constants/api_route_constants.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class ProductRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  ProductRepo({required this.apiClient, required this.prefService});

  Future<Response> getAllProducts({required int page}) async {
    return await apiClient.getData(
      RouteConstant.getProducts(page: page.toString(), limit: '100000000'),
    );
  }

  Future<Response> getPropularProducts({required int page}) async {
    return await apiClient.getData(
      RouteConstant.getPropularProducts(page: page.toString(), limit: '100'),
    );
  }
Future<Response> getnewproducts({required int page}) async {
    return await apiClient.getData(
      RouteConstant.getnewproducts(page: page.toString(), limit: '100'),
    );
  }
  Future<Response> getExchangeProducts({required int page}) async {
    return await apiClient.getData(
      RouteConstant.getExchangeProducts(page: page.toString(), limit: '100'),
    );
  }

  Future<Response> getWishList() async {
    return await apiClient.getData(RouteConstant.wishlist);
  }

  Future<Response> getPointSetting() async {
    return await apiClient.getData(RouteConstant.point_setting);
  }

  Future<Response> getWithdrawRequest({required FormData formData}) async {
    return apiClient.postFormData(RouteConstant.withdraw_requests, formData);
  }


  Future<Response> getAddWishList({required FormData data}) async {
    return await apiClient.postFormData(RouteConstant.wishlist_change, data);
  }

  Future<Response> getProductDetail({required int id}) async {
    return await apiClient.getData(RouteConstant.getProductDetail(id: id));
  }

  Future<Response> getPostDetail({required int id}) async {
    return await apiClient.getData(RouteConstant.getPostDetail(postID: id));
  }

  Future<Response> getComment({required int id, required FormData data}) async {
    return await apiClient.postFormData(RouteConstant.comment(id: id), data);
  }

  Future<Response> getAllPost({required int page}) async {
    return await apiClient.getData(
      RouteConstant.getPosts(page: page.toString(), limit: '10'),
    );
  }

  Future<Response> getBrand() async {
    return await apiClient.getData(RouteConstant.brands);
  }

  Future<Response> getMember() async {
    return await apiClient.getData(RouteConstant.member);
  }

  Future<Response> getVersion() async {
    return await apiClient.getData(RouteConstant.version);
  }

  Future<Response> getBanner() async {
    return await apiClient.getData(RouteConstant.banners);
  }

  Future<Response> getAdvertisement() async {
    return await apiClient.getData(RouteConstant.advertisementList);
  }

  Future<Response> getSocialMedia() async {
    return await apiClient.getData(RouteConstant.socialMedia);
  }
  Future<Response> getCategory() async {
    return await apiClient.getData(RouteConstant.categories);
  }

  // Sub Category
  Future<Response> getSubCategory(int categoryId) async {
    final String url = "${RouteConstant.subCategory}?category_id=$categoryId";
    return await apiClient.getData(url);
  }

  Future<Response> getProductsBySubCategory(int subCategoryId) async {
    return await apiClient.getData(RouteConstant.getProductsBySubCategory(subCategoryId));
  }

  // // Sub Category
  // Future<Response> getBrandCategory(int brandId) async {
  //   final String url = "${RouteConstant.subBrand}?brand_id=$brandId";
  //   return await apiClient.getData(url);
  // }

  // Future<Response> getProductsBySubBrand(int subBrandId) async {
  //   final String url = RouteConstant.getProductsByBrandCategory(subBrandId);
  //   return await apiClient.getData(url);
  // }

  Future<Response> getProductsByBrand({required int brandId,required int page}) async {
    return await apiClient.getData(RouteConstant.getBrand(page: page.toString(), limit: "10", id: brandId));
  }

  /*

  Future<Response> getProductDetail({required int id}) async {
    return await apiClient.getData(RouteConstant.getProductDetail(id: id));
  }



  Future<Response> getProductVariationPrice(
      {required int id, required String variation, required String val}) async {
    return await apiClient.postFormData(RouteConstant.getProductVariations,
        FormData({"product_id": id, "variations[$variation]": val}));
  }*/
}

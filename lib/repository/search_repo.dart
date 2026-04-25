import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../core/constants/api_route_constants.dart';

class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({required this.apiClient});


  Future<Response> getAllProducts({required int page}) async {
    return await apiClient.getData(RouteConstant.getProducts(page: page.toString(), limit: '10'));
  }

  Future<Response> getSearchProducts(
      {required int page,
        required String keywords,
        String? fromPrice,
        String? toPrice}) async {
    return await apiClient.getData(RouteConstant.getProductsSearch(
        page: page.toString(),
        search_key: keywords, limit: '10'));
  }


  Future<Response> getCategoryBrand(
      {required int page,
       required int? id,
       required bool? isCategory}) async {
    if(isCategory==true){
      return await apiClient.getData(RouteConstant.getCategory(page: page.toString(), limit: "10", id: id!));
    }else{
      return await apiClient.getData(RouteConstant.getBrand(page: page.toString(), limit: "10", id: id!));
    }

  }

  Future<Response> getSearchAll(
      {required int page,
        required int? category_id,
        required int? brand_id,
       required String? max_price,
       required String? min_price}) async {
    return await apiClient.getData(getallString(page: page.toString(), limit: "10", category_id: category_id!, brand_id: brand_id!, max_price: max_price!, min_price: min_price!));
  }

  String getallString({required String page, required String limit,required int category_id,required int brand_id,required String max_price,required String min_price}){
    String url="products?page=$page&limit=$limit";
    if(category_id!=-1){
      url=url+"&category_id=$category_id";
    }
    if(brand_id!=-1){
      url=url+"&brand_id=$brand_id";
    }
    if(max_price.toString()!=""){
      url=url+"&max_price=$max_price";
    }
    if(min_price.toString()!=""){
      url=url+"&min_price=$min_price";
    }
    print("AllSearchUrl>>>"+url);
    return url;
  }
}

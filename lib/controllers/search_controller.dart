import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/controllers/product_controller.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../services/toast_service.dart';
import '../models/product_model.dart';
import '../repository/search_repo.dart';

class MySearchController extends GetxController {
  final SearchRepo searchRepo;
  MySearchController({required this.searchRepo});

  RxBool isLoading = false.obs;
  RxBool canLoadMore = false.obs;
  RxList<ProductData> results = <ProductData>[].obs;
  RxList<ProductData> filterList = <ProductData>[].obs;

  final TextEditingController maxController = TextEditingController();
  final TextEditingController minController = TextEditingController();

  final TextEditingController searchController = TextEditingController();
  RxInt page = 1.obs;
  final RefreshController refreshController = RefreshController();
  final ProductController productController = Get.find<ProductController>();

  Future<void> getSearchProducts({
    required bool isLoadMore,
    String? from,
    String? to,
  }) async {
    if (!isLoadMore) {
      isLoading.value = true;
    }
    try {
      var response = await searchRepo.getSearchProducts(
        page: page.value,
        keywords: searchController.text,
        fromPrice: from ?? "",
        toPrice: to ?? "",
      );

      if (response.statusCode == 200) {
        ProductModel productModel = ProductModel.fromJson(response.body);
        results.addAll(productModel.data!);
        canLoadMore.value = productModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getByCategoryBrand({
    required bool isCategory,
    required int? id,
  }) async {
    isLoading.value = true;

    try {
      var response = await searchRepo.getCategoryBrand(
        page: page.value,
        id: id,
        isCategory: isCategory,
      );

      if (response.statusCode == 200) {
        ProductModel productModel = ProductModel.fromJson(response.body);
        results.assignAll(productModel.data!);
        canLoadMore.value = productModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      results.clear();
      //ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllProducts({required bool isLoadmore}) async {
    isLoading.value = true;

    try {
      final response = await searchRepo.getAllProducts(page: page.value);
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        results.assignAll(productModel.data!);
        isLoading.value = false;

        canLoadMore.value = productModel.canLoadMore!;
        print("CanLoadMore>>>>" + canLoadMore.value.toString());

        // change(allProducts, status: RxStatus.success());
      } else {
        // change(allProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      //change(allProducts, status: RxStatus.error(e.toString()));
    } finally {
      isLoading.value = false;
      refreshController.loadComplete();
    }
  }

  Future<void> getSearchAll({
    required int category_id,
    required int brand_id,
  }) async {
    isLoading.value = true;

    try {
      var response = await searchRepo.getSearchAll(
        page: page.value,
        category_id: category_id,
        brand_id: brand_id,
        max_price: maxController.text,
        min_price: minController.text,
      );

      if (response.statusCode == 200) {
        ProductModel productModel = ProductModel.fromJson(response.body);
        filterList.assignAll(productModel.data!);
        canLoadMore.value = productModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    page.value = 1;
    getAllProducts(isLoadmore: false);
    /* if (fromPrice.value != 0.0 || toPrice.value != 0.0) {
      getSearchProducts(
          isLoadMore: false,
          from: (fromPrice.value * 1000).toString(),
          to: (toPrice.value * 1000).toString());
    } else {
      getSearchProducts(isLoadMore: false);
    }*/
  }

  Future<void> onLoading() async {
    if (canLoadMore.value == true) {
      page.value++;

      try {
        final response = await searchRepo.getAllProducts(page: page.value);
        print(response.body.toString());
        if (response.statusCode == 200) {
          final ProductModel productModel = ProductModel.fromJson(
            response.body,
          );
          results.addAll(productModel.data!);
          productController.allProducts.addAll(productModel.data!);
          isLoading.value = false;

          canLoadMore.value = productModel.canLoadMore!;
        } else {
          //change(allProducts, status: RxStatus.error(response.bodyString));
        }
      } catch (e) {
        // change(allProducts, status: RxStatus.error(e.toString()));
      } finally {
        isLoading.value = false;
      }
    } else {
      print("Load");
      refreshController.loadNoData();
    }
    refreshController.loadComplete();
  }

  //* Filter ------->

  RxDouble fromPrice = 0.0.obs;
  RxDouble toPrice = 0.0.obs;

  onChangeSlider(RangeValues val) {
    fromPrice.value = val.start;
    toPrice.value = val.end;
  }
}

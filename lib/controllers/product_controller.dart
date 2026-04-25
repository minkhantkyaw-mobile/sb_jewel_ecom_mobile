import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:lottie/lottie.dart';
import 'package:spjewellery/models/advertisement_model.dart';
import 'package:spjewellery/models/exchange_model.dart';
import 'package:spjewellery/models/membership_model.dart';
import 'package:spjewellery/models/point_setting.dart';
import 'package:spjewellery/models/social_media_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_widgets/custom_loading_widget.dart';
import '../core/constants/app_color.dart';
import '../models/banner_model.dart';
import '../models/brand_model.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/post_detail_model.dart';
import '../models/post_model.dart';
import '../models/product_detail.dart';
import '../models/product_model.dart';
import '../models/version_model.dart';
import '../models/wish_list_model.dart';
import '../repository/product_repo.dart';
import '../screens/nav/nav_controller.dart';
import '../services/toast_service.dart';
import 'auth_controller.dart';
import 'cart_controller.dart';

class ProductController extends GetxController with StateMixin {
  final ProductRepo productRepo;
  final CartController cartController;
  final AuthController authController;
  final NavController navController;
  ProductController({
    required this.productRepo,
    required this.cartController,
    required this.authController,
    required this.navController,
  });
  RxBool isFavorite = false.obs;
  RxBool isReply = false.obs;
  RxInt parent_id = 0.obs;

  RxInt replyID = 0.obs;

  RxInt page = 1.obs;
  RxInt pageExchange = 1.obs;

  RxInt imgIndex = 0.obs;

  RxBool isProductLoading = false.obs;
  RxBool isPropularLoading = false.obs;

  final CarouselSliderController carouselController =
      CarouselSliderController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController replyController = TextEditingController();

  RxList<ProductData> allProducts = <ProductData>[].obs;
  RxList<ProductData> allPopularProducts = <ProductData>[].obs;

  RxList<ProductData> exchangeProducts = <ProductData>[].obs;

  RxList<PostData> allPosts = <PostData>[].obs;
  var brandError = "".obs;

  RxInt allProductPage = 1.obs;
  RxInt popularPage = 1.obs;

  RxBool allProductCanloadMore = false.obs;
  RxBool popularProductCanloadMore = false.obs;

  String productValueVariation = "";

  Rx<VariationCart> chooseVariationSelect = VariationCart().obs;
  Rx<VolumePrices> chooseWholeSaleSelect = VolumePrices().obs;

  Future<void> getAllProducts({required bool isLoadmore}) async {
    page.value = 1;
    try {
      final response = await productRepo.getAllProducts(page: page.value);
      print(response.body.toString());
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        allProducts.assignAll(productModel.data!);
        isProductLoading.value = false;

        allProductCanloadMore.value = productModel.canLoadMore!;
        change(allProducts, status: RxStatus.success());
      } else {
        change(allProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(allProducts, status: RxStatus.error(e.toString()));
    } finally {
      isProductLoading.value = false;
    }
  }

  Future<void> getPropularProducts({required bool isLoadmore}) async {
    popularPage.value = 1;
    try {
      final response = await productRepo.getPropularProducts(page: page.value);
      print(response.body.toString());
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        allPopularProducts.assignAll(productModel.data!);
        isPropularLoading.value = false;

        popularProductCanloadMore.value = productModel.canLoadMore!;
        change(allPopularProducts, status: RxStatus.success());
      } else {
        change(allPopularProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(allPopularProducts, status: RxStatus.error(e.toString()));
    } finally {
      isPropularLoading.value = false;
    }
  }

  // CONTROLLER VARIABLES
  RxList<ProductData> allNewProducts = <ProductData>[].obs;
  RxInt newPage = 1.obs;
  RxBool isNewLoading = false.obs;
  RxBool newProductCanLoadMore = true.obs;

  // FETCH NEW PRODUCTS
  Future<void> getNewProducts({required bool isLoadMore}) async {
    if (!isLoadMore) {
      // reset for fresh load
      newPage.value = 1;
      allNewProducts.clear();
      newProductCanLoadMore.value = true;
    }

    if (!newProductCanLoadMore.value) return; // stop if no more pages

    isNewLoading.value = true;

    try {
      final response = await productRepo.getnewproducts(page: newPage.value);

      print(response.body.toString());

      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);

        if (isLoadMore) {
          allNewProducts.addAll(productModel.data!); // append for load more
        } else {
          allNewProducts.assignAll(productModel.data!); // fresh load
        }

        newProductCanLoadMore.value = productModel.canLoadMore!;
        newPage.value++; // increment page for next fetch
        change(allNewProducts, status: RxStatus.success());
      } else {
        change(allNewProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(allNewProducts, status: RxStatus.error(e.toString()));
    } finally {
      isNewLoading.value = false;
    }
  }

  RxBool isProductMoreLoading = false.obs;

  Future<List<ProductData>> onLoadMoreProduct() async {
    print("LoadMore");
    await Future.delayed(const Duration(milliseconds: 100));
    if (allProductCanloadMore.value) {
      page.value++;
      isProductMoreLoading.value = true;

      try {
        final response = await productRepo.getAllProducts(page: page.value);
        print(response.body.toString());
        if (response.statusCode == 200) {
          final ProductModel productModel = ProductModel.fromJson(
            response.body,
          );
          allProducts.addAll(productModel.data!);
          isProductMoreLoading.value = false;

          allProductCanloadMore.value = productModel.canLoadMore!;
          change(allProducts, status: RxStatus.success());
        } else {
          change(allProducts, status: RxStatus.error(response.bodyString));
        }
      } catch (e) {
        change(allProducts, status: RxStatus.error(e.toString()));
      } finally {
        isProductMoreLoading.value = false;
      }
    } else {}
    return allProducts;
  }

  RxList<ProductData> favList = <ProductData>[].obs;
  RxBool isFavLoading = false.obs;

  Future<void> getWishList() async {
    isFavLoading.value = true;
    try {
      final response = await productRepo.getWishList();
      if (response.statusCode == 200) {
        final WishListModel wishListModel = WishListModel.fromJson(
          response.body,
        );
        favList.assignAll(wishListModel.data!);

        change(favList, status: RxStatus.success());
        isFavLoading.value = false;
      } else if (response.statusCode == 404) {
        print(response.statusCode.toString());
        favList.clear();
        change(favList, status: RxStatus.error(response.bodyString));
        isFavLoading.value = false;
      }
    } catch (e) {
      change(favList, status: RxStatus.error(e.toString()));
    } finally {
      isFavLoading.value = false;
    }
  }

  Future<void> addWishList({required int id}) async {
    BotToast.showCustomLoading(
      toastBuilder: (_) => const CustomLoadingWidget(),
    );
    FormData formData = FormData({"product_id": id.toString()});
    try {
      final response = await productRepo.getAddWishList(data: formData);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Favourite");
        getWishList();
        getAllProducts(isLoadmore: false);
        getPropularProducts(isLoadmore: false);
        getNewProducts(isLoadMore: false);
        BotToast.closeAllLoading();
      } else {
        BotToast.closeAllLoading();
      }
    } catch (e) {
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Rx<ProductData> productData = ProductData().obs;
  Rx<ProductData> productDataIndex = ProductData().obs;

  RxBool isDetailLoading = false.obs;
  RxInt variantPrice = 0.obs;

  var singleProduct = ProductDetailModel().obs;
  Future<ProductData?> getProductDetail({required int id}) async {
    isDetailLoading.value = true;
    productData.value.id = 0;
    try {
      final response = await productRepo.getProductDetail(id: id);
      if (response.statusCode == 200) {
        ProductDetailModel model = ProductDetailModel.fromJson(response.body);
        productData.value = model.product!;
        singleProduct.value = model;
        productDataIndex.value = model.product!;

        change(productData, status: RxStatus.success());
        isDetailLoading.value = false;

        return productData.value;
      } else {
        // isDetailLoading.value=false;

        change(productData, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      // isDetailLoading.value=false;

      change(productData, status: RxStatus.error(e.toString()));
    } finally {
      // isDetailLoading.value=false;
      isDetailLoading.value = false;
    }
  }

  RxBool canLoadMorePost = false.obs;
  RxInt page_post = 1.obs;
  RxBool postLoading = false.obs;
  Future<void> getAllPosts({required bool isLoadmore}) async {
    postLoading.value = true;
    try {
      final response = await productRepo.getAllPost(page: page_post.value);
      if (response.statusCode == 200) {
        final PostModel postModel = PostModel.fromJson(response.body);
        allPosts.assignAll(postModel.data!);

        canLoadMorePost.value = postModel.canLoadMore!;
        change(allPosts, status: RxStatus.success());
        postLoading.value = false;
      } else {
        change(allPosts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(allPosts, status: RxStatus.error(e.toString()));
    } finally {
      postLoading.value = false;
    }
  }

  RxBool moreLoading = false.obs;

  Future<void> getAllPostsMore({required bool isLoadmore}) async {
    moreLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final response = await productRepo.getAllPost(page: page_post.value);
      print(response.body.toString());
      if (response.statusCode == 200) {
        final PostModel postModel = PostModel.fromJson(response.body);
        allPosts.addAll(postModel.data!);
        canLoadMorePost.value = postModel.canLoadMore!;
        change(allPosts, status: RxStatus.success());
        moreLoading.value = false;
      } else {
        change(allPosts, status: RxStatus.error(response.bodyString));
        moreLoading.value = false;
      }
    } catch (e) {
      change(allPosts, status: RxStatus.error(e.toString()));
      moreLoading.value = false;
    }
  }

  RxList<CategoryData> categorylist = <CategoryData>[].obs;
  RxInt productByCategoryPage = 1.obs;
  RxBool productByCategoryCanloadMore = false.obs;

  Future<void> getAllCategory() async {
    try {
      final response = await productRepo.getCategory();
      if (response.statusCode == 200) {
        final CategoryModel categoryModel = CategoryModel.fromJson(
          response.body,
        );
        categorylist.assignAll(categoryModel.data!);

        change(categorylist, status: RxStatus.success());
      } else {
        change(categorylist, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(categorylist, status: RxStatus.error(e.toString()));
    }
  }

  RxList<SubCategoryData> subCategoryList = <SubCategoryData>[].obs;

  Future<void> getAllSubCategory(int categoryId) async {
    try {
      final response = await productRepo.getSubCategory(categoryId);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.body['data'];
        subCategoryList.assignAll(
          data.map((e) => SubCategoryData.fromJson(e)).toList(),
        );
      } else {
        Get.snackbar("Error", "Failed to load subcategories");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  RxList<ProductData> productListBySubCategory = <ProductData>[].obs;
  RxBool isLoadingProducts = false.obs;

  Future<void> getProductsBySubCategory(int subCategoryId) async {
    isLoadingProducts.value = true;
    try {
      final response = await productRepo.getProductsBySubCategory(
        subCategoryId,
      );

      if (response.statusCode == 200 && response.body['data'] != null) {
        final List<dynamic> data = response.body['data'];
        productListBySubCategory.assignAll(
          data.map((e) => ProductData.fromJson(e)).toList(),
        );
      } else {
        Get.snackbar("Error", "Failed to load subcategory products");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingProducts.value = false;
    }
  }

  RxList<ProductData> productListByBrand = <ProductData>[].obs;
  Future<void> getProductsByBrand(int brandId) async {
    isLoadingProducts.value = true;
    try {
      final response = await productRepo.getProductsByBrand(
        brandId: brandId,
        page: 1,
      );
      print("BrandProduct>>>>" + response.body.toString());
      if (response.statusCode == 200 && response.body['data'] != null) {
        final List<dynamic> data = response.body['data'];
        productListByBrand.assignAll(
          data.map((e) => ProductData.fromJson(e)).toList(),
        );
      } else {
        //Get.snackbar("Error", "Failed to load products");
      }
    } catch (e) {
      // Get.snackbar("Error", e.toString());
    } finally {
      isLoadingProducts.value = false;
    }
  }

  // // Sub Brand List
  // RxList<SubBrandData> subBrandList = <SubBrandData>[].obs;

  // Future<void> getAllBrandCategory(int brandId) async {
  //   try {
  //     final response = await productRepo.getBrandCategory(brandId);

  //     if (response.statusCode == 200 && response.body['message'] != null) {
  //       final List<dynamic> rawList = response.body['message'];
  //       subBrandList.assignAll(
  //         rawList
  //             .map((e) => SubBrandData.fromJson(e))
  //             .where((e) => e.brandId == brandId)
  //             .toList(),
  //       );
  //     } else {
  //       Get.snackbar("Error", "Failed to load sub-brands");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "An error occurred: ${e.toString()}");
  //   }
  // }

  // RxList<ProductData> productListBySubBrand = <ProductData>[].obs;
  // RxBool isLoadingSubBrandProducts = false.obs;

  // Future<void> getProductsBySubBrand(
  //   int subBrandId,
  //   String subBrandName,
  // ) async {
  //   isLoadingSubBrandProducts.value = true;

  //   try {
  //     final response = await productRepo.getProductsBySubBrand(subBrandId);

  //     if (response.statusCode == 200 &&
  //         response.body != null &&
  //         response.body['message'] != null) {
  //       final List<dynamic> rawList = response.body['message'];

  //       final filteredList =
  //           rawList
  //               .map((e) => ProductData.fromJson(e))
  //               .where(
  //                 (p) =>
  //                     p.subBrand?.toLowerCase() == subBrandName.toLowerCase(),
  //               )
  //               .toList();

  //       productListBySubBrand.assignAll(filteredList);
  //     } else {
  //       Get.snackbar("Error", "No products found");
  //       productListBySubBrand.clear();
  //     }
  //   } catch (e) {
  //     Get.snackbar("Exception", e.toString());
  //     productListBySubBrand.clear();
  //   } finally {
  //     isLoadingSubBrandProducts.value = false;
  //   }
  // }

  RxList<BrandData> brandlist = <BrandData>[].obs;
  RxInt productByBrandPage = 1.obs;
  RxBool productByBrandCanloadMore = false.obs;

  Future<void> getAllBrand() async {
    try {
      final response = await productRepo.getBrand();

      print("📩 Brand API Response: ${response.body}");

      if (response.statusCode == 200) {
        final BrandModel brandModel = BrandModel.fromJson(response.body);
        brandlist.assignAll(brandModel.data!);

        change(brandlist, status: RxStatus.success());
      } else {
        print(
          "❌ Brand API Error: ${response.statusCode} -> ${response.bodyString}",
        );
        change(brandlist, status: RxStatus.error(response.bodyString));
      }
    } catch (e, stack) {
      print("❗ Exception in getAllBrand(): $e");
      print("🪜 Stack Trace: $stack"); // helps debug deeply

      change(brandlist, status: RxStatus.error(e.toString()));
    }
  }

  RxList<MemberData> memberList = <MemberData>[].obs;

  Future<void> getMemberData() async {
    try {
      final response = await productRepo.getMember();
      if (response.statusCode == 200) {
        final MemberShipModel memberShipModel = MemberShipModel.fromJson(
          response.body,
        );
        memberList.assignAll(memberShipModel.data!);

        change(memberList, status: RxStatus.success());
      } else {
        change(memberList, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(memberList, status: RxStatus.error(e.toString()));
    }
  }

  RxList<BannerData> bannerList = <BannerData>[].obs;

  Future<void> getBanner() async {
    try {
      final response = await productRepo.getBanner();
      if (response.statusCode == 200) {
        final BannerModel bannerModel = BannerModel.fromJson(response.body);
        bannerList.assignAll(bannerModel.data!);

        change(bannerList, status: RxStatus.success());
      } else {
        change(bannerList, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(bannerList, status: RxStatus.error(e.toString()));
    }
  }

  RxList<AdvertisementData> advertisementList = <AdvertisementData>[].obs;

  Future<List<AdvertisementData>> getAdvertisement() async {
    try {
      final response = await productRepo.getAdvertisement();
      if (response.statusCode == 200) {
        final AdvertisementModel advertisementModel =
            AdvertisementModel.fromJson(response.body);
        advertisementList.assignAll(advertisementModel.data!);

        change(advertisementList, status: RxStatus.success());
        return advertisementList.value;
      } else {
        change(advertisementList, status: RxStatus.error(response.bodyString));
        return advertisementList.value;
      }
    } catch (e) {
      change(advertisementList, status: RxStatus.error(e.toString()));
      return advertisementList.value;
    }
  }

  RxList<SocialMediaData> socialList = <SocialMediaData>[].obs;

  Future<void> getSocialMedia() async {
    try {
      final response = await productRepo.getSocialMedia();
      if (response.statusCode == 200) {
        final SocialMediaModel socialMediaModel = SocialMediaModel.fromJson(
          response.body,
        );
        socialList.assignAll(socialMediaModel.data!);

        change(socialList, status: RxStatus.success());
      } else {
        change(socialList, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(socialList, status: RxStatus.error(e.toString()));
    }
  }

  RxInt pointPerPrice = 0.obs;
  Future<void> getPointSetting() async {
    try {
      final response = await productRepo.getPointSetting();
      if (response.statusCode == 200) {
        PointSetting pointSetting = PointSetting.fromJson(response.body);
        pointPerPrice.value = pointSetting.ksPerPoint!;
      } else {}
    } catch (e) {}
  }

  RxBool isWithDrawLoading = false.obs;
  Future<void> withdrawPoint({
    required String? points,
    required String? payment_id,
    required String? account_number,
    required String? account_name,
    required BuildContext context,
  }) async {
    isWithDrawLoading.value = true;

    FormData formData = FormData({
      "points": points,
      "payment_id": payment_id,
      "account_number": account_number,
      "account_name": account_name,
    });
    try {
      Response response = await productRepo.getWithdrawRequest(
        formData: formData,
      );
      print("WithdrawRespon>>>" + response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 204) {
        ToastService.successToast("Success Withdraw Money");
      } else {
        ToastService.errorToast(response.body["message"]);
      }
      isWithDrawLoading.value = false;
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isWithDrawLoading.value = false;
      Navigator.of(context).pop();
    }
  }

  void showSuccessWithdrawDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent close by tapping outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/thank.json', // put your Lottie file
                  width: 120,
                  height: 120,
                  repeat: false,
                ),
                SizedBox(height: 16),
                Text(
                  "Withdraw Successful 🎉".tr,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  message ?? "Your points have been converted to Money",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK".tr),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getExchangePoint({required bool isLoadmore}) async {
    pageExchange.value = 1;
    try {
      final response = await productRepo.getExchangeProducts(
        page: pageExchange.value,
      );
      print("ExchangeRespon>>>" + response.body.toString());
      if (response.statusCode == 200) {
        final ExchangeModel productModel = ExchangeModel.fromJson(
          response.body,
        );
        exchangeProducts.assignAll(productModel.data!);
        isProductLoading.value = false;

        // allProductCanloadMore.value = productModel.canLoadMore!;
        change(exchangeProducts, status: RxStatus.success());
      } else {
        change(exchangeProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(exchangeProducts, status: RxStatus.error(e.toString()));
    } finally {
      isProductLoading.value = false;
    }
  }
  /*

  Rx<AddToCartModel> toCartModel = AddToCartModel().obs;

  Rx<ProductDetailData> productDetail = ProductDetailData().obs;
  RxBool isFavorite = false.obs;
  RxBool isLoading = false.obs;

  Future<void> getProductDetail({required int id}) async {
    productDetail.value = ProductDetailData();
    resetProductScreen();
    isLoading.value=true;

    try {
      final response = await productRepo.getProductDetail(id: id);

      if (response.statusCode == 200) {
        final ProductDetailModel productDetailModel =
            ProductDetailModel.fromJson(response.body);
        productDetail.value = productDetailModel.data!;
        print("Variant>>>"+response.body.toString());
        isFavorite.value = productDetail.value.isFavourite ?? false;
        productPrice.value =
            productDetailModel.data!.productVariation!.first.sellPrice!;
        _total.value =
        productDetailModel.data!.productVariation!.first.sellPrice!;
        _price.value =
            productDetailModel.data!.productVariation!.first.stockQuantity!;
        avaliableVariations.value = productDetail.value.variations!;
        selectedVIndex.assignAll(List.generate(
            productDetail.value.variations!.length, (index) => 0));
        selectedValues.assignAll(List.generate(
            productDetail.value.variations!.length, (index) => "Select"));
        isLoading.value=false;

      } else {
        ToastService.errorToast("Error ${response.statusText}");
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      //loading();
    }
  }

  final CarouselSliderController carouselController = CarouselSliderController();
  Rx<ProductVariationSearch> productvariation = ProductVariationSearch().obs;
  RxInt imgIndex = 0.obs;
  RxInt currentWHIndex = 0.obs;
  RxInt wholeSaleID = 0.obs;
  RxInt productPrice = 0.obs;
  RxInt _stock = 0.obs;
  RxInt _price = 0.obs;

  final RxInt _total=0.obs;

  RxList<int?> selectedVIndex = <int?>[].obs;
  RxList<String> selectedValues = <String>[].obs;
  RxList<Variation> avaliableVariations = <Variation>[].obs;
  RxBool isGettingVariations = false.obs;
  RxBool isWholeSale = false.obs;
  RxInt selectedVariationId = 0.obs;
  int get select_variant_id => selectedVariationId.value;


  RxString img_code = "".obs;
  int get total => _total.value;
  int get qty => detailQuantity.value;
  int get price => _price.value;
  int get stock => _stock.value;

  RxInt detailQuantity = 1.obs;

  onChangePrice() {
    _price.value = productvariation.value.productVariation!.sellPrice!;
    detailQuantity.value=1;
    _total.value = price * detailQuantity.value;
  }

  changeQuantity({required bool isIncrease}) {
    if (isIncrease == true) {
      detailQuantity.value++;
    } else {
      if (qty > 1) {
        detailQuantity.value--;
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
    _total.value=_price.value*detailQuantity.value;
    _total.value = _price.value * detailQuantity.value;
  }

  Future<void> getProductVariPrice(
      {required String variation, required String val}) async {
    isGettingVariations.value = true;
    isLoading.value=true;
    print("SelectedVariationId variation: $variation");
    print("SelectedVariationId val: $val");

    try {
      final response = await productRepo.getProductVariationPrice(
          id: productDetail.value.product!.id!, variation: variation, val: val);
      if (response.statusCode == 200) {
        final ProductVariationsSearchModel productVariationModel =
            ProductVariationsSearchModel.fromJson(response.body);
        print("Respon>>>"+response.body.toString());
        productvariation.value = productVariationModel.data!;
        selectedVariationId.value = productvariation.value.productVariation!.id!;
        productPrice.value = productVariationModel.data!.productVariation!.sellPrice!;
        _price.value = productVariationModel.data!.productVariation!.sellPrice!;
        _stock.value = productVariationModel.data!.productVariation!.stockQuantity!;
        avaliableVariations.value = productVariationModel.data!.variations!;
        onChangePrice();
        img_code.value=productVariationModel.data!.productVariation!.image!;

        print("SelectedVariationId Select: ${productvariation.value.productVariation!.id!}");
        isLoading.value=false;
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingVariations.value = false;
      isLoading.value=false;

    }
  }

  resetProductScreen() {
    img_code.value="";
    imgIndex.value = 0;
    productPrice.value = 0;
    _total.value=0;
    _stock.value = 0;
    selectedVIndex.value = [];
    wholeSaleID.value=0;
    isWholeSale.value=false;
    selectedVariationId.value=0;
    cartController.detailQuantity.value = 1;
  }


  onSelectColor({int? val, int? vIndex}) {
    print("OnSelectColor: $val");

    selectedVIndex[vIndex!] = val!;
    selectedValues[vIndex] =
        productDetail.value.variations![vIndex].values![val];
    productValueVariation =
        productDetail.value.variations![vIndex].values![val];
    print("OnSelectColor: $productValueVariation");

    cartController.detailQuantity.value = 1;
    getProductVariPrice(
        variation: avaliableVariations[vIndex].name!,
        val: selectedValues[vIndex]);
  }

  onClearSelection() {
    selectedValues.assignAll(List.generate(
        productDetail.value.variations!.length, (index) => "Select"));
    avaliableVariations.value = productDetail.value.variations!;
    cartController.detailQuantity.value = 1;
  }

  onSelectVariations({String? val, int? vIndex}) {
    selectedVIndex[vIndex ?? 0] =
        productDetail.value.variations?[vIndex ?? 0].values?.indexOf(val ?? "");
    selectedValues[vIndex ?? 0] = val ?? "";

    for (int i = 0; i < selectedVIndex.length; i++) {
      if (i != vIndex) {
        // selectedVIndex[i] = null;
        // selectedValues[i] = "Select";
        break;
      }
    }
    cartController.detailQuantity.value = 1;
    getProductVariPrice(
        variation: avaliableVariations[vIndex ?? 0].name ?? "", val: val ?? "");
  }

  bool canAddtoCart({required BuildContext context, required int product_vid}) {
    if (authController.appToken.isEmpty) {
      DialogService.showDialog(
          isDelete: false,
          message: "Please login to continue.",
          dialogType: DialogType.error,
          context: context,
          onContinue: () => Get.toNamed(RouteHelper.login));
      return false;
    } else if (selectedVariationId.value == 0) {
      ToastService.warningToast("Please Select Variant");
      String results = "";
      if (productDetail.value.variations != null) {
        for (var element in productDetail.value.variations!) {
          results += "${element.name!}, ";
        }
      } else {
        ToastService.warningToast("Please select $results");
      }
      return false;
    } else if (productvariation.value.productVariation!.stockQuantity! < 1) {
      ToastService.warningToast("Item is out of stock");
      return false;
    } else {
      return true;
    }
  }


  addFav({required int productId}) async {
    await favController.addFav(productId: productId).then((value) async {
      if (value) {
        isFavorite.value = true;
        await favController.getFavList();
      }
    });
  }

  removeFav({required int productId}) async {
    await favController.removeFav(productId: productId).then((value) async {
      if (value) {
        isFavorite.value = false;
        await favController.getFavList();
      }
    });
  }*/

  RxBool isCommentLoading = false.obs;

  Future<void> comment({
    required int post_id,
    required int user_id,
    required String body,
    required int parient_id,
  }) async {
    var loading = BotToast.showCustomLoading(
      toastBuilder: (_) => const Center(child: CustomLoadingWidget()),
    );
    isCommentLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    FormData formData;
    if (isReply.value == false) {
      formData = FormData({
        "user_id": user_id.toString(),
        "post_id": post_id.toString(),
        "body": body.toString(),
      });
    } else {
      formData = FormData({
        "user_id": user_id.toString(),
        "body": body.toString(),
        "parent_id": parient_id.toString(),
      });
    }

    try {
      Response response = await productRepo.getComment(
        id: post_id,
        data: formData,
      );
      if (response.statusCode == 200) {
        isCommentLoading.value = false;
        commentController.text = "";
        getPostDetail(post_id: post_id);
      } else {
        isCommentLoading.value = false;

        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
      BotToast.closeAllLoading();
    } finally {
      BotToast.closeAllLoading();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Rx<PostData> postData = PostData().obs;
  RxBool isPostLoading = false.obs;

  Future<void> getPostDetail({required int post_id}) async {
    isCommentLoading.value = true;

    try {
      final response = await productRepo.getPostDetail(id: post_id);
      print(response.body.toString());
      if (response.statusCode == 200) {
        final PostsDetailModel postModel = PostsDetailModel.fromJson(
          response.body,
        );
        postData.value = postModel.data!;
        for (var i = 0; i < postData.value.comments!.length; i++) {
          if (postData.value.comments![i].id == parent_id.value) {
            postData.value.comments![i].replyShow = true;
          }
        }
        isCommentLoading.value = false;
        page_post.value = 1;
        getAllPosts(isLoadmore: false);
        // allProductCanloadMore.value = postModel!;
        change(postData.value, status: RxStatus.success());
      } else {
        isCommentLoading.value = false;

        change(postData.value, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(postData.value, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    init();
    //getVersion();

    super.onInit();
  }

  void init() {
    isProductLoading.value = true;
    isPropularLoading.value = true;
    getAllPosts(isLoadmore: true);
    getBanner();
    getAllCategory();
    getAllBrand();
    getPropularProducts(isLoadmore: true);
    getAllProducts(isLoadmore: true);
    getExchangePoint(isLoadmore: true);
    getProductDetail(id: pid);
    getNewProducts(isLoadMore: true);
  }

  Rx<VersionData> versionData = VersionData().obs;
  RxBool isVersionLoading = false.obs;
  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String code = packageInfo.buildNumber;
    isVersionLoading.value = true;

    try {
      Response response = await productRepo.getVersion();
      switch (response.statusCode) {
        case 200:
          VersionModel versionModel = VersionModel.fromJson(response.body);
          versionData.value = versionModel.data!;
          isVersionLoading.value = false;
          if (Platform.isAndroid) {
            if (int.parse(versionData.value.androidVersion!) >
                int.parse(code)) {
              show_update_alert();
            }
          } else if (Platform.isIOS) {
            if (int.parse(versionData.value.iosVersion!) > int.parse(code)) {
              show_update_alert();
            }
          }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  show_update_alert() {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text('New version available !'),
        content: Text(versionData.value.releaseNote.toString()),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'Later',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: Text(
              'Update',
              style: TextStyle(
                color: AppColor.red,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              if (Platform.isAndroid) {
                GooglePlayServicesAvailability availability =
                    await GoogleApiAvailability.instance
                        .checkGooglePlayServicesAvailability();
                if (availability == GooglePlayServicesAvailability.success) {
                  _launchUrl(versionData.value.playstoreLink.toString());
                } else {
                  _launchUrl(versionData.value.androidOtherLink.toString());
                }
                // _launchUrl(url)
                //Navigator.of(context).pop();
              } else {
                _launchUrl(versionData.value.appstoreLink.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

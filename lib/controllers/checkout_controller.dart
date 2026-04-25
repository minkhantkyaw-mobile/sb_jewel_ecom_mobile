import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spjewellery/models/exchange_post_model.dart';
import 'package:spjewellery/models/township_cod_model.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../repository/check_out_repo.dart';
import '../core/app_widgets/custom_loading_widget.dart';
import '../models/cart_model.dart';
import '../models/payment_model.dart';
import '../models/region_model.dart';
import '../models/township_model.dart';
import '../router/route_helper.dart';
import '../screens/checkout_screen/checkout_widgets/success_screen.dart';
import '../screens/checkout_screen/confirm_checkout_screen.dart';
import '../services/cart_save.dart';
import '../services/toast_service.dart';
import 'cart_controller.dart';

class CheckOutController extends GetxController {
  final CheckOutRepo checkOutRepo;
  final CartController cartController;
  CheckOutController({
    required this.checkOutRepo,
    required this.cartController,
  });

  @override
  onInit() {
    getRegions();

    getPayments();
    super.onInit();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController townShipController = TextEditingController();

  RxList<RegionData> regionList = <RegionData>[].obs;
  RxList<CartModel> cartList = <CartModel>[].obs;
  Rx<RegionData> regionData = RegionData().obs;
  Rx<TownShipCodData?> townShipData = TownShipCodData().obs;

  RxInt totalQty = 0.obs;
  RxInt totalAmt = 0.obs;
  RxInt isExchange = 0.obs;
  RxInt exchangePoints = 0.obs;

  RxInt pageTownShip = 1.obs;
  final TextEditingController searchController = TextEditingController();
  final RefreshController refreshController = RefreshController();
  RxBool isLoading = false.obs;
  RxBool canLoadMore = false.obs;
  Future<void> onLoading() async {
    if (canLoadMore.value == true) {
      pageTownShip.value++;
      print("LoadTownShip");
      try {
        final response = await checkOutRepo.getTownShipCOD(
          page: pageTownShip.value,
        );
        print(response.body.toString());
        if (response.statusCode == 200) {
          TownShipCodModel data = TownShipCodModel.fromJson(response.body);
          if (pageTownShip.value == 1) {
            townShipList.assignAll(data.data!);
          } else {
            townShipList.addAll(data.data!);
          }

          canLoadMore.value = data.canLoadMore!;
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

  regionDropdownOnChanged(RegionData val) {
    regionData.value = val;
    selectedRegion.value = val.name!;
    selectedRegionId.value = val.id!;
    townShipList.clear();
    deliState.value = DeliveryState.empty;
    getTownShipCOD(regionId: selectedRegionId.value);
  }

  onChangeTownShip(TownShipCodData val) {
    townShipController.text = val.city.toString();
    townShipData.value = val;
    selectedDeliFee.value = int.parse(val.fee!);
    selectedTownShip.value = val.city.toString();
    selectedDeliveryFeeId.value = val.id!.toInt();
    selectedRegionId.value = val.region!.id!;
    isCold.value = val.cod.toString();
    deliState.value = DeliveryState.empty;
  }

  RxInt selectedRegionId = 0.obs;

  Rx<RegionState> regionState = RegionState.empty.obs;
  Future<void> getRegions() async {
    regionState.value = RegionState.loading;
    try {
      final response = await checkOutRepo.getRegions();
      print(response.body.toString());
      if (response.statusCode == 200) {
        final RegionModel regionModel = RegionModel.fromJson(response.body);
        regionList.assignAll(regionModel.data!);

        regionState.value = RegionState.success;
      }
    } catch (e) {
      regionState.value = RegionState.error;
      ToastService.errorToast(e.toString());
    } finally {
      regionState.value = RegionState.success;
    }
  }

  RxInt selectedDeliveryFeeId = 0.obs;
  RxString selectedRegion = "---".obs;
  RxList<TownShipCodData> townShipList = <TownShipCodData>[].obs;
  RxInt selectedDeliFee = 0.obs;
  RxString isCold = "1".obs;

  Future<void> onRefresh() async {
    pageTownShip.value = 1;
    getTownShipCOD(regionId: selectedRegionId.value);
  }

  Future<void> getSearchTownShip({
    required bool isLoadMore,
    String? name,
  }) async {
    if (!isLoadMore) {
      isLoading.value = true;
    }
    try {
      var response = await checkOutRepo.getSearchTownShipCOD(
        page: pageTownShip.value,
        name: searchController.text,
      );

      if (response.statusCode == 200) {
        TownShipCodModel data = TownShipCodModel.fromJson(response.body);
        townShipList.assignAll(data.data!);
        canLoadMore.value = data.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      //ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Rx<DeliveryState> deliState = DeliveryState.empty.obs;
  Future<void> getTownShipCOD({required int regionId}) async {
    // Prevent multiple simultaneous requests
    if (isLoading.value) return;

    isLoading.value = true;
    deliState.value = DeliveryState.loading;

    try {
      // Call API with regionId and page
      Response response = await checkOutRepo.getDeliveryFee(id: regionId);

      print("TownShipResponse >>> ${response.body}");

      if (response.statusCode == 200) {
        TownShipCodModel data = TownShipCodModel.fromJson(response.body);

        // Pagination: first page replaces, others add
        if (pageTownShip.value == 1) {
          townShipList.assignAll(data.data ?? []);
        } else {
          townShipList.addAll(data.data ?? []);
        }

        canLoadMore.value = data.canLoadMore ?? false;

        // Set delivery state
        if (townShipList.isEmpty) {
          ToastService.warningToast("There is No Township");
          deliState.value = DeliveryState.empty;
        } else {
          deliState.value = DeliveryState.success;
        }
      } else {
        print("This is township error one : ${DeliveryState.error}");

        ToastService.warningToast("Failed to load townships");
        deliState.value = DeliveryState.error;
      }
    } catch (e) {
      print("This is township error : $e");
      ToastService.errorToast(e.toString());
      deliState.value = DeliveryState.error;
    } finally {
      isLoading.value = false;
    }
  }

  Rx<PaymentData> selectedPayment = PaymentData().obs;
  RxList<PaymentData> paymentList = <PaymentData>[].obs;
  RxBool isLoadingPayment = false.obs;
  RxString selectedTownShip = "---".obs;

  Future<void> getPayments() async {
    isLoadingPayment.value = true;
    try {
      Response response = await checkOutRepo.getPayments();
      if (response.statusCode == 200) {
        PaymentModel data = PaymentModel.fromJson(response.body);
        paymentList.assignAll(data.data!);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoadingPayment.value = false;
    }
  }

  onSelectPayment(PaymentData paymentData) {
    selectedPayment.value = paymentData;
  }

  void calculate_total() {
    totalQty.value = 0;
    totalAmt.value = 0;
    for (var i = 0; i < cartList.length; i++) {
      totalQty.value += cartList[i].quantity!;
      totalAmt.value +=
          int.parse(cartList[i].price.toString()) *
          int.parse(cartList[i].quantity.toString());
    }
  }

  // At the top with other Rx variables
  var selectedDeliveryType = 1.obs; // default COD

  Future<void> postOrder({required bool isCod}) async {
    var loading = BotToast.showCustomLoading(
      toastBuilder: (_) => const Center(child: CustomLoadingWidget()),
    );

    try {
      FormData formData;

      if (isCod) {
        formData = FormData({
          "region_id": selectedRegionId.value.toString(),
          "delivery_fee_id": selectedDeliveryFeeId.value.toString(),
          "delivery_fee": selectedDeliFee.value.toString(),
          "name": nameController.text,
          "phone": phoneController.text,
          "address": addressController.text,
          "payment_method": "cod",
          "remark": remarkController.text,
          "is_exchange": isExchange.value,
        });
      } else {
        if (selectedPayment.value == null) {
          ToastService.errorToast("Please select a payment method");
          return;
        }
        if (pickedImagePath == null) {
          ToastService.errorToast("Please upload payment screenshot");
          return;
        }

        formData = FormData({
          "name": nameController.text,
          "address": addressController.text,
          "phone": phoneController.text,
          "payment_method": "payment",
          "payment_id": selectedPayment.value!.id.toString(),
          "payment_photo": await MultipartFile(
            pickedImagePath!.path,
            filename: pickedImagePath!.path.split("/").last,
          ),
          "region_id": selectedRegionId.value.toString(),
          "delivery_fee_id": selectedDeliveryFeeId.value.toString(),
          "delivery_fee": selectedDeliFee.value.toString(),
          "remark": remarkController.text,
          "is_exchange": isExchange.value,
        });
      }
      // print(formData.fields);
      Response response = await checkOutRepo.postOrder(data: formData);

      if (response.statusCode == 200) {
        loading();
        Get.offNamed(RouteHelper.success, arguments: SuccessScreen());
        // removeDataAll();
        clearCart();
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
      loading();
    } finally {
      loading();
    }
  }

  RxList<ExchangePostModel> exchangeData = <ExchangePostModel>[].obs;
  Future<void> postExchangeOrder({required bool isCod}) async {
    String jsonList = jsonEncode(exchangeData.map((e) => e.toJson()).toList());

    var loading = BotToast.showCustomLoading(
      toastBuilder: (_) => const Center(child: CustomLoadingWidget()),
    );
    FormData formData;
    if (isCod) {
      print("CODOrder");
      formData = FormData({
        "region_id": selectedRegionId.value.toString(),
        "delivery_fee_id": selectedDeliveryFeeId.value.toString(),
        "delivery_fee": selectedDeliFee.value.toString(),
        "name": nameController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "payment_method": "cod",
        "remark": remarkController.text,
        "is_exchange": isExchange.value,
        "carts": jsonList,
      });
    } else {
      print("PaymentOrder");
      formData = FormData({
        "name": nameController.text,
        "address": addressController.text,
        "phone": phoneController.text,
        "payment_method": "payment",
        "payment_id": selectedPayment.value.id.toString(),
        "payment_photo": MultipartFile(
          pickedImagePath,
          filename: "payment.png",
        ),
        "region_id": selectedRegionId.value.toString(),
        "delivery_fee_id": selectedDeliveryFeeId.value.toString(),
        "delivery_fee": selectedDeliFee.value.toString(),
        "remark": remarkController.text,
        "is_exchange": isExchange.value,
        "carts": jsonList,
      });
    }

    try {
      Response response = await checkOutRepo.postExchangeOrder(data: formData);
      print("OrderExchangeRespon>>>" + response.body.toString());
      if (response.statusCode == 200) {
        // ToastService.successToast("Successfully Order Create");
        loading();
        Get.offNamed(
          RouteHelper.success,
          arguments: SuccessScreen(
            // isCod: isCod,
            // orderHistoryData: ,
          ),
        );
      } else {
        print("Error>>>" + response.body["message"]);
        ToastService.errorToast(response.body["message"]);
      }
      removeDataAll();
      clearCart();
    } catch (e) {
      ToastService.errorToast(e.toString());
      loading();
    } finally {
      loading();
    }
  }

  // removeDataAll();
  // cartClear();

  void clearCart() {
    cartList.clear();
    totalQty.value = 0;
    totalAmt.value = 0;
    cartController.deleteAllCart();
  }

  File? pickedImagePath;

  XFile? pickedFile;

  final picker = ImagePicker();
  Future<void> pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      XFile image = XFile(pickedFile!.path);
      pickedImagePath = File(image.path);
      update();
    }
  }

  onClearImage() {
    pickedImagePath = null;
    update();
  }

  validateCodForConfirmCheckout() {
    if (townShipData.value!.city.toString() == "null") {
      ToastService.warningToast("Please Select Township");
    } else {
      if (isExchange.value == 0) {
        postOrder(isCod: true);
      } else {
        postExchangeOrder(isCod: true);
      }
    }
  }

  void validatePayNowForConfirmCheckout() {
    print(isExchange.value);
    // Check if township is selected
    if (selectedTownShip.value == null || selectedTownShip.value == "---") {
      ToastService.warningToast("Please Select Township");
      return;
    }

    // Check if a payment method is selected and has a valid ID
    // if (selectedPayment.value == null ||
    //     selectedPayment.value!.id == null ||
    //     selectedPayment.value!.id == 0) {
    //   print("This is selectedPayment>>>${selectedPayment.value.id}");
    //   ToastService.warningToast("Please Select Payment Method");
    //   return;
    // }
    // selectedPayment.value!.id = 1;

    // Proceed with the order
    if (isExchange.value == 0) {
      postOrder(isCod: true);
    } else {
      postExchangeOrder(isCod: false);
    }
  }
}

enum RegionState { loading, success, error, empty }

enum DeliveryState { loading, success, error, empty }


/*
  RxList<DeliveryData> deliveryList = <DeliveryData>[].obs;
  RxString selectedRegion = "---".obs;
  RxString selectedTownShip = "---".obs;

  RxInt selectedTownShipId = 0.obs;
  Rx<DeliveryData> selectedDelivery = DeliveryData().obs;



  onTapTownShip() {
    if (selectedRegion.value == "---") {
      ToastService.warningToast("Please Select Region First");
    }
  }

  Rx<DeliveryState> deliState = DeliveryState.empty.obs;
  Future<void> getDeliveries({required int townId}) async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const Center(
          child: CustomLoadingWidget(),
        ));
    deliState.value = DeliveryState.loading;
    try {
      Response response = await checkOutRepo.getDelivery(townId: townId);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        DeliveryModel data = DeliveryModel.fromJson(response.body);
        deliveryList.assignAll(data.data!);
        if (deliveryList.isEmpty) {
          ToastService.errorToast("This TownShip is No Delivery");
          deliState.value = DeliveryState.empty;
        }
        deliState.value = DeliveryState.success;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      ToastService.errorToast(e.toString());
      deliState.value = DeliveryState.error;
    }
  }

  onChangeDelivery(DeliveryData deliveryData) {
    selectedDelivery.value = deliveryData;
    getSearchDelivery();
  }

  RxBool isLoadingSearch = false.obs;
  Future<void> getSearchDelivery() async {
    isLoadingSearch.value = true;
    try {
      Response response = await checkOutRepo.getSearchDelivery(
          townId: selectedTownShipId.value,
          deliveryId: selectedDelivery.value.id!);
      if (response.statusCode == 200) {
        SearchDeliveryModel data = SearchDeliveryModel.fromJson(response.body);
        searchDeliveryData.value = data.data!;
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoadingSearch.value = false;
    }
  }*/
  //* Reset Checkout Screen ------------->

  /*resetCheckoutSelection() {
    selectedRegion.value = "---";
    selectedTownShip.value = "---";
    selectedDelivery.value = DeliveryData();
    searchDeliveryData.value = SearchDeliveryData();
    townShipList.clear();
    deliveryList.clear();
    deliState.value = DeliveryState.empty;
    nameController.clear();

    phoneController.clear();
    addressController.clear();
  }*/

  //* Get PayMents ----->

  /**/

  //* SelectPaymentImage =============>
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_widgets/custom_loading_widget.dart';
import '../models/noti_model.dart';
import '../models/noti_read_model.dart';
import '../repository/fav_repo.dart';
import '../services/toast_service.dart';

class NotiController extends GetxController {
  final NotiRepo favRepo;

  NotiController({required this.favRepo});

  RxList<NotiData> notiList = <NotiData>[].obs;
  RxBool isload = false.obs;
  RxList<NotiData> unReadList = <NotiData>[].obs;


  Future<void> getNotiList() async {
    isload.value = true;

    try {
      var response = await favRepo.getNoti();
      if (response.statusCode == 200) {
        var data = NotiModel.fromJson(response.body);
        notiList.assignAll(data.data!);
        unReadList.clear();
        for (var i = 0; i < notiList.length; i++) {
          if (notiList[i].readAt == null) {
            unReadList.add(notiList[i]);
          }
        }
        isload.value = false;
        // BotToast.closeAllLoading();
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isload.value = false;
      // BotToast.closeAllLoading();
    }
  }

  Future<void> getNotiListRead({required String id}) async {
    isload.value = true;

    try {
      var response = await favRepo.getNotiRead(id: id);
      if (response.statusCode == 200) {
        NotiReadModel notiReadModel = NotiReadModel.fromJson(response.body);
        getNotiList();
        show_Noti_Detail(notiReadModel.data!);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isload.value = false;
      // BotToast.closeAllLoading();
    }
  }

  show_Noti_Detail(NotiReadData data) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(data.data.toString()),
        content: Text(data.id.toString()),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'OK',
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
        ],
      ),
    );
  }

  /*RxList<FavData> favList = <FavData>[].obs;



  Future<bool> addFav({required int productId}) async {
    bool result = false;
    var loading = BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      var response = await favRepo.addFav(productId: productId);
      if (response.statusCode == 201) {
        result = true;
        ToastService.successToast(response.body["message"]);
      } else {
        result = false;
        ToastService.errorToast("${response.body["message"]}");
      }
    } catch (e) {
      result = false;
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
    return result;
  }

  Future<bool> removeFav({required int productId}) async {
    bool result = false;
    var loading = BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      var response = await favRepo.deleteFav(favId: productId);
      if (response.statusCode == 200) {
        result = true;
        ToastService.successToast(response.body["message"]);
      } else {
        result = false;
        ToastService.errorToast("${response.body["message"]}");
      }
    } catch (e) {
      result = false;
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
    return result;
  }*/
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth_controller.dart';
import '../../models/chat/chat_list_model.dart';
import '../../models/chat/pusher_model.dart';
import 'chat_repo.dart';

class ChatController extends GetxController {
  ChatRepo chatRepo = ChatRepo();
  final AuthController authController = Get.find<AuthController>();

  RxBool canloadMore = false.obs;
  RxBool isLoading = false.obs;

  RxInt productByPage = 1.obs;
  Rx<UnSeenMsgModel> unSeenMsgModel=UnSeenMsgModel().obs;

  var tabIndex = 0.obs;
  RxBool isMsgNew=false.obs;
  RxInt page=1.obs;

  RxList<Messages> msgList = List<Messages>.empty().obs;
  Future<ChatListModel?> getMsg() async {
    ChatListModel chatListModel=new ChatListModel();

    await chatRepo
        .getMessage(token: authController.appToken.value ?? "", id: authController.userData.value.id.toString(), page: page.value)
        .then((value) async {
          if(page.value==1){
            msgList.assignAll(value!.messages!.reversed.toList()!);
          }else{
            msgList.insertAll(0,value!.messages!.reversed.toList()!);
          }
          if(msgList.length<value.total!){
            canloadMore.value=true;
          }else{
            canloadMore.value=false;
          }
          chatListModel=value;
          isLoading(false);
    });
    return chatListModel;

  }


  RxString id = "".obs;
  Future<void> chatSync(String socketId, String channelName) async {
    // print("AppUserID>>>$channelName.${authController.userID}");

    final body = {"socket_id": socketId, "channel_name": channelName};

    await chatRepo
        .chat_auth(token: authController.appToken.value ?? "", body: body)
        .then((value) {
          id.value = value;
          getMsg();
        });
    update();
  }

  File? pickedImagePath;

  XFile? pickedFile;

  final picker = ImagePicker();
  Future<void> pickImage() async {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      XFile image = XFile(pickedFile!.path);
      pickedImagePath = File(image.path);
      sendMsg("", pickedImagePath, 0);
    }
  }

  Future<void> pickCamera() async {
    pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      XFile image = XFile(pickedFile!.path);
      pickedImagePath = File(image.path);
      sendMsg("", pickedImagePath, 0);
    }
  }

  Future<void> sendMsg(String? message, File? file, int? type) async {

    File? pickedImagePath;
    if (file != null) {
      XFile image = XFile(file.path);
      pickedImagePath = File(image.path);
      update();
    }
    FormData formData;
    if (type == 1) {
      formData = FormData({
        "id": "1",
        "type": "user",
        "message": message,
        "temporaryMsgId": "temp_1",
      });
    } else if (type == 3) {
      formData = FormData({
        "id": "1",
        "file": MultipartFile(pickedImagePath, filename: "audmp3"),
        "type": "user",
        "message": message,
        "temporaryMsgId": "temp_1",
      });
    } else {
      formData = FormData({
        "id": "1",
        "file": MultipartFile(pickedImagePath, filename: "file.jpg"),
        "type": "user",
        "message": message,
        "temporaryMsgId": "temp_1",
      });
    }

    await chatRepo
        .sendMessage(token: authController.appToken.value ?? "", body: formData)
        .then((value) {
          getMsg();
          pickedImagePath = null;
        });
    update();
  }
}

import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api_route_constants.dart';
import '../../models/chat/chat_auth_model.dart';
import '../../models/chat/chat_list_model.dart';

class ChatRepo extends GetConnect {
  @override
  // ignore: overridden_fields
  final baseUrl = RouteConstant.base_ChatUrl;

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = baseUrl;
  }

  Future<String> chat_auth({
    required String token,
    required dynamic body,
  }) async {
    final response = await post(
      "chat/auth",
      body,
      headers: {'Authorization': "Bearer $token", "Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      ChatAuthModel chatAuthModel = ChatAuthModel.fromJson(
        jsonDecode(response.body),
      );
      UserChat userChat = UserChat.fromJson(
        jsonDecode(chatAuthModel.channelData.toString()),
      );
      print("ChatAuth>>>${chatAuthModel.auth}");
      return userChat.userId.toString();
    } else {
      return Future.error(
        "it has error in chat_auth${response.statusCode} : ${response.statusText}",
      );
    }
  }

  Future<ChatListModel> getMessage({
    required String token,
    required String id,
    required int page,
  }) async {
    var uri = Uri.parse(
      RouteConstant.base_ChatUrl + "fetchMessages?page=$page",
    );

    print("This is baseUrl>>>${uri.toString()}");
    print("This is authid>>>${id}");

    var response = await http.post(
      uri,
      headers: {'Authorization': "Bearer $token", "Accept": "application/json"},
      body: {'id': '1', 'auth_id': id},
    );

    print("GetMsgRespon>>>" + response.body.toString());
    if (response.statusCode == 200) {
      return ChatListModel.fromJson(jsonDecode(response.body.toString()));
    } else {
      return Future.error(
        "it has error in get message ${response.statusCode} : ${response.body.toString()}",
      );
    }
  }

  Future<String> sendMessage({
    required String token,
    required dynamic body,
  }) async {
    final response = await post(
      "sendMessage",
      body,
      headers: {'Authorization': "Bearer $token", "Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      print("SendRespon>>>${response.body}");
      String msg = "";
      BotToast.showText(text: "Send Success");
      return msg;
    } else {
      return Future.error(
        "it has error sendMessage ${response.statusCode} : ${response.statusText}",
      );
    }
  }
}

class UserChat {
  int? userId;
  UserInfo? userInfo;

  UserChat({this.userId, this.userInfo});

  UserChat.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? name;

  UserInfo({this.name});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

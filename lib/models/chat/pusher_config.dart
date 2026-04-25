// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:spjewellery/models/chat/pusher_model.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/api_route_constants.dart';
import '../../screens/chat_screen/chat_controller.dart';

class PusherConfig {
  late PusherChannelsFlutter _pusher;
  late PusherChannel channel;
  String eventName = 'new-message'; // Event name for new messages
  final AuthController authController = Get.find<AuthController>();

  late PusherModel pusherModel;

  late Timer timer;
  String CHANNEL_NAME = "private.chatify";
  final controller = Get.put(ChatController());

  Future<void> initPusher({required PusherModel pusherData}) async {
    _pusher = PusherChannelsFlutter.getInstance();

    String APP_ID = pusherData.data!.appId.toString();
    String API_KEY = pusherData.data!.key.toString();
    String SECRET = pusherData.data!.secret.toString();
    String API_CLUSTER = pusherData.data!.cluster.toString();
    CHANNEL_NAME = pusherData.data!.channelName.toString();
    pusherModel = pusherData;
    try {
      await _pusher.init(
        apiKey: API_KEY,
        cluster: API_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onEvent: onEvent,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        authEndpoint: RouteConstant.base_ChatUrl + "chat/auth",
        onAuthorizer: onAuthorizer,
      );

      print("This is appid : $APP_ID");
      print("This is api key : $API_KEY");

      // await _pusher.subscribe(channelName: CHANNEL_NAME, onEvent: onEvent);
      await _pusher.connect();
    } catch (e) {
      log("error in initialization: $e");
    }
  }

  void onEvent(dynamic event) {
    controller.getMsg();
    print("onEvent: $event");
  }

  void disconnect() {
    _pusher.disconnect();
  }

  Future<void> onConnectionStateChange(
    dynamic currentState,
    dynamic previousState,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    log("Connection: $currentState");
    _pusher.getSocketId().then(
      (value) async => {
        print("Socket>>$value"),
        if (value != "null")
          await _pusher.subscribe(
            channelName: "$CHANNEL_NAME.${authController.userData.value.id}",
            onEvent: onEvent,
          ),
        controller.chatSync(
          value,
          "$CHANNEL_NAME.${authController.userData.value.id}",
        ),
      },
    );
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = _pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log(
      "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount",
    );
  }

  /* void _handleNewMessageEvent(dynamic event) {
    if (event['event'] == eventName) {
      final message = Map<String, dynamic>.from(event['data']);
      _messages.add(message);
      if (!_isChatOpen) {
        _unseenChatCount++; // Increment only if chat is not open
      }
      notifyListeners(); // Update UI
    }
  }*/

  dynamic onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    var authUrl = RouteConstant.base_ChatUrl + "chat/auth";
    var result = await http.post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${authController.appToken.toString()}',
      },
      body: 'socket_id=$socketId&channel_name=$channelName',
    );
    return jsonDecode(result.body);
  }
}

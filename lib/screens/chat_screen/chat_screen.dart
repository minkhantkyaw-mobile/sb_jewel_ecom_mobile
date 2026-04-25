import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/chat_screen/widgets/send_message_widget.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/app_color.dart';
import '../../models/chat/pusher_config.dart';
import '../../models/chat/pusher_model.dart';
import '../../router/route_helper.dart';
import 'chat_controller.dart';
import 'messages_list_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();
  late PusherConfig pusherConfig;

  final AuthController authController = Get.find<AuthController>();
  final controller = Get.put(ChatController());
  late PusherChannel channel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authController.appToken.isEmpty) {
        Get.offNamed(RouteHelper.login);
      } else {
        controller.page.value = 1;
        controller.getMsg().then((value) {
          saveLastMsgId(value!.lastMessageId.toString());
          loadLastMsgID(value.lastMessageId.toString());
        });
      }
    });
    pusherConfig = PusherConfig();

    super.initState();
  }

  Future<void> saveLastMsgId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_msg_id', id ?? "");
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> loadLastMsgID(String last_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastMsgId = prefs.getString('last_msg_id');
    setState(() {
      if (lastMsgId.toString() != "null" && lastMsgId != last_id) {
        controller.isMsgNew.value = true;
      } else {
        controller.isMsgNew.value = false;
      }
    });
  }

  @override
  void dispose() {
    //pusherConfig.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat".tr)),
      backgroundColor: Colors.white,
      body: Obx(
        () =>
            controller.isLoading.value == false
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: MessagesListWidget(
                        chatDetailsModel: controller.msgList,
                        currentUser: controller.id.value,
                      ),
                    ),
                    SendMessageWidget(),
                  ],
                )
                : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: AppColor.primaryClr,
                      radius: 12,
                      animating: true,
                    ),
                  ),
                ),
      ),
    );
  }
}

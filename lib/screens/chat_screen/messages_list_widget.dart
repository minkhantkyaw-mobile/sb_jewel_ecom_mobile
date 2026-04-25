import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spjewellery/core/app_widgets/empty_view.dart';
import 'package:spjewellery/screens/chat_screen/chat_controller.dart';
import 'package:spjewellery/screens/chat_screen/widgets/receiver_message_item_widget.dart';
import 'package:spjewellery/screens/chat_screen/widgets/sender_message_item_widget.dart';
import 'package:spjewellery/services/toast_service.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../core/app_widgets/footer_widget.dart';
import '../../models/chat/chat_list_model.dart';

class MessagesListWidget extends StatefulWidget {
  final List<Messages>? chatDetailsModel;
  final String currentUser;
  const MessagesListWidget({
    super.key,
    this.chatDetailsModel,
    required this.currentUser,
  });

  @override
  State<MessagesListWidget> createState() => _MessagesListWidgetState();
}

class _MessagesListWidgetState extends State<MessagesListWidget> {
  ScrollController _scrollController = ScrollController();
  ChatController chatController = Get.put(ChatController());
  bool isAtTop = true;
  bool isLoading = false;
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  ); // Initial refresh on load

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    chatController.page.value = 1;

    /* _scrollController.addListener(() {
      // Check if at the top
      if (_scrollController.position.pixels <= 0) {
        if (!isAtTop) {
          setState(() => isAtTop = true);
        }
      } else {
        if (isAtTop) {
          setState(() => isAtTop = false);
        }
      }
    });*/
    super.initState();
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    if (!chatController.canloadMore.value)
      ToastService.warningToast("No more message");
    _refreshController.refreshCompleted();

    if (!chatController.canloadMore.value) return;

    chatController.page.value++;
    await chatController.getMsg();
    _refreshController.refreshCompleted();
    // Indicate loading is complete
  }

  void _onLoading() async {
    if (!chatController.canloadMore.value) return;

    chatController.page.value++;
    chatController.isLoading.value = true;
    await chatController.getMsg();
    _refreshController.loadComplete(); // Indicate loading is complete
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Obx(
          () => NestedScrollView(
            physics: BouncingScrollPhysics(),
            body: SmartRefresher(
              scrollDirection: Axis.vertical,
              scrollController: _scrollController,
              enablePullDown: true, // Enable pull to refresh
              enablePullUp: false,
              header:
                  const WaterDropHeader(), // Or any other header like ClassicHeader()
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("load more message".tr);
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed! Click retry!".tr);
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("Release to load more".tr);
                  } else {
                    body = Text("No more message".tr);
                  }
                  return Container(height: 50.0, child: Center(child: body));
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child:
                  controller.msgList.length != 0
                      ? ChatDataList(data_list: controller.msgList)
                      : EmptyViewWidget(),
            ),
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return [];
            },
          ),
        );
      },
    );
  }
}

class ChatDataList extends StatelessWidget {
  final List<Messages> data_list;
  const ChatDataList({super.key, required this.data_list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      itemCount: data_list.length,
      itemBuilder: (context, i) {
        Messages message = data_list[i];
        if (message.sendBy == "user") {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ReceiverMsgItemWidget(message: message),
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: SenderMsgItemWidget(message: message),
          );
        }
      },
    );
  }
}

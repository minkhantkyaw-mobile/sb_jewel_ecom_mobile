import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_data.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/chat/pusher_config.dart';
import '../../models/chat/pusher_model.dart';
import '../../router/route_helper.dart';
import '../chat_screen/chat_controller.dart';
import '../search_page.dart';
import 'nav_controller.dart';

class ToolbarWidget extends StatefulWidget {
  final ProductController controller;
  final NavController navController;
  const ToolbarWidget({
    super.key,
    required this.controller,
    required this.navController,
  });

  @override
  State<ToolbarWidget> createState() => _ToolbarWidgetState();
}

class _ToolbarWidgetState extends State<ToolbarWidget> {
  late PusherConfig pusherConfig;
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.find<AuthController>();
  @override
  void dispose() {
    pusherConfig.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    pusherConfig = PusherConfig();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      authController.getPusher().then((PusherModel data) {
        setState(() {
          pusherConfig.initPusher(pusherData: data);
        });
      });
      chatController.isLoading.value = true;
      chatController.getMsg().then((value){
        loadLastMsgID(value!.lastMessageId.toString());
      });
    });
    super.initState();
  }

  Future<void> loadLastMsgID(String last_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastMsgId = prefs.getString('last_msg_id');
    setState(() {
      if(lastMsgId.toString()!="null" && lastMsgId!=last_id){
        chatController.isMsgNew.value=true;
      }else{
        chatController.isMsgNew.value=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimesion.height5,
        bottom: Dimesion.height5,
      ),
      child: Column(
        children: [
         

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      RouteHelper.search,
                      arguments: SearchPage(
                        datalist:
                        widget.controller
                            .productListBySubCategory,
                      ),
                    );
                  },
                  child: Container(width: MediaQuery.of(context).size.width,
                    height: 40,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimesion.width5,
                      horizontal: Dimesion.width10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        Dimesion.width5,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.search,
                          size: Dimesion.iconSize25,
                          color: AppColor.black,
                        ),
                        Gap(Dimesion.width10),
                        Expanded(
                          child: Text("search".tr,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: Dimesion.font16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.filter);
                },
                child: Icon(
                  Icons.filter_list_outlined,
                  size: Dimesion.iconSize25,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

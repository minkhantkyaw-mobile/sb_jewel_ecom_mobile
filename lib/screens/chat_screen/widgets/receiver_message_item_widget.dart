import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import '../../../controllers/auth_controller.dart';
import '../../../core/constants/api_route_constants.dart';
import '../../../core/constants/app_color.dart';
import '../../../models/chat/chat_list_model.dart';
import 'audio_message.dart';
import 'cached_image_widget.dart';

class ReceiverMsgItemWidget extends StatelessWidget {
  final Messages message;
  const ReceiverMsgItemWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.find<AuthController>();
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message.body.toString() != "")
                message.body.toString().length > 19
                    ? Container(
                      width: 190,
                      margin: const EdgeInsets.only(right: 3),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColor.myGreen,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.right,
                        message.body.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : Container(
                      margin: const EdgeInsets.only(right: 3),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.myGreen,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.right,
                        message.body.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              if (message.attachment.toString() != "null" &&
                  message.attachmentType.toString() == "image")
                InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder:
                          (_) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: PhotoView(
                              imageProvider: NetworkImage(
                                RouteConstant.chat_storage_url+ message.attachment.toString(),
                              ),
                            ),
                          ),
                    );
                  },
                  child: CachedImageWidget(
                    imgUrl: RouteConstant.chat_storage_url+message.attachment.toString(),
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    fit: BoxFit.contain,
                  ),
                ),
              if (message.attachment.toString() != "null" &&
                  message.attachmentType.toString() == "audio")
                AudioMessage(
                  source: RouteConstant.chat_storage_url+message.attachment.toString(),
                ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat("dd-MM-y  hh:mm:a")
                        .format(
                          DateTime.parse(
                            message.createdAt.toString(),
                          ).toLocal(),
                        )
                        .toString(),
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(width: 3),
                  message.seen == 1
                      ? const Icon(Icons.check, size: 17, color: AppColor.black)
                      : const Icon(Icons.check, size: 17),
                ],
              ),
            ],
          ),
          CircleAvatar(
            radius: 23,
            backgroundImage: CachedNetworkImageProvider(
              authController.userData.value.image ?? "",
            ),
          ),
        ],
      ),
    );
  }
}

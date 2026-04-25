import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import '../../../core/constants/api_route_constants.dart';
import '../../../core/constants/app_color.dart';
import '../../../models/chat/chat_list_model.dart';
import 'audio_message.dart';
import 'cached_image_widget.dart';

class SenderMsgItemWidget extends StatelessWidget {
  const SenderMsgItemWidget({super.key, required this.message});

  final Messages message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage("assets/img/customer_service.png"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.body.toString() != "")
                  message.body.toString().length > 19
                      ? Container(
                        width: 190,
                        margin: const EdgeInsets.only(left: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColor.primaryClr,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          message.body.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                      : Container(
                        margin: const EdgeInsets.only(left: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColor.primaryClr,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          message.body.toString(),
                          style: const TextStyle(color: Colors.white),
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
                                  RouteConstant.chat_storage_url+message.attachment.toString(),
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
                    source:
                    RouteConstant.chat_storage_url+message.attachment.toString(),
                  ),
                SizedBox(height: 3),
                Text(
                  DateFormat("dd-MM-y  hh:mm:a")
                      .format(
                        DateTime.parse(message.createdAt.toString()).toLocal(),
                      )
                      .toString(),
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

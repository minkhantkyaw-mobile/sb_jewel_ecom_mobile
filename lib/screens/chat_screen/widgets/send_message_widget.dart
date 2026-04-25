import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../chat_controller.dart';
import 'app_text_form_field.dart';
import 'audio_recorder.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key});



  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final controller = Get.put(ChatController());

  File? currentAudioFile;
  TextEditingController messageController = TextEditingController();

  bool showAudioRecorder = false;

  @override
  void initState() {
    messageController = TextEditingController(text: "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        showAudioRecorder
            ? SizedBox(
          height: 100,
          child: AudioRecorderWidget(onStop: (audioPath) {
            if (audioPath.isNotEmpty) {
              currentAudioFile = File(audioPath);
              currentAudioFile!.readAsBytes().asStream();
              currentAudioFile!.lengthSync();
              setState(() {
                controller.sendMsg("", currentAudioFile, 3);
              });
            }
            setState(() {
              showAudioRecorder = false;
              currentAudioFile=null;

            });
          }),
        )
            : SizedBox.shrink(),
        Container(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 28),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
          child: Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  horizontalPadding: 0,
                  hintText: "Message ..".tr.tr,
                  textInputType: TextInputType.text,
                  controller: messageController,
                  borderRadius: 15,
                  backgroundColor: const Color.fromARGB(255, 239, 247, 252),
                  suffixIcon: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.16,
                    child: GestureDetector(
                      onTap: () async {
                       controller.pickImage();
                      },
                      child: const Icon(
                        Icons.image,
                        color: AppColor.primaryClr,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showAudioRecorder = !showAudioRecorder;
                  });
                },
                child: Container(
                  height: 46,
                  width: 46,
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryClr,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (messageController.text.isNotEmpty) {
                    controller.sendMsg(messageController.text,currentAudioFile,1);
                  }
                  setState(() {
                    messageController.clear();
                    currentAudioFile=null;
                  });
                },
                child: Container(
                  height: 46,
                  width: 46,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.send_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

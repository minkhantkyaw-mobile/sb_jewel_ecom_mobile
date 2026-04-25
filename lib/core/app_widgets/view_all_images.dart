import 'dart:io';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/post_model.dart';
import '../../services/toast_service.dart';
import '../app_data.dart';
import '../constants/app_color.dart';
import '../constants/dimesions.dart';
import 'app_loading_widget.dart';

class ViewAllImagesScreen extends StatefulWidget {
  final List<Images>? images;
  final int indexImg;
  const ViewAllImagesScreen({super.key, required this.images, required this.indexImg});

  @override
  State<ViewAllImagesScreen> createState() => _ViewAllImagesScreenState();
}

class _ViewAllImagesScreenState extends State<ViewAllImagesScreen> {

  late String imgUrl="";
  PageController pageController=PageController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){

      pageController.jumpToPage(widget.indexImg);
      imgUrl=widget.images![widget.indexImg].path.toString();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackless,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white,),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  downloadImage(imgUrl);
                });
              },
              icon: const Icon(Icons.download_rounded,color: Colors.white,))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: pageController,
        itemCount: widget.images!.length, // Can be null
        itemBuilder: (context, position) {
          imgUrl=widget.images![position].path.toString();
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: PhotoView(
                  backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
                  loadingBuilder: (context, event) => const AppLoadingWidget(),
                  imageProvider: NetworkImage(widget.images![position].path.toString()))),
              Container(
                padding: EdgeInsets.all(Dimesion.width10),
                child: HtmlWidget(widget.images![position].description.toString()!="null"?widget.images![position].description.toString():"",
                
                  textStyle: TextStyle(color: Colors.white, fontSize: Dimesion.font16),),
              ),
            ],
          );
        },
      ),

    );
  }

  Future<void> downloadImage(String url) async {

    PermissionStatus status;

    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted) {
        status = PermissionStatus.granted;
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      await GallerySaver.saveImage(
        url,
        albumName: AppConfig.appName,
      );
      BotToast.showText(text: "Image saved");
    } else {
      ToastService.errorToast("Permission denied");
    }
  }

}
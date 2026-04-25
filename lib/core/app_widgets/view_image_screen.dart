import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import '../../services/toast_service.dart';
import '../app_data.dart';
import 'app_loading_widget.dart';

class ViewImagePage extends StatefulWidget {
  final String imgUrl;
  const ViewImagePage({super.key, required this.imgUrl});

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              downloadImage();
            },
            icon: const Icon(Icons.download_rounded),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          loadingBuilder: (context, event) => const AppLoadingWidget(),
          imageProvider: NetworkImage(widget.imgUrl),
        ),
      ),
    );
  }

  Future<void> downloadImage() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final permission = await Permission.storage.request();

    if (permission.isGranted) {
      GallerySaver.saveImage(
        widget.imgUrl,
        albumName: AppConfig.appName,
      ).then((value) => BotToast.showText(text: "Image is Saved"));
    } else {
      ToastService.errorToast("Permission denied");
    }
    /*AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 34 || Platform.isIOS) {

    } else {
      GallerySaver.saveImage(widget.imgUrl, albumName: AppConfig.appName)
          .then((value) => BotToast.showText(text: "Downloaded"));
    }*/
  }
}

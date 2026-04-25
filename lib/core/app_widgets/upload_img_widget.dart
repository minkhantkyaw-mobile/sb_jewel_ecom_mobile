import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/checkout_controller.dart';
import '../constants/dimesions.dart';
import 'my_cache_img.dart';


class UploadImgWidget extends StatefulWidget {
  final CheckOutController controller;
  final String? networkImg;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  const UploadImgWidget(
      {super.key,
        this.networkImg,
        this.width,
        this.boxFit,
        this.height, required this.controller});

  @override
  State<UploadImgWidget> createState() => _UploadImgWidgetState();
}

class _UploadImgWidgetState extends State<UploadImgWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(builder: (builder){
      return InkWell(
        onTap: (){
          setState(() {
            widget.controller.pickImage();
          });
        },
        child: Container(
            height: widget.height ?? Dimesion.height40 * 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                border: Border.all(color: Colors.grey.shade100, width: 1),
                color: Colors.grey.shade100),
            child: widget.controller.pickedImagePath == null
                ? DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              padding: EdgeInsets.all(6),
              child: Container(
                  width: widget.width ?? Dimesion.screeWidth,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Click here image upload".tr),
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: Dimesion.iconSize25+17,
                      )
                    ],
                  )),
            ):Container(
              height: Dimesion.screenHeight/4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                child: Image.file(
                  widget.controller.pickedImagePath!,
                  fit: widget.boxFit ?? BoxFit.cover,
                  height: widget.height ?? Dimesion.height40 * 1.5,
                  width: widget.width ?? Dimesion.screeWidth,
                ),
              ),
            )
        ),
      );
    });
  }
}

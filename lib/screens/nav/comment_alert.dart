import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_image/circular_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/constants/api_route_constants.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/post_model.dart';

class CommentAlertWidget extends StatefulWidget {
  final PostData postData;
  final ProductController controller;
  final AuthController authController;
  const CommentAlertWidget({
    super.key,
    required this.postData,
    required this.controller,
    required this.authController,
  });

  @override
  State<CommentAlertWidget> createState() => _CommentAlertWidgetState();
}

class _CommentAlertWidgetState extends State<CommentAlertWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.postData.value = widget.postData;
      widget.controller.isReply.value = false;
      widget.controller.commentController.text = "";
      widget.controller.parent_id.value = -1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: Obx(
            () => Stack(
              children: [
                CustomScrollView(
                  // controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            height: 4,
                            width: 40,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                        if (widget.controller.postData.value.comments!.length !=
                            0)
                          Container(
                            margin: EdgeInsets.only(bottom: Dimesion.height40),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(Dimesion.width10),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  widget
                                      .controller
                                      .postData
                                      .value
                                      .comments!
                                      .length,
                              itemBuilder: (BuildContext context, int index) {
                                Comments comData =
                                    widget
                                        .controller
                                        .postData
                                        .value
                                        .comments![index];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: Dimesion.height10,
                                      ),
                                      width: Dimesion.width30,
                                      height: Dimesion.height30,
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                          widget
                                              .controller
                                              .postData
                                              .value
                                              .comments![index]
                                              .image
                                              .toString(),
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Gap(Dimesion.width10),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Gap(Dimesion.height5),
                                          Container(
                                            width: Dimesion.screeWidth,
                                            padding: EdgeInsets.all(
                                              Dimesion.size10 - 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.bgColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    Dimesion.radius5,
                                                  ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget
                                                      .controller
                                                      .postData
                                                      .value
                                                      .comments![index]
                                                      .poster
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        Dimesion.font12 + 1,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  widget
                                                      .controller
                                                      .postData
                                                      .value
                                                      .comments![index]
                                                      .body
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: Dimesion.font12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CupertinoButton(
                                            child: Text(
                                              widget
                                                          .controller
                                                          .postData
                                                          .value
                                                          .comments![index]
                                                          .replies!
                                                          .length !=
                                                      0
                                                  ? "View " +
                                                      widget
                                                          .controller
                                                          .postData
                                                          .value
                                                          .comments![index]
                                                          .replies!
                                                          .length
                                                          .toString() +
                                                      " Reply"
                                                  : "Reply",
                                              style: GoogleFonts.outfit(
                                                textStyle: TextStyle(
                                                  color:
                                                      widget
                                                                      .controller
                                                                      .postData
                                                                      .value
                                                                      .comments![index]
                                                                      .replyShow ==
                                                                  true &&
                                                              widget
                                                                      .controller
                                                                      .postData
                                                                      .value
                                                                      .comments![index]
                                                                      .id ==
                                                                  widget
                                                                      .controller
                                                                      .parent_id
                                                                      .value
                                                          ? AppColor.primaryClr
                                                          : AppColor.blackless,
                                                  fontSize: Dimesion.font12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                widget
                                                    .controller
                                                    .replyID
                                                    .value = widget
                                                        .controller
                                                        .postData
                                                        .value
                                                        .comments![index]
                                                        .id!;
                                                if (widget
                                                        .controller
                                                        .postData
                                                        .value
                                                        .comments![index]
                                                        .id ==
                                                    widget
                                                        .controller
                                                        .parent_id
                                                        .value) {
                                                  widget
                                                      .controller
                                                      .isReply
                                                      .value = !widget
                                                          .controller
                                                          .isReply
                                                          .value;
                                                  widget
                                                      .controller
                                                      .postData
                                                      .value
                                                      .comments![index]
                                                      .replyShow = !widget
                                                          .controller
                                                          .postData
                                                          .value
                                                          .comments![index]
                                                          .replyShow!;
                                                } else {
                                                  widget
                                                      .controller
                                                      .isReply
                                                      .value = true;
                                                  widget
                                                      .controller
                                                      .postData
                                                      .value
                                                      .comments![index]
                                                      .replyShow = true;
                                                }
                                                widget
                                                    .controller
                                                    .parent_id
                                                    .value = comData.id!;

                                                widget
                                                    .controller
                                                    .postData
                                                    .value
                                                    .comments!
                                                    .length;
                                              });
                                            },
                                          ),
                                          Visibility(
                                            visible:
                                                widget
                                                    .controller
                                                    .postData
                                                    .value
                                                    .comments![index]
                                                    .replyShow!,
                                            child: ListView.builder(
                                              itemCount:
                                                  widget
                                                      .controller
                                                      .postData
                                                      .value
                                                      .comments![index]
                                                      .replies!
                                                      .length,
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (
                                                BuildContext context,
                                                int i,
                                              ) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: Dimesion.width30,
                                                      height: Dimesion.height30,
                                                      child: CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                              widget
                                                                  .controller
                                                                  .postData
                                                                  .value
                                                                  .comments![index]
                                                                  .replies![i]
                                                                  .image
                                                                  .toString(),
                                                            ),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    //  Icon(Icons.person_outline,color: AppColor.black,),
                                                    Gap(Dimesion.width5),
                                                    Flexible(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: 6,
                                                        ),
                                                        width:
                                                            Dimesion.screeWidth,
                                                        padding: EdgeInsets.all(
                                                          Dimesion.size10 - 6,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              AppColor.bgColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                Dimesion
                                                                    .radius5,
                                                              ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,

                                                          children: [
                                                            Text(
                                                              widget
                                                                  .controller
                                                                  .postData
                                                                  .value
                                                                  .comments![index]
                                                                  .replies![i]
                                                                  .poster
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontSize:
                                                                    Dimesion
                                                                        .font12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            Text(
                                                              widget
                                                                  .controller
                                                                  .postData
                                                                  .value
                                                                  .comments![index]
                                                                  .replies![i]
                                                                  .body
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontSize:
                                                                    Dimesion
                                                                        .font12 -
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                      ]),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    color: AppColor.white,
                    height: Dimesion.height40 + 14,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 48),
                            child: IntrinsicWidth(
                              child: Container(
                                alignment: Alignment.center,
                                height: Dimesion.height40 + 3,
                                width: Dimesion.screeWidth,
                                padding: EdgeInsets.only(
                                  left: Dimesion.width10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.bgColor,
                                  borderRadius: BorderRadius.circular(
                                    Dimesion.radius5,
                                  ),
                                ),
                                child: TextField(
                                  controller:
                                      widget.controller.commentController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText:
                                        widget.controller.isReply.value == false
                                            ? "Write a comment..."
                                            : "Write a Reply...",
                                    labelStyle: TextStyle(
                                      fontSize: Dimesion.font12,
                                      color: AppColor.primaryClr,
                                    ),
                                    border: InputBorder.none,
                                    helperStyle: TextStyle(
                                      fontSize: Dimesion.font12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(Dimesion.width5),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.authController.appToken.isNotEmpty) {
                                widget.controller.comment(
                                  post_id:
                                      widget.controller.postData.value.id!
                                          .toInt(),
                                  user_id:
                                      widget.controller.postData.value.userId!
                                          .toInt(),
                                  body:
                                      widget.controller.commentController.text,
                                  parient_id: widget.controller.parent_id.value,
                                );
                              } else {
                                Get.toNamed(RouteConstant.login);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            size: Dimesion.iconSize25,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

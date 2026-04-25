import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_image/circular_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_widgets/footer_widget.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/app_widgets/photo_grid.dart';
import '../../core/app_widgets/view_all_images.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/post_model.dart';
import '../../router/route_helper.dart';
import 'comment_alert.dart';
import 'newfeed_detail.dart';

class NewFeedWidget extends StatefulWidget {
  final ProductController controller;
  final AuthController authController;
  const NewFeedWidget({
    super.key,
    required this.controller,
    required this.authController,
  });

  @override
  State<NewFeedWidget> createState() => _NewFeedWidgetState();
}

class _NewFeedWidgetState extends State<NewFeedWidget> {
  late RefreshController refreshController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshController = RefreshController(initialRefresh: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          widget.controller.allPosts.length != 0
              ? Container(
                child: MasonryGridView.count(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.controller.allPosts.length,
                  crossAxisCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    PostData data = widget.controller.allPosts[index];

                    return GestureDetector(
                      onTap:
                          () => {
                            Get.toNamed(
                              RouteHelper.feeddetail,
                              arguments: NewfeedDetailPage(
                                id: data.id!.toInt(),
                                controller: widget.controller,
                                authController: widget.authController,
                                postData: data,
                              ),
                            ),
                          },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimesion.radius15,
                          ),
                        ),
                        color: Colors.white,
                        elevation: 1,
                        child: Container(
                          padding: EdgeInsets.all(Dimesion.size10),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularImage(
                                    source: "assets/png/sp_logo.png",
                                    radius: Dimesion.radius15,
                                    borderWidth: 1,
                                    borderColor: Colors.white,
                                  ),
                                  Gap(Dimesion.width10),
                                  Text(
                                    textAlign: TextAlign.center,
                                    data.poster.toString(),
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        color: AppColor.black,
                                        fontSize: Dimesion.font16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(Dimesion.width10),
                              ReadMoreText(
                                data.description.toString(),
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: Colors.pink,
                                trimCollapsedText: '  show more',
                                trimExpandedText: '   show less',
                                lessStyle: TextStyle(
                                  color: AppColor.primaryClr,
                                  fontSize: Dimesion.font14,
                                  fontWeight: FontWeight.bold,
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimesion.font14 - 2,
                                  fontWeight: FontWeight.normal,
                                ),
                                moreStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: Dimesion.font14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(Dimesion.width15),

                              if (data.images!.length == 1)
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      RouteHelper.view_Images,
                                      arguments: ViewAllImagesScreen(
                                        images: data.images,
                                        indexImg: 0,
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    alignment: Alignment.center,
                                    imageUrl: data.images![0].path.toString(),
                                    /*progressIndicatorBuilder: (context, url, progress) => Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoActivityIndicator(
                                color: AppColor.primaryClr,
                                animating: true,
                              )),*/
                                    errorWidget:
                                        (context, url, error) => Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          child: CupertinoActivityIndicator(
                                            color: AppColor.primaryClr,
                                            animating: true,
                                          ),
                                        ),
                                  ),
                                  //child: Image.network(data.images![0].path.toString()),
                                ),
                              if (data.images!.length != 3 &&
                                  data.images!.length == 2 &&
                                  data.images!.length != 1)
                                Container(
                                  height: Dimesion.screenHeight / 5.1,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              RouteHelper.view_Images,
                                              arguments: ViewAllImagesScreen(
                                                images: data.images,
                                                indexImg: 0,
                                              ),
                                            );
                                          },
                                          child: MyCacheImg(
                                            url:
                                                data.images![0].path.toString(),
                                            boxfit: BoxFit.cover,
                                            borderRadius: BorderRadius.zero,
                                            height: Dimesion.screenHeight / 6,
                                          ),
                                        ),
                                      ),
                                      Gap(Dimesion.width5 - 2),
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              RouteHelper.view_Images,
                                              arguments: ViewAllImagesScreen(
                                                images: data.images,
                                                indexImg: 1,
                                              ),
                                            );
                                          },
                                          child: MyCacheImg(
                                            url:
                                                data.images![1].path.toString(),
                                            boxfit: BoxFit.cover,
                                            borderRadius: BorderRadius.zero,
                                            height: Dimesion.screenHeight / 6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (data.images!.length == 3 &&
                                  data.images!.length != 1)
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              RouteHelper.view_Images,
                                              arguments: ViewAllImagesScreen(
                                                images: data.images,
                                                indexImg: 0,
                                              ),
                                            );
                                          },
                                          child: MyCacheImg(
                                            url:
                                                data.images![0].path.toString(),
                                            boxfit: BoxFit.cover,
                                            borderRadius: BorderRadius.zero,
                                            width: Dimesion.screeWidth,
                                            height: Dimesion.screenHeight / 4,
                                          ),
                                        ),
                                        Gap(Dimesion.height5 - 2),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                    RouteHelper.view_Images,
                                                    arguments:
                                                        ViewAllImagesScreen(
                                                          images: data.images,
                                                          indexImg: 1,
                                                        ),
                                                  );
                                                },
                                                child: MyCacheImg(
                                                  url:
                                                      data.images![1].path
                                                          .toString(),
                                                  boxfit: BoxFit.cover,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  height:
                                                      Dimesion.screenHeight / 6,
                                                ),
                                              ),
                                            ),
                                            Gap(Dimesion.width5 - 2),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                    RouteHelper.view_Images,
                                                    arguments:
                                                        ViewAllImagesScreen(
                                                          images: data.images,
                                                          indexImg: 2,
                                                        ),
                                                  );
                                                },
                                                child: MyCacheImg(
                                                  url:
                                                      data.images![2].path
                                                          .toString(),
                                                  boxfit: BoxFit.cover,
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                  height:
                                                      Dimesion.screenHeight / 6,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (data.images!.length > 3)
                                Container(
                                  height: Dimesion.screenHeight / 2.7,
                                  child: PhotoGrid(
                                    imageUrls: data.images!,
                                    onImageClicked:
                                        (i) => {
                                          Get.toNamed(
                                            RouteHelper.view_Images,
                                            arguments: ViewAllImagesScreen(
                                              images: data.images,
                                              indexImg: i,
                                            ),
                                          ),
                                        },
                                    onExpandClicked:
                                        () => {
                                          Get.toNamed(
                                            RouteHelper.feeddetail,
                                            arguments: NewfeedDetailPage(
                                              id: data.id!.toInt(),
                                              controller: widget.controller,
                                              authController:
                                                  widget.authController,
                                              postData: data,
                                            ),
                                          ),
                                        },
                                    maxImages: 4,
                                  ),
                                ),
                              Gap(Dimesion.height10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    data.comments!.length.toString() +
                                        " Comments",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: Dimesion.font14 - 2,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        showCupertinoModalBottomSheet(
                                          context: context,
                                          builder:
                                              (context) => CommentAlertWidget(
                                                postData: data,
                                                controller: widget.controller,
                                                authController:
                                                    widget.authController,
                                              ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        right: Dimesion.width10,
                                        left: Dimesion.width5,
                                      ),

                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.chat_bubble,
                                            color: Colors.grey,
                                            size: Dimesion.iconSize25,
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            "Comment".tr,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Dimesion.font14 - 2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              /*ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.controller.allPosts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        PostData data=widget.controller.allPosts[index];
        return ;
      },
    )*/
              : SingleChildScrollView(
                padding: EdgeInsets.all(Dimesion.width15),
                child: Shimmer.fromColors(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: Dimesion.height5),
                        color: CupertinoColors.lightBackgroundGray,
                        height: Dimesion.screenHeight / 4,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: Dimesion.height5),
                        color: CupertinoColors.lightBackgroundGray,
                        height: Dimesion.screenHeight / 4,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: Dimesion.height5),
                        color: CupertinoColors.lightBackgroundGray,
                        height: Dimesion.screenHeight / 4,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: Dimesion.height5),
                        color: CupertinoColors.lightBackgroundGray,
                        height: Dimesion.screenHeight / 4,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: Dimesion.height5),
                        color: CupertinoColors.lightBackgroundGray,
                        height: Dimesion.screenHeight / 4,
                      ),
                    ],
                  ),
                  baseColor: CupertinoColors.lightBackgroundGray,
                  highlightColor: Colors.white,
                ),
              ),
    );
  }
}

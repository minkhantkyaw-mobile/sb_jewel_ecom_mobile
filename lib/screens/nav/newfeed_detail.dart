import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_image/circular_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/app_widgets/view_all_images.dart';
import '../../core/constants/api_route_constants.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/post_model.dart';
import '../../router/route_helper.dart';


class NewfeedDetailPage extends StatefulWidget {
  final AuthController authController;
  final int id;
  final PostData postData;
  final ProductController controller;
  const NewfeedDetailPage({super.key, required this.id, required this.controller, required this.authController, required this.postData});

  @override
  State<NewfeedDetailPage> createState() => _NewFeedDetailPageState();
}

class _NewFeedDetailPageState extends State<NewfeedDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){

      widget.controller.postData.value=widget.postData;
      widget.controller.isReply.value=false;
      widget.controller.commentController.text="";
      widget.controller.parent_id.value=-1;

    });

    /*WidgetsBinding.instance.addPostFrameCallback((_){

      widget.controller.getPostDetail(post_id: widget.id);

    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (builder){
      return Scaffold(
        backgroundColor: AppColor.white,
        body: Obx(()=>widget.controller.isPostLoading.value==false?
        Stack(
          children: [
            CustomScrollView(
              // controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.all(Dimesion.radius15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /*Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                height: 4,
                                width: 40,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),*/
                            Gap(Dimesion.height15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(CupertinoIcons.back,color: AppColor.primaryClr,size: Dimesion.iconSize25,)),
                                CircularImage(source: "assets/img/logo.png",radius: Dimesion.radius15,borderWidth: 1,borderColor: Colors.white,),
                                Gap(Dimesion.width10),
                                Text(
                                  textAlign: TextAlign.center,
                                  widget.controller.postData.value.poster.toString(),
                                  style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.black,fontSize: Dimesion.font16,fontWeight: FontWeight.bold)),
                                ),                      ],
                            ),
                            Gap(Dimesion.width10),
                            HtmlWidget(widget.controller.postData.value.description.toString(),),
                            if(widget.controller.postData.value.images!.length!=0)
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.controller.postData.value.images!.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return GestureDetector(
                                      onTap: (){
                                        Get.toNamed(RouteHelper.view_Images,arguments: ViewAllImagesScreen(images: widget.controller.postData.value.images, indexImg: index,));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        color: AppColor.bgColor,
                                        padding: EdgeInsets.only(bottom: Dimesion.height5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Gap(Dimesion.height5),
                                            CachedNetworkImage(imageUrl: widget.controller.postData.value.images![index].path.toString(),fit: BoxFit.fill,alignment: Alignment.center,),
                                            Gap(Dimesion.height5),
                                            HtmlWidget(widget.controller.postData.value.images![index].description.toString(),),
                                            Gap(Dimesion.height5),
                                            Divider(color: AppColor.white,height: 3,),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),

                            Container(
                              margin: EdgeInsets.only(bottom: Dimesion.height40),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.controller.postData.value.comments!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    Comments comData=widget.controller.postData.value.comments![index];
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: Dimesion.height10),
                                          width: Dimesion.width30,
                                          height: Dimesion.height30,
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage:
                                            NetworkImage(widget.controller.postData.value.comments![index].image.toString()),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        Gap(Dimesion.width10),
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Gap(Dimesion.height5),
                                            Container(
                                              width: Dimesion.screeWidth,
                                              padding: EdgeInsets.all(Dimesion.size10-6),
                                              decoration: BoxDecoration(
                                                  color: AppColor.bgColor,
                                                  borderRadius: BorderRadius.circular(Dimesion.radius5)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(widget.controller.postData.value.comments![index].poster.toString(),style: TextStyle(color: Colors.black,fontSize: Dimesion.font12+1,fontWeight: FontWeight.bold)),
                                                  Text(widget.controller.postData.value.comments![index].body.toString(),style: TextStyle(color: Colors.black,fontSize: Dimesion.font12,fontWeight: FontWeight.normal))
                                                ],
                                              ),
                                            ),
                                            CupertinoButton(
                                                child: Text(widget.controller.postData.value.comments![index].replies!.length!=0?"View "+widget.controller.postData.value.comments![index].replies!.length.toString()+" Reply":"Reply",
                                                    style: GoogleFonts.outfit(textStyle:  TextStyle(color: widget.controller.postData.value.comments![index].replyShow==true && widget.controller.postData.value.comments![index].id==widget.controller.parent_id.value?AppColor.primaryClr:AppColor.blackless,fontSize: Dimesion.font12,fontWeight: FontWeight.normal))),
                                                onPressed: () {
                                                  setState(() {
                                                    widget.controller.replyID.value=widget.controller.postData.value.comments![index].id!;
                                                    if(widget.controller.postData.value.comments![index].id==widget.controller.parent_id.value){
                                                      widget.controller.isReply.value=!widget.controller.isReply.value;
                                                      widget.controller.postData.value.comments![index].replyShow=!widget.controller.postData.value.comments![index].replyShow!;
                                                    }else{
                                                      widget.controller.isReply.value=true;
                                                      widget.controller.postData.value.comments![index].replyShow=true;
                                                    }
                                                    widget.controller.parent_id.value=comData.id!;

                                                    widget.controller.postData.value.comments!.length;
                                                    /*
                                                    widget.controller.isReply.value=!widget.controller.isReply.value;
                                                    widget.controller.replyID.value=widget.controller.postData.value.comments![index].id!;
                                                    widget.controller.parent_id.value=comData.id!;
                                                    widget.controller.postData.value.comments![index].replyShow=!widget.controller.postData.value.comments![index].replyShow!;*/

                                                  });

                                                  //Get.toNamed(RouteHelper.team_see_more,arguments: TeamSeeMore(homeController: controller,));
                                                }),
                                            Visibility(
                                                 visible: widget.controller.postData.value.comments![index].replyShow!,
                                                child: ListView.builder(
                                                itemCount: widget.controller.postData.value.comments![index].replies!.length,
                                                physics: ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (BuildContext context, int i) {
                                                  return Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: Dimesion.width30,
                                                        height: Dimesion.height30,
                                                        child: CircleAvatar(
                                                          radius: 30.0,
                                                          backgroundImage:
                                                          NetworkImage(widget.controller.postData.value.comments![index].replies![i].image.toString()),
                                                          backgroundColor: Colors.transparent,
                                                        ),
                                                      ),
                                                      //  Icon(Icons.person_outline,color: AppColor.black,),
                                                      Gap(Dimesion.width5),
                                                      Flexible(child: Container(
                                                        margin: EdgeInsets.only(bottom: 6),
                                                        width: Dimesion.screeWidth,
                                                        padding: EdgeInsets.all(Dimesion.size10-6),
                                                        decoration: BoxDecoration(
                                                            color: AppColor.bgColor,
                                                            borderRadius: BorderRadius.circular(Dimesion.radius5)
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(widget.controller.postData.value.comments![index].replies![i].poster.toString(),style: TextStyle(color: Colors.black,fontSize: Dimesion.font12,fontWeight: FontWeight.bold)),
                                                            Text(widget.controller.postData.value.comments![index].replies![i].body.toString(),style: TextStyle(color: Colors.black,fontSize: Dimesion.font12,fontWeight: FontWeight.normal))
                                                          ],
                                                        ),
                                                      ))
                                                    ],
                                                  );
                                                })),
                                          ],
                                        ))
                                      ],
                                    );
                                  }),
                            ),

                          ],
                        ),
                      ),

                    ])),

              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                color: AppColor.primaryClr,
                height: Dimesion.height40+14,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 48),
                      child: IntrinsicWidth(
                        child: Container(
                          alignment: Alignment.center,
                          height: Dimesion.height40+3,
                          width: Dimesion.screeWidth,
                          padding: EdgeInsets.only(left: Dimesion.width10,),
                          decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(Dimesion.radius5)
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: widget.controller.commentController,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: widget.controller.isReply.value==false?"Write a comment...":"Write a Reply...",
                              labelStyle: TextStyle(fontSize: Dimesion.font12,color: AppColor.primaryClr),
                              border: InputBorder.none,
                              helperStyle: TextStyle(fontSize: Dimesion.font12),
                            ),
                          ),
                        ),
                      ),
                    )),
                    Gap(Dimesion.width5),
                    IconButton(onPressed: (){
                      if(widget.authController.appToken.isNotEmpty){
                        widget.controller.comment(post_id: builder.postData.value.id!.toInt(), user_id: builder.postData.value.userId!.toInt(), body: builder.commentController.text, parient_id: builder.parent_id.value);

                      }else{
                        Get.toNamed(RouteConstant.login);
                      }

                    }, icon: Icon(Icons.send,size: Dimesion.iconSize25,color: AppColor.white,))
                  ],
                ),
              ),
            ),
          ],
        ):Container()),
      );
    });
  }
}

/*


class CommentWidget extends StatelessWidget {
  final Comments comment;
  final int level;
  final Function onReply;
  final Function onSendReply;
  final Comment? activeComment;

  CommentWidget({
    required this.comment,
    this.level = 0,
    required this.onReply,
    required this.onSendReply,
    required this.activeComment,

  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController replyController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0 * level, top: 8.0, bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: 1,
                height: 50,
                color: level > 0 ? Colors.grey : Colors.transparent, // Line for replies
              ),
              SizedBox(width: 8),
              CircleAvatar(child: Text(comment.author[0])), // Avatar with author's initial
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(comment.content),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => onReply(comment), // Toggle reply text field
                          child: Text('Reply'),
                        ),
                        if (comment.replies.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              comment.isExpanded = !comment.isExpanded;
                              (context as Element).markNeedsBuild();
                            },
                            child: Text(comment.isExpanded ? 'Hide Replies' : 'View Replies'),
                          ),
                      ],
                    ),
                    if (activeComment == comment)
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: replyController,
                              decoration: InputDecoration(hintText: 'Write a reply...'),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              String replyText = replyController.text;
                              if (replyText.isNotEmpty) {
                                onSendReply(comment, replyText); // Add the reply
                              }
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (comment.isExpanded)
          ...comment.replies
              .map((reply) => CommentWidget(
            comment: reply,
            level: level + 1,
            onReply: onReply,
            onSendReply: onSendReply,
            activeComment: activeComment,

          ))
              .toList(),
      ],
    );
  }
}*/

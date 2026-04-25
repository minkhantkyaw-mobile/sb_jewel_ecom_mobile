import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/fav_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/custom_loading_widget.dart';
import '../../core/app_widgets/empty_view.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import 'noti_card.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {

  final NotiController controller = Get.find<NotiController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){

      controller.getNotiList();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotiController>(builder: (builder){
      return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            toolbarHeight: Dimesion.screenHeight/11,
            leading: backButton(),
            backgroundColor: AppColor.myGreen,
            centerTitle: true,
            title: Text("notification".tr,style: TextStyle(color: Colors.white,fontSize: Dimesion.font16,fontWeight: FontWeight.bold),),
          ),
          body: Obx(
                () {
                  if(controller.isload.value==true){
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(Dimesion.height10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
                        child: CupertinoActivityIndicator(
                          radius: Dimesion.radius10-1,
                          color: AppColor.primaryClr,
                          animating: true,
                        ),
                      ),
                    );
                  }else if(controller.isload.value==false && controller.notiList.isNotEmpty){
                    return Container(
                      height: Dimesion.screenHeight,
                      color: Colors.white,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
                          itemCount: controller.notiList.length,
                          itemBuilder: (_, index) => InkWell(
                              onTap: () {
                                controller.getNotiListRead(id: controller.notiList[index].id.toString());
                              },
                              child: NotiCard(notiData: controller.notiList[index]))),
                    );
                  }else if (controller.notiList.isEmpty) {
                    return const EmptyViewWidget();
                  } return Container();
            },
          )

      );
    });
  }
}

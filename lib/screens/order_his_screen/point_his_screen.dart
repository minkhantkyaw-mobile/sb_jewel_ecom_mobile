import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spjewellery/screens/order_his_screen/point_his_detail_screen.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../controllers/order_his_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/custom_loading_widget.dart';
import '../../core/app_widgets/footer_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import 'order_his_detail_screen.dart';
import 'ordet_his_widgets/order_info_card_widget.dart';

class PointHisScreen extends StatefulWidget {
  const PointHisScreen({super.key});

  @override
  State<PointHisScreen> createState() => _PointHisScreenState();
}

class _PointHisScreenState extends State<PointHisScreen> {
  final OrderHisController controller = Get.find<OrderHisController>();
  late RefreshController _refreshController;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshController = RefreshController(initialRefresh: false);
      controller.getPointHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHisController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Dimesion.screenHeight / 11,
            leading: backButton(),
            backgroundColor: AppColor.primaryClr,
            centerTitle: true,
            title: Text(
              "Point History".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimesion.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(Dimesion.height10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: Dimesion.radius10 - 1,
                    color: AppColor.primaryClr,
                    animating: true,
                  ),
                ),
              );
            } else if (controller.pointHistoryList.isEmpty) {
              return Center(child: Text("No order history".tr));
            } else {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                footer: Obx(
                  () => footer(canLoadMore: controller.canLoadMore.value),
                ),
                onLoading: _onLoading,
                header: const WaterDropHeader(),
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  separatorBuilder:
                      (context, index) =>
                          SizedBox(height: Dimesion.height10 / 2),
                  padding: EdgeInsets.all(Dimesion.width5),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.pointHistoryList.length,
                  itemBuilder:
                      (context, index) => OpenContainer(
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionType: ContainerTransitionType.fadeThrough,
                        closedBuilder:
                            (_, close) => PointInfoCardWidget(
                              orderColor: controller.orderColor(
                                controller
                                        .orderColor(
                                          controller
                                                      .pointHistoryList[index]
                                                      .order
                                                      .toString() !=
                                                  "null"
                                              ? controller
                                                  .pointHistoryList[index]
                                                  .order!
                                                  .status
                                                  .toString()
                                              : "",
                                        )
                                        .toString() ??
                                    "",
                              ),
                              orderData: controller.pointHistoryList[index],
                            ),
                        openBuilder: (_, open) {
                          if (controller.pointHistoryList[index].order
                                  .toString() !=
                              "null") {
                            return PointHisDetailScreen(
                              orderColor: controller.orderColor(
                                controller
                                        .orderColor(
                                          controller
                                              .pointHistoryList[index]
                                              .order!
                                              .status
                                              .toString(),
                                        )
                                        .toString() ??
                                    "",
                              ),
                              orderData: controller.pointHistoryList[index],
                            );
                          } else {
                            return AlertDialog(
                              title: const Text("🎉 Welcome!"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Here are your starting points:"),
                                  SizedBox(height: 10),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Got it"),
                                ),
                              ],
                            );
                            ;
                          }
                        },
                      ),
                ),
              );
            }
          }),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.page.value = 1;
    controller.pointHistoryList.clear();
    controller.getPointHistory();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (controller.canLoadMore.value) {
      controller.page.value++;
      controller.getPointHistory();
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.loadComplete();
  }
}

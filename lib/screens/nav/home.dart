import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spjewellery/screens/chat_screen/chat_screen.dart';
import 'package:spjewellery/screens/nav/toolbar.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart'
    hide RefreshIndicator;

import '../../controllers/auth_controller.dart';
import '../../controllers/checkout_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_widgets/custom_loading_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/chat/pusher_config.dart';
import '../../models/chat/pusher_model.dart';
import '../chat_screen/chat_controller.dart';
import 'home_new_feed.dart';
import 'nav_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController controller = Get.find<ProductController>();
  final AuthController authController = Get.find<AuthController>();
  final ScrollController scrollController = new ScrollController();
  final CheckOutController checkOutController = Get.find<CheckOutController>();
  final NavController navController = Get.find<NavController>();
  final NotiController notiController = Get.find<NotiController>();
  final ChatController chatController = Get.put(ChatController());
  late PusherConfig pusherConfig;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAllPosts(isLoadmore: false);

      scrollController.addListener(() {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = 100.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          // whatever you determine here
          //.. load more
          _onLoading();
        }
      });

      notiController.getNotiList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (builder) {
        return Scaffold(
          backgroundColor: AppColor.bgColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => ChatScreen());
            },
            backgroundColor: AppColor.primaryClr,
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
          body: RefreshIndicator(
            child: CustomScrollView(
              controller: scrollController,
              // controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  toolbarHeight: Dimesion.screenHeight / 7,
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColor.myGreen, //changed by Wai
                  title: ToolbarWidget(
                    controller: controller,
                    navController: navController,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    NewFeedWidget(
                      controller: controller,
                      authController: authController,
                    ),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: Dimesion.width30,
                    height: Dimesion.height30,
                    child: Obx(
                      () =>
                          controller.moreLoading.value == true
                              ? CustomLoadingWidget()
                              : Container(),
                    ),
                  ),
                ),
              ],
            ),
            onRefresh: _onRefresh,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.page_post.value = 1;
    controller.getAllPosts(isLoadmore: false);
  }

  Future<void> _onLoading() async {
    if (controller.canLoadMorePost.value == true) {
      controller.page_post.value++;
      controller.getAllPostsMore(isLoadmore: false);
    }
  }
}

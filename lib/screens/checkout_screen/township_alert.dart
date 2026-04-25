import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../controllers/checkout_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/empty_view.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/township_cod_model.dart';
class TownshipAlert extends StatefulWidget {
  final List<TownShipCodData> datalist;
  final int regionId; // 🔥 PASS REGION ID

  const TownshipAlert({
    super.key,
    required this.datalist,
    required this.regionId,
  });

  @override
  State<TownshipAlert> createState() => _TownshipAlertState();
}

class _TownshipAlertState extends State<TownshipAlert> {
  final CheckOutController controller = Get.find<CheckOutController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// First load
      controller.pageTownShip.value = 1;
      controller.townShipList.clear();
      controller.getTownShipCOD(regionId: widget.regionId);

      /// Pagination listener
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
            controller.canLoadMore.value &&
            !controller.isLoading.value) {
          controller.onLoading();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (controller.townShipList.isEmpty) {
          return const EmptyViewWidget();
        }

        return SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: controller.canLoadMore.value,
          onRefresh: () async {
            controller.pageTownShip.value = 1;
            await controller.getTownShipCOD(regionId: widget.regionId);
            controller.refreshController.refreshCompleted();
          },
          onLoading: () async {
            controller.onLoading();
            controller.refreshController.loadComplete();
          },
          header: const WaterDropHeader(),
          child: ListView.builder(
            controller: scrollController,
            itemCount: controller.townShipList.length,
            itemBuilder: (context, index) {
              final town = controller.townShipList[index];

              return ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(town.city ?? ""),
                trailing: Text("${town.fee ?? 0} Ks"),
                onTap: () {
                  controller.onChangeTownShip(town);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selected: ${town.city}")),
                  );

                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      }),
    );
  }

  /// ---------------- APP BAR ----------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.bgColor,
      title: TextFormField(
        controller: controller.searchController,
        decoration: const InputDecoration(
          hintText: "Search Township",
          border: InputBorder.none,
        ),
        onChanged: (val) {
          controller.pageTownShip.value = 1;

          if (val.isNotEmpty) {
            EasyDebounce.debounce(
              'search-township',
              const Duration(milliseconds: 500),
              () => controller.getSearchTownShip(isLoadMore: false
               
              ),
            );
          } else {
            controller.getTownShipCOD(regionId: widget.regionId);
          }
        },
      ),
    );
  }
}

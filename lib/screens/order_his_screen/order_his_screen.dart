import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spjewellery/router/route_helper.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../controllers/order_his_controller.dart';
import '../../core/app_widgets/back_button.dart';
import '../../core/app_widgets/custom_loading_widget.dart';
import '../../core/app_widgets/footer_widget.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import 'order_his_detail_screen.dart';

class OrderHisScreen extends StatefulWidget {
  const OrderHisScreen({super.key});

  @override
  State<OrderHisScreen> createState() => _OrderHisScreenState();
}

class _OrderHisScreenState extends State<OrderHisScreen> {
  final OrderHisController controller = Get.find<OrderHisController>();
  late RefreshController _refreshController;
  final TextEditingController dobController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryClr, // light pink
        title: Text(
          "order_history".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              // handle calendar tap
              pickDobDate(context);
            },
          ),
          // 🔄 Reset filter (only show when date is selected)
          Obx(
            () =>
                controller.selectedDate.value.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      tooltip: "Reset date filter",
                      onPressed: () {
                        dobController.clear();
                        controller.resetDateFilter();
                      },
                    )
                    : const SizedBox(),
          ),

          IconButton(
            icon: const Icon(Icons.filter_list_outlined, color: Colors.white),
            onPressed: () {
              Get.toNamed(RouteHelper.filter);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CupertinoActivityIndicator(radius: 15, color: Colors.pink),
          );
        } else if (controller.orderList.isEmpty) {
          return const Center(child: Text("No order history"));
        } else {
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _onRefresh,
            enablePullUp: true,
            onLoading: _onLoading,
            header: const WaterDropHeader(),
            footer: const ClassicFooter(),
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: controller.orderList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final order = controller.orderList[index];
                final isCompleted =
                    order.status.toString().toLowerCase() == "completed";

                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => OrderHisDetailScreen(
                        orderData: order,
                        orderColor:
                            isCompleted ? Colors.green : Colors.orangeAccent,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID : ${order.id}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${order.grandTotal ?? "0"} MMK",
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Date : ${formatDate(order.createdAt)}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          // isCompleted ? "Completed" : "Pending",
                          order.status ?? 'N/A',
                          style: TextStyle(
                            color:
                                isCompleted
                                    ? Colors.green
                                    : Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.page.value = 1;
    controller.orderList.clear();
    controller.getOrder();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (controller.canLoadMore.value) {
      controller.page.value++;
      controller.getOrder();
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.loadComplete();
  }

  Future<void> pickDobDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.tryParse(dobController.text) ??
          DateTime.now(), // 👈 current date
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryClr,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryClr,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            dialogBackgroundColor: AppColor.white,
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(picked);
      dobController.text = formatted;

      controller.filterByDate(formatted); // 👈 this is the magic
    }
  }
}

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return '';

  try {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  } catch (e) {
    return dateString; // fallback
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:spjewellery/controllers/product_controller.dart';
import 'package:spjewellery/core/constants/app_color.dart';
import 'package:spjewellery/router/route_helper.dart';
import 'package:spjewellery/screens/nav/category_brand_page.dart';

class Shopbrand extends StatelessWidget {
  final ProductController controller;
  const Shopbrand({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.categorylist.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "brand".tr,
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            controller.navController.tabIndex.value = 2;
                          },
                          child: Text(
                            "See all",
                            style: GoogleFonts.outfit(
                              textStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Gap(6),

                    /// Category List
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.brandlist.length,
                        itemBuilder: (context, index) {
                          final data = controller.brandlist[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.category_brand,
                                arguments: CategoryBrandPage(
                                  id: data.id!,
                                  isCategory: true,
                                  name: data.name.toString(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primaryClr, // soft pink
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    backgroundImage: CachedNetworkImageProvider(
                                      data.image.toString(),
                                    ),
                                  ),
                                  const Gap(8),
                                  Text(
                                    data.name.toString(),
                                    style: GoogleFonts.outfit(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox(),
    );
  }
}

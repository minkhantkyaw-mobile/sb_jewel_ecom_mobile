import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/category_model.dart';
import '../../router/route_helper.dart';
import 'category_brand_page.dart';
import 'sub_category.dart';

// class ShopCategoryWidget extends StatelessWidget {
//   final ProductController controller;
//   const ShopCategoryWidget({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () =>
//           controller.categorylist.length != 0
//               ? Container(
//                 padding: EdgeInsets.only(
//                   left: Dimesion.size10,
//                   right: Dimesion.size10,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "categories".tr,
//                           style: GoogleFonts.outfit(
//                             textStyle: TextStyle(
//                               color: AppColor.black,
//                               fontSize: Dimesion.font14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         CupertinoButton(
//                           child: Row(
//                             children: [
//                               Text(
//                                 "see_all".tr,
//                                 style: GoogleFonts.outfit(
//                                   textStyle: TextStyle(
//                                     color: AppColor.blackless,
//                                     fontSize: Dimesion.font12,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.chevron_right,
//                                 size: 15,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                           onPressed: () {
//                             controller.navController.tabIndex.value = 2;
//                             //Get.toNamed(RouteHelper.team_see_more,arguments: TeamSeeMore(homeController: controller,));
//                           },
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: Dimesion.height40+54,
//                       child: ListView.builder(
//                         padding: EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: controller.categorylist.length,
//                         itemBuilder: (context, index) {
//                           CategoryData data = controller.categorylist[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Get.toNamed(RouteHelper.category_brand,arguments: CategoryBrandPage(id: controller.categorylist[index].id!, isCategory: true, name: controller.categorylist[index].name.toString()));

//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: AppColor.primaryClr,
//                                 borderRadius: BorderRadius.circular(10)
//                               ),
//                               margin: EdgeInsets.only(right: Dimesion.width5),
//                               width: Dimesion.screeWidth / 5,
//                               height: Dimesion.height40+50,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   CircleAvatar(backgroundImage: CachedNetworkImageProvider(controller
//                                       .categorylist[index]
//                                       .image
//                                       .toString()),radius: 25,),
//                                   Gap(10),
//                                   Text(
//                                     data.name.toString(),
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                   ),

//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//               : Container(),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

class ShopCategoryWidget extends StatelessWidget {
  final ProductController controller;
  const ShopCategoryWidget({super.key, required this.controller});

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
                          "category".tr,
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
                        itemCount: controller.categorylist.length,
                        itemBuilder: (context, index) {
                          final data = controller.categorylist[index];
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

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../controllers/product_controller.dart';
// import '../../core/constants/app_color.dart';
// import '../../core/constants/dimesions.dart';
// import '../../router/route_helper.dart';
// import 'category_brand_page.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'sub_category.dart';

// class CategoryWidget extends StatelessWidget {
//   final ProductController controller;

//   const CategoryWidget({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () =>
//           controller.categorylist.length != 0
//               ? SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 padding: EdgeInsets.all(Dimesion.width10),
//                 child: MasonryGridView.count(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   itemCount: controller.categorylist.length,
//                   crossAxisCount: 2,
//                   mainAxisSpacing: Dimesion.screenHeight / 45,
//                   crossAxisSpacing: Dimesion.screeWidth / 17,
//                   itemBuilder: (context, index) {
//                     return ElevatedButton(
//                       onPressed: () {
//                         Get.to(
//                           SubCategory(
//                             controller: controller,
//                             categoryName:
//                                 controller.categorylist[index].name.toString(),
//                             categoryId: controller.categorylist[index].id!,
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: HexColor('#FAB83E'),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         controller.categorylist[index].name.toString(),
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.outfit(
//                           textStyle: TextStyle(
//                             color: AppColor.black,
//                             fontSize: Dimesion.font14 - 3,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//               : Container(),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../router/route_helper.dart';
import 'category_brand_page.dart';
import 'sub_category.dart';

class CategoryWidget extends StatelessWidget {
  final ProductController controller;

  const CategoryWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.categorylist.isNotEmpty
              ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(Dimesion.width10),
                child: MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.categorylist.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimesion.screenHeight / 45,
                  crossAxisSpacing: Dimesion.screeWidth / 17,
                  itemBuilder: (context, index) {
                    final category = controller.categorylist[index];
                    return ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          RouteHelper.category_brand,
                          arguments: CategoryBrandPage(
                            id: controller.categorylist[index].id!,
                            isCategory: true,
                            name:
                                controller.categorylist[index].name.toString(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.bottomBgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        child: Text(
                          category.name ?? '',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: AppColor.white,
                              fontSize: Dimesion.font14 - 3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              : SizedBox.shrink(),
    );
  }
}

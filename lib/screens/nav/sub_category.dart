import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../core/app_widgets/back_button.dart';
import 'category_brand_page.dart';

class SubCategory extends StatefulWidget {
  final ProductController controller;
  final int categoryId;
  final String categoryName;

  const SubCategory({
    super.key,
    required this.controller,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSubCategories();
  }

  Future<void> _loadSubCategories() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await widget.controller.getAllSubCategory(widget.categoryId);
    } catch (e) {
      _error = "Failed to load subcategories. Please try again.";
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimesion.screenHeight / 10,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: backButtonBlack(),
        centerTitle: true,
        title: Text(
          widget.categoryName.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimesion.font16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _loadSubCategories,
                      child: Text("Retry".tr),
                    ),
                  ],
                ),
              )
              : Obx(() {
                final subCategoryList = widget.controller.subCategoryList;

                if (subCategoryList.isEmpty) {
                  return  Center(
                    child: Text("No subcategories found".tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(Dimesion.width10),
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimesion.screenHeight / 45,
                    crossAxisSpacing: Dimesion.screeWidth / 17,
                    itemCount: subCategoryList.length,
                    itemBuilder: (context, index) {
                      final subCategory = subCategoryList[index];
                      final subCategoryName = subCategory.name ?? '';
                      final subCategoryId = subCategory.id;
                      return ElevatedButton(
                        onPressed: () {
                          if (subCategoryId != null) {
                            /*Get.to(
                              () => CategoryBrandPage(
                                // controller: widget.controller,
                                // id: subCategoryId,
                                subCategoryId: subCategoryId,
                                title: subCategoryName,
                                // isCategory: false,
                                // name: subCategoryName,
                              ),
                            );*/
                          } else {
                            Get.snackbar(
                              "Error",
                              "Invalid category",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.shade100,
                              colorText: Colors.black,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor('#FAB83E'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          subCategoryName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: AppColor.black,
                              fontSize: Dimesion.font14 - 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
    );
  }
}

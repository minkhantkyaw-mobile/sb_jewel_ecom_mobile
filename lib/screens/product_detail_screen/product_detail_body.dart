import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spjewellery/controllers/cart_controller.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';

class ProductDetailBodyView extends StatefulWidget {
  final ProductData data;
  const ProductDetailBodyView({super.key, required this.data});

  @override
  State<ProductDetailBodyView> createState() => _ProductDetailBodyViewState();
}

class _ProductDetailBodyViewState extends State<ProductDetailBodyView> {
  String _selectedSize = '';
  final CartController cartController = Get.find<CartController>();
  final ProductController productController = Get.find();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    // Safe initialization WITHOUT setState
    cartController.sizeId.value = 0;

    final sizes = widget.data.sizes;
    if (sizes != null && sizes.isNotEmpty) {
      final firstSize = sizes[0];
      if ((firstSize.name ?? '').toLowerCase() == 'free') {
        _selectedSize = firstSize.name ?? '';
        cartController.sizeId.value = firstSize.id ?? 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = widget.data.sizes ?? [];

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildPointsDisplay(),
          // const SizedBox(height: 16),
          _buildTitleAndPrice(widget.data),
          const SizedBox(height: 24),
          if (sizes.isNotEmpty)
            _buildSizeSelector(
              title: 'Size',
              options: sizes,
              selectedOption: _selectedSize,
              onSelected: (size) => setState(() => _selectedSize = size),
              onSelectedId: (int value) {
                cartController.sizeId.value = value;
              },
            ),
          const SizedBox(height: 24),
          if (widget.data.description?.isNotEmpty ?? false) ...[
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 17),
            HtmlWidget(widget.data.description ?? ''),
          ],
          const SizedBox(height: 20),
          _buildYouMayLikeSection(),
        ],
      ),
    );
  }

  Widget _buildPointsDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: AppColor.buttonColor, size: 16),
          const SizedBox(width: 6),
          Obx(
            () => Text(
              'Current Point: ${authController.userData.value.currentPointAmount}',
              style: TextStyle(
                color: AppColor.buttonColor,
                fontWeight: FontWeight.w500,
                fontSize: Dimesion.font14 - 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYouMayLikeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "You May Like",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Obx(() {
          final related =
              productController.singleProduct.value.relatedProducts ?? [];
          if (related.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("No Related Products"),
            );
          }
          return SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: related.length,
              itemBuilder: (context, index) {
                final item = related[index];
                return GestureDetector(
                  onTap: () {
                    productController.getProductDetail(id: item.id ?? 0);
                  },
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            item.images?.first ?? "",
                            height: 100,
                            width: 140,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) =>
                                    const Icon(Icons.image_not_supported),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            item.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${item.price ?? 0} Ks",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

Widget _buildTitleAndPrice(ProductData data) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        data.name.toString(),
        style: TextStyle(
          fontSize: Dimesion.font16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "${DataConstant.priceFormat.format(int.parse(data.price.toString() != "null" ? data.price.toString() : "0"))} Ks",
        style: TextStyle(
          fontSize: Dimesion.font14,
          fontWeight: FontWeight.bold,
          color: AppColor.buttonColor,
        ),
      ),
    ],
  );
}

Widget _buildSizeSelector({
  required String title,
  required List<Sizes> options,
  required String selectedOption,
  required ValueChanged<int> onSelectedId,
  required ValueChanged<String> onSelected,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: Dimesion.font14 - 2,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 12),
      Row(
        children:
            options.map((option) {
              final isSelected = selectedOption == option.name;
              return GestureDetector(
                onTap: () {
                  onSelected(option.name!);
                  onSelectedId(option.id!);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.buttonColor : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.buttonColor, width: 1),
                  ),
                  child: Text(
                    option.name!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColor.buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    ],
  );
}

Widget _buildColorSelector({
  required String title,
  required List<ColorData> options,
  required String selectedOption,
  required ValueChanged<int> onSelectedID,
  required ValueChanged<String> onSelected,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: Dimesion.font14 - 2,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 12),
      Row(
        children:
            options.map((option) {
              final isSelected = selectedOption == option.name;
              return GestureDetector(
                onTap: () {
                  onSelected(option.name!);
                  onSelectedID(option.id!);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? AppColor.buttonColor
                            : AppColor.bottomBgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.buttonColor, width: 1),
                  ),
                  child: Text(
                    option.name!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColor.buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    ],
  );
}

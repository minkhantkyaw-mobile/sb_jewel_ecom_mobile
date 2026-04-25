import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/dimesions.dart';
import '../../models/product_model.dart';

class ExchangeProductDetailBodyView extends StatefulWidget {
  final ProductData data;
  const ExchangeProductDetailBodyView({super.key, required this.data});

  @override
  State<ExchangeProductDetailBodyView> createState() => _ExchangeProductDetailBodyViewState();
}

class _ExchangeProductDetailBodyViewState extends State<ExchangeProductDetailBodyView> {
  String _selectedSize = '';
  final CartController cartController = Get.find<CartController>();
  final AuthController authController = Get.find<AuthController>();


  @override
  void initState() {
    setState(() {
      cartController.sizeId.value=0;
      if(widget.data.sizes!.length!=0){
        if(widget.data.sizes![0].name!.toLowerCase()=="free"){
          _selectedSize=widget.data.sizes![0].name.toString();
          cartController.sizeId.value=widget.data.sizes![0].id!;
        }
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: Dimesion.width5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsDisplay(),
          SizedBox(height: 16),
          _buildTitleAndPrice(widget.data),
          SizedBox(height: 24),
          _buildSizeSelector(
            title: 'Size',
            options: widget.data.sizes!,
            selectedOption: _selectedSize,
            onSelected: (size) => setState(() => _selectedSize = size), onSelectedId: (int value) {
            setState(() {
              cartController.sizeId.value=value;
            });
          },
          ),

          SizedBox(height: 24),
          if (widget.data
              .variations !=
              null)

            SizedBox(height: 10),
          //product detail
          if(widget.data.description.toString()!="null")
            Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 17),
          if(widget.data.description.toString()!="null")
          HtmlWidget(
            widget.data.description
                .toString() ??
                '',
          ),
          SizedBox(height: 20),
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
        children:  [
          Icon(Icons.star, color: AppColor.buttonColor, size: 16),
          SizedBox(width: 6),
          Obx(()=>Text(
            'Current Point: '+authController.userData.value.currentPointAmount.toString(),
            style: TextStyle(color: AppColor.buttonColor, fontWeight: FontWeight.w500,fontSize: Dimesion.font14-3),
          )),
        ],
      ),
    );
  }
}



Widget _buildTitleAndPrice(ProductData data) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:  [
      Text(
        data.name.toString(),
        style: TextStyle(fontSize: Dimesion.font16, fontWeight: FontWeight.bold),
      ),
      Text(
        data.requiredPoint.toString()+" Points",
        style: TextStyle(fontSize: Dimesion.font14, fontWeight: FontWeight.bold, color: AppColor.buttonColor),
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
      Text(title, style:  TextStyle(fontSize: Dimesion.font14-2, fontWeight: FontWeight.w600)),
      SizedBox(height: 12),
      Row(
        children: options.map((option) {
          final isSelected = selectedOption == option.name;
          return GestureDetector(
            onTap: () {
              onSelected(option.name!);
              onSelectedId(option.id!);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.buttonColor : AppColor.bottomBgColor,
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
      Text(title, style:  TextStyle(fontSize: Dimesion.font14-2, fontWeight: FontWeight.w600)),
      SizedBox(height: 12),
      Row(
        children: options.map((option) {
          final isSelected = selectedOption == option.name;
          return GestureDetector(
            onTap: () {
              onSelected(option.name!);
              onSelectedID(option.id!);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.buttonColor : AppColor.bottomBgColor,
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
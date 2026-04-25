import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../controllers/cart_controller.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/dimesions.dart';
import '../../../controllers/product_controller.dart';
class ProductBottomBar extends GetView<CartController> {
  final int productVariationId;
  final ProductController productController;
  const ProductBottomBar({
    super.key,
    required this.productController,
    required this.productVariationId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
          color: AppColor.primaryClr,),
      padding: EdgeInsets.only(
          bottom: Dimesion.height15,
          top: Dimesion.height15,
          left: Dimesion.height10,
          right: Dimesion.height10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Gap(Dimesion.width5),
        Container(
          height: Dimesion.height40 * 1.1,
          padding: EdgeInsets.all(Dimesion.width5 / 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimesion.radius10)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () =>{
                    // productController.changeQuantity(isIncrease: false)
                  },
                  icon: const Icon(Icons.remove,color: AppColor.red,)),
              Text("1".tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                  onPressed: () =>{
                    //  productController.changeQuantity(isIncrease: true);
                  },
                  icon: const Icon(Icons.add,color: AppColor.red,)),
            ],
          ),
        ),
        SizedBox(
          width: Dimesion.width10,
        ),
        Container(
          padding: EdgeInsets.only(left: Dimesion.width30,right: Dimesion.width30,top: Dimesion.height5+4,bottom: Dimesion.height5+4),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          child: Row(
            children: [
              Image.asset("assets/img/cat_vector_fill.png",width: Dimesion.iconSize25,height: Dimesion.iconSize25,),
              Gap(Dimesion.width10),
              Text("Add to Cart".tr.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold,color: AppColor.primaryClr,),
              )
            ],
          ),
        ),
      ]),
    );
  }
}


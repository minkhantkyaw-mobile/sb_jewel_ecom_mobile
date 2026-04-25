import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import '../../controllers/product_controller.dart';
import '../../core/app_widgets/my_cache_img.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/data_constant.dart';
import '../../core/constants/dimesions.dart';
import '../../models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductData data;
  final ProductController controller;
  const ProductCardWidget({
    super.key,
    required this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimesion.radius5),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCacheImg(
                      url: data.images![0].toString(),
                      width: MediaQuery.of(context).size.width,
                      height: Dimesion.screenHeight / 6,
                      boxfit: BoxFit.cover,
                      borderRadius: BorderRadius.zero,
                    ),
                    Gap(3),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimesion.font14-2,
                              color: AppColor.black,
                            ),
                          ),

                          Text(
                            data.category.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: Dimesion.font12-2,
                              color: AppColor.blackless,
                            ),
                          ),
                          SizedBox(height: Dimesion.height5),
                          Text("${DataConstant.priceFormat.format(int.parse(data.price.toString() != "null" ? data.price.toString() : "0"))} Ks",
                            softWrap: true,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: Dimesion.height10,
                  right: Dimesion.width5,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.addWishList(id: data.id!.toInt());
                      },
                      child:
                          data.isWishlist == 0
                              ? Icon(
                                CupertinoIcons.heart,
                                size: Dimesion.iconSize16,
                                color: Color(0xFFDD1504),
                              )
                              : Icon(
                                CupertinoIcons.heart_fill,
                                size: Dimesion.iconSize16,
                                color: Color(0xFFDD1504),
                              ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}


class ProductExchangeCardWidget extends StatelessWidget {
  final ProductData data;
  final ProductController controller;
  const ProductExchangeCardWidget({
    super.key,
    required this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimesion.radius5),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCacheImg(
                      url: data.images![0].toString(),
                      width: MediaQuery.of(context).size.width,
                      height: Dimesion.screenHeight / 6,
                      boxfit: BoxFit.cover,
                      borderRadius: BorderRadius.zero,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(3),
                          Text(
                            data.name.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimesion.font14-2,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            data.category.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: Dimesion.font12-2,
                              color: AppColor.blackless,
                            ),
                          ),
                          SizedBox(height: Dimesion.height5),
                          Row(
                            children: [
                              Icon(Icons.star,size: 16,color: Colors.orange,),
                              Text(data.requiredPoint.toString()+" Points",)
                            ],
                          ),
                          Gap(3),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              width: Dimesion.screeWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColor.primaryClr
                              ),
                              child: Text("Exchange".tr),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: Dimesion.height10,
                  right: Dimesion.width5,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.addWishList(id: data.id!.toInt());
                      },
                      child:
                      data.isWishlist == 0
                          ? Icon(
                        CupertinoIcons.heart,
                        size: Dimesion.iconSize16,
                        color: Color(0xFFDD1504),
                      )
                          : Icon(
                        CupertinoIcons.heart_fill,
                        size: Dimesion.iconSize16,
                        color: AppColor.red,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

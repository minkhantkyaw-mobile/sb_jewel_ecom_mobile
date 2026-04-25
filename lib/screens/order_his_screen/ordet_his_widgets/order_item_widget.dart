import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/data_constant.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/order_detail_model.dart';
import '../../../models/order_history_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;
  const OrderItemWidget({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimesion.width5),
      padding: EdgeInsets.all(Dimesion.width5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
        color: Colors.grey.shade100,
      ),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 1,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimesion.width10,
                top: Dimesion.height5,
                right: Dimesion.width5,
                bottom: Dimesion.height5,
              ),
              width: Dimesion.screeWidth,
              child: Row(
                children: [
                  CachedNetworkImage(
                    alignment: Alignment.center,
                    width: Dimesion.screeWidth / 4,
                    height: Dimesion.screenHeight / 9,
                    imageUrl: orderItem.product!.images![0].toString(),
                    placeholder: (context, url) => Container(),
                    errorWidget:
                        (context, url, error) => Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/img/logo.png"),
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                    imageBuilder: (context, img) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimesion.radius5),
                          image: DecorationImage(
                            image: img,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            alignment: FractionalOffset.center,
                          ),
                        ),
                      );
                    },
                  ),
                  Gap(Dimesion.width10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItem.product!.name.toString(),
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: AppColor.black,
                              fontSize: Dimesion.font14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "Qty : ".tr +
                              orderItem.quantity.toString() +
                              "   " +
                              "Size : " +
                              (orderItem.size?.name ?? '-'),
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: AppColor.black,
                              fontSize: Dimesion.font12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Text(
                          "${DataConstant.priceFormat.format(orderItem.product!.price)} Ks"
                              .tr,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: AppColor.black,
                              fontSize: Dimesion.font14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(Dimesion.width5),
                ],
              ),
            ),
          ),
          /*Card(
            color: Colors.white,
            elevation: 1,
            child: Container(
              padding: EdgeInsets.only(left: Dimesion.width10,top: Dimesion.height5,right: Dimesion.width5,bottom: Dimesion.height5),
              width: Dimesion.screeWidth,
              child: Row(
                children: [
                  CachedNetworkImage(
                    alignment: Alignment.center,
                    width: Dimesion.screeWidth/4,height: Dimesion.screenHeight/9,
                    imageUrl: "https://cdn.thewirecutter.com/wp-content/media/2024/05/running-shoes-2048px-9718.jpg",
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Container(
                      decoration:  const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/logo.png"),
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high)),
                    ),
                    imageBuilder: (context, img) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimesion.radius5),
                            image: DecorationImage(
                              image: img,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              alignment: FractionalOffset.center,
                            )),
                      );
                    },
                  ),
                  Gap(Dimesion.width10),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Testing".tr,
                        style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.black,fontSize: Dimesion.font14,fontWeight: FontWeight.bold)),
                      ),
                      Text("Size : 40".tr,
                        style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.black,fontSize: Dimesion.font14,fontWeight: FontWeight.normal)),
                      ),
                      Row(
                        children: [
                          Text("Color : ".tr,
                            style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.black,fontSize: Dimesion.font14,fontWeight: FontWeight.normal)),
                          ),
                          Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 3),
                            // padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: Dimesion.height15,
                            width: Dimesion.width30,
                            decoration: BoxDecoration(
                                color: AppColor.blue,
                                shape: BoxShape.circle),
                          ),

                        ],
                      ),
                      Text("${DataConstant.priceFormat.format(10000)} Ks".tr,
                        style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.black,fontSize: Dimesion.font14,fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
                  Gap(Dimesion.width5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Gap(Dimesion.height10),
                      Text("Qty : 10".tr,
                        style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.black,fontSize: Dimesion.font14,fontWeight: FontWeight.normal)),
                      ),
                      Text("Wholesale".tr,
                        style: GoogleFonts.outfit(textStyle:  TextStyle(color: AppColor.blackless,fontSize: Dimesion.font14,fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

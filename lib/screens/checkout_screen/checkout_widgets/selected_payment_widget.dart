import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../core/app_data.dart';
import '../../../core/app_widgets/my_cache_img.dart';
import '../../../core/app_widgets/view_image_screen.dart';
import '../../../core/constants/dimesions.dart';
import '../../../models/payment_model.dart';
import '../../../services/toast_service.dart';

class SelectPaymentWidget extends StatefulWidget {
  final PaymentData paymentData;
  const SelectPaymentWidget({
    super.key,
    required this.paymentData
  });

  @override
  State<SelectPaymentWidget> createState() => _SelectPaymentWidgetState();
}

class _SelectPaymentWidgetState extends State<SelectPaymentWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimesion.screeWidth,
      child: Row(
        children: [
          MyCacheImg(
            height: Dimesion.height40,
            width: Dimesion.height40,
            // url: AppPngs.testNetWorkPaymentImg ?? "",
            url: widget.paymentData.paymentLogo.toString(),
            boxfit: BoxFit.cover,
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
          ),
          SizedBox(width: Dimesion.width5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.paymentData.name ?? "",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  widget.paymentData.number ?? "",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(width: Dimesion.width5),

          SizedBox(width: Dimesion.width5),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConfig {
  static String appName = "SoFresh ";
  static String appSpanName = "Clothing";
  static String appTagLine = "STANDARD";
}

enum OrderStatus {
  pending(desc: "pending"),
  confirmed(desc: "confirmed"),
  delivered(desc: "delivered"),
  completed(desc: "completed"),
  refunded(desc: "refunded"),
  cancelled(desc: "cancel");

  final String desc;
  const OrderStatus({required this.desc});
}

enum AppLanguage {
  en(desc: "English"),
  mm(desc: "မြန်မာ");

  final String desc;
  const AppLanguage({required this.desc});
}

class AppDateFormat {
  static DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  static DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy / hh:mm:ss a");
  static NumberFormat numberFormat = NumberFormat("#,###");
}

class AppPngs {
  static String lowStock = "assets/png/low_stock.png";
  static String totalProduct = "assets/png/total_product.png";
  static String todayOrder = "assets/png/today_order.png";
  static String totalOrder = "assets/png/total_order.png";
  static String totalUser = "assets/png/total_users.png";
  static String todayEarn = "assets/png/today_earn.png";
  static String monthlyEarn = "assets/png/monthly_earn.png";
  static String yearlyEarn = "assets/png/yearly_earn.png";
  static String testNetworkProductImg =
      "https://marvel-b1-cdn.bc0a.com/f00000000114841/www.florsheim.com/shop/index/FW24-FL-SecondRefresh-DressNorwalk-Desktop.jpg";
  static String testNetworkDeliImg =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnBQn3dvDrmsd6AgRLK4Dot69kgmxZt18bPw&s";

  static String testNetWorkPaymentImg =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhOW3c3zs4qjIEUULmI2WxpRiilojbFUoCBA&s";
}

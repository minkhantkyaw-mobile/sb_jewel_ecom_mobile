import 'package:spjewellery/models/product_model.dart';

class WishListModel {
  bool? success;
  String? token;
  List<ProductData>? data;

  WishListModel({this.success, this.token, this.data});

  WishListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

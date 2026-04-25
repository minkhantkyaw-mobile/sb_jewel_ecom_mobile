import 'package:spjewellery/models/product_model.dart';

class ExchangeModel {
  bool? success;
  String? currentPointAmount;
  int? total;
  bool? canLoadMore;
  List<ProductData>? data;

  ExchangeModel({
    this.success,
    this.currentPointAmount,
    this.total,
    this.canLoadMore,
    this.data,
  });

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    currentPointAmount = json['current_point_amount'];
    total = json['total'];
    canLoadMore = json['can_load_more'];
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
    data['current_point_amount'] = this.currentPointAmount;
    data['total'] = this.total;
    data['can_load_more'] = this.canLoadMore;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

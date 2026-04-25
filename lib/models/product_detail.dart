import 'package:spjewellery/models/product_model.dart';

class ProductDetailModel {
  bool? success;
  String? message;
  ProductData? product;
  List<ProductData>? relatedProducts;

  ProductDetailModel({
    this.success,
    this.message,
    this.product,
    this.relatedProducts,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      success: json['success'],
      message: json['message'],
      product:
          json['data'] != null && json['data']['product'] != null
              ? ProductData.fromJson(json['data']['product'])
              : null,
      relatedProducts:
          json['data'] != null && json['data']['related_products'] != null
              ? List<ProductData>.from(
                json['data']['related_products'].map(
                  (e) => ProductData.fromJson(e),
                ),
              )
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {
        'product': product?.toJson(),
        'related_products':
            relatedProducts?.map((e) => e.toJson()).toList() ?? [],
      },
    };
  }
}

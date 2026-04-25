import 'product_model.dart';

/// Safe Cart Model
class CartModel {
  final String? message;
  final List<CartData> data;
  final int totalQuantity;
  final int totalAmount;
  final double totalDiscount;
  final int finalAmount;
  final int totalPoints;
  final String? membership;

  CartModel({
    this.message,
    required this.data,
    required this.totalQuantity,
    required this.totalAmount,
    required this.totalDiscount,
    required this.finalAmount,
    required this.totalPoints,
    this.membership,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => CartData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalQuantity: json['total_quantity'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      totalDiscount: (json['total_discount'] ?? 0).toDouble(),
      finalAmount: json['final_amount'] ?? 0,
      totalPoints: json['total_points'] ?? 0,
      membership: json['membership'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'total_quantity': totalQuantity,
    'total_amount': totalAmount,
    'total_discount': totalDiscount,
    'final_amount': finalAmount,
    'total_points': totalPoints,
    'membership': membership,
  };
}

/// Safe Cart Item
class CartData {
  final ProductData? product;
  final int quantity;
  final int subtotal;
  final int discount;
  final int finalSubtotal;
  final int earnedPoint;
  final String? size;
  final CartColor? color; // Renamed to avoid conflict with Flutter Color

  CartData({
    this.product,
    required this.quantity,
    required this.subtotal,
    required this.discount,
    required this.finalSubtotal,
    required this.earnedPoint,
    this.size,
    this.color,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      product:
          json['product'] != null
              ? ProductData.fromJson(json['product'])
              : null,
      quantity: json['quantity'] ?? 0,
      subtotal: json['subtotal'] ?? 0,
      discount: json['discount'] ?? 0,
      finalSubtotal: json['final_subtotal'] ?? 0,
      earnedPoint: json['earned_point'] ?? 0,
      size: json['size'] as String?,
      color: json['color'] != null ? CartColor.fromJson(json['color']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'product': product?.toJson(),
    'quantity': quantity,
    'subtotal': subtotal,
    'discount': discount,
    'final_subtotal': finalSubtotal,
    'earned_point': earnedPoint,
    'size': size,
    'color': color?.toJson(),
  };
}

/// Cart color model (avoid conflict with Flutter Color)
class CartColor {
  final String? name;
  final String? hex;

  CartColor({this.name, this.hex});

  factory CartColor.fromJson(Map<String, dynamic> json) =>
      CartColor(name: json['name'] as String?, hex: json['hex'] as String?);

  Map<String, dynamic> toJson() => {'name': name, 'hex': hex};
}

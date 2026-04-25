class CartOrderModel {
  String? productId;
  String? productVariationId;
  String? quantity;
  String? color;
  String? price;
  String? totalPrice;

  CartOrderModel({
    this.productId,
    this.productVariationId,
    this.quantity,
    this.color,
    this.price,
    this.totalPrice,
  });

  CartOrderModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productVariationId = json['product_variation_id'];
    quantity = json['quantity'];
    color = json['color'];
    price = json['price'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_variation_id'] = this.productVariationId;
    data['quantity'] = this.quantity;
    data['color'] = this.color;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

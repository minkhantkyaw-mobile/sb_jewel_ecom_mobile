import 'package:spjewellery/models/product_model.dart';

class CartModel {
  int? productId;
  int? quantity;
  int? option_id;
  dynamic? name;
  VariationCart? variations;
  VolumePrices? volumePrices;
  dynamic? price;
  dynamic? image;
  dynamic? totalPrice;
  int? isWholeSale = 0;
  dynamic? productCode; // <-- Added

  CartModel({
    this.productId,
    this.quantity,
    this.option_id,
    this.name,
    this.variations,
    this.volumePrices,
    this.price,
    this.image,
    this.totalPrice,
    this.isWholeSale,
    this.productCode, // <-- Added
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    option_id = json['option_id'];
    name = json['name'];
    variations =
        json['variations'] != null
            ? VariationCart.fromJson(json['variations'])
            : null;
    volumePrices =
        json['volume_prices'] != null
            ? VolumePrices.fromJson(json['volume_prices'])
            : null;
    price = json['price'];
    image = json['image'];
    totalPrice = json['total_price'];
    productCode = json['product_code']; // <-- Added
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['option_id'] = option_id;
    data['name'] = name;
    if (variations != null) {
      data['variations'] = variations!.toJson();
    }
    if (volumePrices != null) {
      data['volume_prices'] = volumePrices!.toJson();
    }
    data['price'] = price;
    data['image'] = image;
    data['total_price'] = totalPrice;
    data['product_code'] = productCode; // <-- Added
    return data;
  }
}

class VariationCart {
  int? id;
  String? name;
  String? type;
  int? price;
  int? stock;
  Options? options;
  String? productCode;

  VariationCart({
    this.id,
    this.name,
    this.type,
    this.price,
    this.stock,
    this.options,
    this.productCode,
  });

  VariationCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    stock = json['stock'];
    productCode = json['product_code'];
    options =
        json['options'] != null ? Options.fromJson(json['options']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['price'] = price;
    data['stock'] = stock;
    data['product_code'] = productCode;
    if (options != null) {
      data['options'] = options!.toJson();
    }
    return data;
  }
}

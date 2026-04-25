import 'package:spjewellery/models/payment_model.dart';
import 'package:spjewellery/models/product_model.dart';

class OrderHistoryModel {
  bool? success;
  String? message;
  List<OrderHistoryData>? data;

  OrderHistoryModel({this.success, this.message, this.data});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new OrderHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistoryData {
  int? id;
  int? customerId;
  String? paymentMethod;
  dynamic? paymentId;
  String? paymentPhoto;
  String? name;
  String? phone;
  String? region;
  String? productCode; // Product Code
  String? city;
  String? address;
  String? deliveryFee;
  String? subTotal;
  String? grandTotal;
  String? cancelMessage;
  String? refundDate;
  String? refundMessage;
  String? status;
  String? createdAt;
  List<OrderItem>? orderItem;
  PaymentData? payment;

  OrderHistoryData({
    this.id,
    this.customerId,
    this.paymentMethod,
    this.paymentId,
    this.paymentPhoto,
    this.name,
    this.phone,
    this.region,
    this.city,
    this.address,
    this.deliveryFee,
    this.subTotal,
    this.grandTotal,
    this.cancelMessage,
    this.refundDate,
    this.refundMessage,
    this.status,
    this.createdAt,
    this.orderItem,
    this.payment,
  });

  OrderHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    paymentMethod = json['payment_method'];
    paymentId = json['payment_id'];
    paymentPhoto = json['payment_photo'];
    name = json['name'];
    phone = json['phone'];
    region = json['region'];
    city = json['city'];
    address = json['address'];
    deliveryFee = json['delivery_fee'];
    subTotal = json['sub_total'];
    productCode = json['product_code']; // Product Code
    grandTotal = json['grand_total'];
    cancelMessage = json['cancel_message'];
    refundDate = json['refund_date'];
    refundMessage = json['refund_message'];
    status = json['status'];
    createdAt = json['created_at'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
    payment =
        json['payment'] != null
            ? new PaymentData.fromJson(json['payment'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['payment_method'] = this.paymentMethod;
    data['payment_id'] = this.paymentId;
    data['payment_photo'] = this.paymentPhoto;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['region'] = this.region;
    data['city'] = this.city;
    data['address'] = this.address;
    data['delivery_fee'] = this.deliveryFee;
    data['sub_total'] = this.subTotal;
    data['grand_total'] = this.grandTotal;
    data['cancel_message'] = this.cancelMessage;
    data['refund_date'] = this.refundDate;
    data['refund_message'] = this.refundMessage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['product_code'] = this.productCode; // Product Code
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class OrderItem {
  int? id;
  String? orderId;
  String? productId;
  String? price;
  String? quantity;
  String? totalPrice;
  String? createdAt;
  ProductData? product;
  dynamic? orderVariation;
  dynamic? orderVariationOption;
  Sizes? size;
  ColorData? color;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.price,
    this.quantity,
    this.totalPrice,
    this.createdAt,
    this.product,
    this.orderVariation,
    this.orderVariationOption,
    this.size,
    this.color,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    price = json['price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    product =
        json['product'] != null
            ? new ProductData.fromJson(json['product'])
            : null;
    orderVariation = json['order_variation'];
    orderVariationOption = json['order_variation_option'];
    size = json['size'] != null ? new Sizes.fromJson(json['size']) : null;
    color =
        json['color'] != null ? new ColorData.fromJson(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['order_variation'] = this.orderVariation;
    data['order_variation_option'] = this.orderVariationOption;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    return data;
  }
}

class VolumePrices {
  int? id;
  int? productId;
  int? quantity;
  int? discountPrice;
  String? createdAt;
  String? updatedAt;
  int? productVariationId;
  int? optionTypeId;
  String? productCode;

  VolumePrices({
    this.id,
    this.productId,
    this.quantity,
    this.discountPrice,
    this.createdAt,
    this.updatedAt,
    this.productVariationId,
    this.optionTypeId,
    this.productCode,
  });

  VolumePrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    discountPrice = json['discount_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productVariationId = json['product_variation_id'];
    optionTypeId = json['option_type_id'];
    productCode = json['product_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['discount_price'] = this.discountPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_variation_id'] = this.productVariationId;
    data['option_type_id'] = this.optionTypeId;
    data['product_code'] = this.productCode;
    return data;
  }
}

class Variations {
  int? id;
  String? name;
  String? type;
  int? price;
  int? stock;
  List<Options>? options;
  String? productCode;

  Variations({
    this.id,
    this.name,
    this.type,
    this.price,
    this.stock,
    this.options,
    this.productCode,
  });

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    stock = json['stock'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['stock'] = this.stock;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? name;
  int? quantity;
  int? price;
  String? productCode;

  Options({this.id, this.name, this.quantity, this.price, this.productCode});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    productCode = json['product_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['product_code'] = this.productCode;
    return data;
  }
}

class OrderVariation {
  int? id;
  String? name;

  OrderVariation({this.id, this.name});

  OrderVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

import 'order_history_model.dart';

class OrderDetailModel {
  bool? success;
  String? message;
  OrderDetailData? data;

  OrderDetailModel({this.success, this.message, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null
            ? new OrderDetailData.fromJson(json['data'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderDetailData {
  int? id;
  int? customerId;
  String? paymentMethod;
  String? paymentId;
  String? paymentPhoto;
  String? name;
  String? phone;
  String? region;
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
  String? payment;

  OrderDetailData({
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

  OrderDetailData.fromJson(Map<String, dynamic> json) {
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
    payment = json['payment'];
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
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    data['payment'] = this.payment;
    return data;
  }
}

/*

class OrderItem {
  int? id;
  String? orderId;
  String? productId;
  String? price;
  String? quantity;
  String? totalPrice;
  String? createdAt;
  String? color;
  String? size;
  ProductData? product;

  OrderItem(
      {this.id,
        this.orderId,
        this.productId,
        this.price,
        this.quantity,
        this.totalPrice,
        this.createdAt,
        this.color,
        this.size,
        this.product});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    price = json['price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    color = json['color'];
    size = json['size'];
    product =
    json['product'] != null ? new ProductData.fromJson(json['product']) : null;
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
    data['color'] = this.color;
    data['size'] = this.size;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
*/

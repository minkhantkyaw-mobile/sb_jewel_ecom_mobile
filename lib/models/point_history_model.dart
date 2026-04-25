import 'package:spjewellery/models/payment_model.dart';

import 'order_history_model.dart';

class PointHistoryModel {
  bool? success;
  int? total;
  bool? canLoadMore;
  List<PointHistoryData>? data;

  PointHistoryModel({this.success, this.total, this.canLoadMore, this.data});

  PointHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    canLoadMore = json['can_load_more'];
    if (json['data'] != null) {
      data = <PointHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new PointHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    data['can_load_more'] = this.canLoadMore;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PointHistoryData {
  int? id;
  int? customerId;
  int? orderId;
  int? points;
  String? type;
  String? note;
  String? createdAt;
  String? updatedAt;
  Order? order;

  PointHistoryData({
    this.id,
    this.customerId,
    this.orderId,
    this.points,
    this.type,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  PointHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    points = json['points'];
    type = json['type'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['points'] = this.points;
    data['type'] = this.type;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  int? customerId;
  String? paymentMethod;
  dynamic? paymentId;
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
  String? remark;
  String? status;
  String? createdAt;
  List<OrderItem>? orderItem;
  PaymentData? payment;

  Order({
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
    this.remark,
    this.status,
    this.createdAt,
    this.orderItem,
    this.payment,
  });

  Order.fromJson(Map<String, dynamic> json) {
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
    remark = json['remark'];
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
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class Sizes {
  int? id;
  String? name;

  Sizes({this.id, this.name});

  Sizes.fromJson(Map<String, dynamic> json) {
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

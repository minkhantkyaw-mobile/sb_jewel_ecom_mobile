class PaymentModel {
  bool? success;
  String? message;
  List<PaymentData>? data;

  PaymentModel({this.success, this.message, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentData.fromJson(v));
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

class PaymentData {
  int? id;
  String? paymentLogo;
  String? paymentType;
  String? name;
  String? number;
  String? createdAt;

  PaymentData({
    this.id,
    this.paymentLogo,
    this.paymentType,
    this.name,
    this.number,
    this.createdAt,
  });

  PaymentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentLogo = json['payment_logo'];
    paymentType = json['payment_type'];
    name = json['name'];
    number = json['number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_logo'] = this.paymentLogo;
    data['payment_type'] = this.paymentType;
    data['name'] = this.name;
    data['number'] = this.number;
    data['created_at'] = this.createdAt;
    return data;
  }
}

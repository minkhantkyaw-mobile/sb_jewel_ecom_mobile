class DeliveryFeeModel {
  bool? success;
  String? message;
  List<DeliveryFeeData>? data;

  DeliveryFeeModel({this.success, this.message, this.data});

  DeliveryFeeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DeliveryFeeData>[];
      json['data'].forEach((v) {
        data!.add(new DeliveryFeeData.fromJson(v));
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

class DeliveryFeeData {
  int? id;
  int? regionId;
  String? city;
  String? fee;
  dynamic? deletedAt;
  String? createdAt;
  String? updatedAt;
  Region? region;

  DeliveryFeeData(
      {this.id,
        this.regionId,
        this.city,
        this.fee,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.region});

  DeliveryFeeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    city = json['city'];
    fee = json['fee'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region_id'] = this.regionId;
    data['city'] = this.city;
    data['fee'] = this.fee;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    return data;
  }
}

class Region {
  int? id;
  String? name;
  String? cod;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Region(
      {this.id,
        this.name,
        this.cod,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
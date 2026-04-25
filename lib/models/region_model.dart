class RegionModel {
  bool? success;
  String? message;
  List<RegionData>? data;

  RegionModel({this.success, this.message, this.data});

  RegionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RegionData>[];
      json['data'].forEach((v) {
        data!.add(new RegionData.fromJson(v));
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

class RegionData {
  int? id;
  String? name;
  String? cod;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  RegionData({
    this.id,
    this.name,
    this.cod,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  RegionData.fromJson(Map<String, dynamic> json) {
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

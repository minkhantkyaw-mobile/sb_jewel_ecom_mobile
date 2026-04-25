class NotiModel {
  bool? success;
  String? message;
  List<NotiData>? data;

  NotiModel({this.success, this.message, this.data});

  NotiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotiData>[];
      json['data'].forEach((v) {
        data!.add(new NotiData.fromJson(v));
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

class NotiData {
  String? id;
  int? userId;
  String? data;
  dynamic? readAt;
  String? createdAt;
  String? updatedAt;

  NotiData({
    this.id,
    this.userId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  NotiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    data = json['data'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['data'] = this.data;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

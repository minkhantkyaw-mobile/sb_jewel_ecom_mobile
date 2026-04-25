class NotiReadModel {
  bool? success;
  String? message;
  NotiReadData? data;

  NotiReadModel({this.success, this.message, this.data});

  NotiReadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new NotiReadData.fromJson(json['data']) : null;
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

class NotiReadData {
  String? id;
  int? userId;
  String? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotiReadData({
    this.id,
    this.userId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  NotiReadData.fromJson(Map<String, dynamic> json) {
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

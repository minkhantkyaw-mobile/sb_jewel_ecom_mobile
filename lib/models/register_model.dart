class RegisterModel {
  bool? success;
  String? token;
  RegisterData? data;

  RegisterModel({this.success, this.token, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    data = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RegisterData {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? fcmTokenKey;
  dynamic? isBanned;
  String? createdAt;

  RegisterData(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.fcmTokenKey,
        this.isBanned,
        this.createdAt});

  RegisterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    fcmTokenKey = json['fcm_token_key'];
    isBanned = json['is_banned'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['fcm_token_key'] = this.fcmTokenKey;
    data['is_banned'] = this.isBanned;
    data['created_at'] = this.createdAt;
    return data;
  }
}
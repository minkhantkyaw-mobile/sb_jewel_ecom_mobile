class LoginModel {
  bool? success;
  String? token;
  UserData? data;

  LoginModel({this.success, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  int? id;
  String? name;
  String? image;
  String? phone;
  String? email;
  String? fcmTokenKey;
  dynamic? isBanned;
  dynamic? currentPointAmount;
  dynamic? memberLevel;
  String? createdAt;

  UserData({
    this.id,
    this.name,
    this.image,
    this.phone,
    this.email,
    this.fcmTokenKey,
    this.isBanned,
    this.currentPointAmount,
    this.memberLevel,
    this.createdAt,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    fcmTokenKey = json['fcm_token_key'];
    isBanned = json['is_banned'];
    currentPointAmount = json['current_point_amount'];
    memberLevel = json['member_level'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['fcm_token_key'] = this.fcmTokenKey;
    data['is_banned'] = this.isBanned;
    data['current_point_amount'] = this.currentPointAmount;
    data['member_level'] = this.memberLevel;
    data['created_at'] = this.createdAt;
    return data;
  }
}

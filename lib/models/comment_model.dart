class CommentModel {
  bool? success;
  String? message;
  CommentData? data;

  CommentModel({this.success, this.message, this.data});

  CommentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CommentData.fromJson(json['data']) : null;
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

class CommentData {
  String? userId;
  String? postId;
  String? parentId;
  String? body;
  String? updatedAt;
  String? createdAt;
  int? id;

  CommentData(
      {this.userId,
        this.postId,
        this.parentId,
        this.body,
        this.updatedAt,
        this.createdAt,
        this.id});

  CommentData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    postId = json['post_id'];
    parentId = json['parent_id'];
    body = json['body'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['parent_id'] = this.parentId;
    data['body'] = this.body;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
import 'comment_model.dart';
class PostModel {
  bool? success;
  int? total;
  bool? canLoadMore;
  List<PostData>? data;

  PostModel({this.success, this.total, this.canLoadMore, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    canLoadMore = json['can_load_more'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(new PostData.fromJson(v));
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

class PostData {
  int? id;
  int? userId;
  String? poster;
  String? description;
  List<Images>? images;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;

  PostData(
      {this.id,
        this.userId,
        this.poster,
        this.description,
        this.images,
        this.comments,
        this.createdAt,
        this.updatedAt});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    poster = json['poster'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['poster'] = this.poster;
    data['description'] = this.description;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Images {
  int? id;
  int? postId;
  String? path;
  String? description;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.postId,
        this.path,
        this.description,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    path = json['path'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['path'] = this.path;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  String? poster;
  String? image;
  int? postId;
  dynamic? parentId;
  String? body;
  String? createdAt;
  String? updatedAt;
  List<Replies>? replies;
  bool? replyShow=false;


  Comments(
      {this.id,
        this.userId,
        this.poster,
        this.image,
        this.postId,
        this.parentId,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.replies,
      this.replyShow});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    poster = json['poster'];
    image = json['image'];
    postId = json['post_id'];
    parentId = json['parent_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['poster'] = this.poster;
    data['image'] = this.image;
    data['post_id'] = this.postId;
    data['parent_id'] = this.parentId;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? id;
  int? userId;
  String? poster;
  String? image;
  int? postId;
  int? parentId;
  String? body;
  String? createdAt;
  String? updatedAt;
  List<Replies>? replies;

  Replies(
      {this.id,
        this.userId,
        this.poster,
        this.image,
        this.postId,
        this.parentId,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.replies});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    poster = json['poster'];
    image = json['image'];
    postId = json['post_id'];
    parentId = json['parent_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['poster'] = this.poster;
    data['image'] = this.image;
    data['post_id'] = this.postId;
    data['parent_id'] = this.parentId;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
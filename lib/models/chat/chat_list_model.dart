class ChatListModel {
  int? total;
  int? lastPage;
  String? lastMessageId;
  List<Messages>? messages;

  ChatListModel({this.total, this.lastPage, this.lastMessageId, this.messages});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lastPage = json['last_page'];
    lastMessageId = json['last_message_id'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['last_page'] = lastPage;
    data['last_message_id'] = lastMessageId;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? id;
  int? fromId;
  int? toId;
  String? body;
  String? sendBy;
  String? attachment;
  int? seen;
  String? createdAt;
  String? updatedAt;
  String? attachmentType;

  Messages(
      {this.id,
        this.fromId,
        this.toId,
        this.body,
        this.sendBy,
        this.attachment,
        this.seen,
        this.createdAt,
        this.updatedAt,
        this.attachmentType});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    body = json['body'];
    sendBy = json['sent_by'];
    attachment = json['attachment'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attachmentType = json['attachment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['body'] = body;
    data['attachment'] = attachment;
    data['seen'] = seen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['attachment_type'] = attachmentType;
    return data;
  }
}





class UnSeenMsgModel {
  int? unseenCount;
  String? userId;

  UnSeenMsgModel({this.unseenCount, this.userId});

  UnSeenMsgModel.fromJson(Map<String, dynamic> json) {
    unseenCount = json['unseen_count'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unseen_count'] = this.unseenCount;
    data['user_id'] = this.userId;
    return data;
  }
}
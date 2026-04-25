class ChatSendModel {
  String? status;
  Error? error;
  SendMessage? message;
  String? tempID;

  ChatSendModel({this.status, this.error, this.message, this.tempID});

  ChatSendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    message =
    json['message'] != null ? SendMessage.fromJson(json['message']) : null;
    tempID = json['tempID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    if (message != null) {
      data['message'] = message!.toJson();
    }
    data['tempID'] = tempID;
    return data;
  }
}

class Error {
  int? status;
  Null message;

  Error({this.status, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class SendMessage {
  String? id;
  int? fromId;
  String? toId;
  String? message;
  Attachment? attachment;
  String? timeAgo;
  String? createdAt;
  bool? isSender;
  Null seen;

  SendMessage(
      {this.id,
        this.fromId,
        this.toId,
        this.message,
        this.attachment,
        this.timeAgo,
        this.createdAt,
        this.isSender,
        this.seen});

  SendMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    message = json['message'];
    attachment = json['attachment'] != null
        ? Attachment.fromJson(json['attachment'])
        : null;
    timeAgo = json['timeAgo'];
    createdAt = json['created_at'];
    isSender = json['isSender'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['message'] = message;
    if (attachment != null) {
      data['attachment'] = attachment!.toJson();
    }
    data['timeAgo'] = timeAgo;
    data['created_at'] = createdAt;
    data['isSender'] = isSender;
    data['seen'] = seen;
    return data;
  }
}

class Attachment {
  String? file;
  String? title;
  String? type;

  Attachment({this.file, this.title, this.type});

  Attachment.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}
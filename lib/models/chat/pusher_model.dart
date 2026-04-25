class PusherModel {
  bool? status;
  Data? data;

  PusherModel({this.status, this.data});

  PusherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'PusherModel{status: $status, data: $data}';
  }
}

class Data {
  int? id;
  String? channelName;
  String? appId;
  String? key;
  String? secret;
  String? cluster;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.channelName,
    this.appId,
    this.key,
    this.secret,
    this.cluster,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelName = json['channel_name'];
    appId = json['app_id'];
    key = json['key'];
    secret = json['secret'];
    cluster = json['cluster'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channel_name'] = channelName;
    data['app_id'] = appId;
    data['key'] = key;
    data['secret'] = secret;
    data['cluster'] = cluster;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Data{id: $id, channelName: $channelName, appId: $appId, key: $key, secret: $secret, cluster: $cluster, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

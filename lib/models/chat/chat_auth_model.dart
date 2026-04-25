class ChatAuthModel {
  String? auth;
  String? channelData;

  ChatAuthModel({this.auth, this.channelData});

  ChatAuthModel.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    channelData = json['channel_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    data['channel_data'] = channelData;
    return data;
  }
}
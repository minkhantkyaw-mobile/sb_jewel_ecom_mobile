import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_share_data.dart';
import '../models/login_model.dart';

class PrefService {
  final SharedPreferences sharedPreferences;
  PrefService({required this.sharedPreferences});

  Future<void> saveAppToken({required String token}) async {
    sharedPreferences.setString(AppShareData.appToken, token);
  }

  Future<void> savePermission({required List<String>? permissions}) async {
    sharedPreferences.setStringList(AppShareData.accPermission, permissions!);
  }

  Future<String> getAppToken() async {
    return sharedPreferences.getString(AppShareData.appToken) ?? "";
  }

  Future<void> saveAppUser({required UserData user}) async {
    String data = jsonEncode(user);
    sharedPreferences.setString(AppShareData.appUser, data);
  }

  Future<dynamic> getUserData() async {
    dynamic data = sharedPreferences.getString(AppShareData.appUser) ?? "";
    return data;
  }

  Future<String> getAppUser() async {
    return sharedPreferences.getString(AppShareData.appUser) ?? "";
  }

  Future<void> saveAppLanguage({required int val}) async {
    sharedPreferences.setInt(AppShareData.appLanguage, val ?? 0);
  }

  Future<int> getAppLanguage() async {
    return sharedPreferences.getInt(AppShareData.appLanguage) ?? 0;
  }

  Future<String> getFcmToken() async {
    return sharedPreferences.getString(AppShareData.fcmToken) ?? "";
  }

  Future<List> getAccPermission() async {
    return sharedPreferences.getStringList(AppShareData.accPermission) ?? [];
  }


  Future<void> saveLastMessageId({required String id}) async {
    await sharedPreferences.setString('last_message_id', id);
  }

  String? getLastMessageId() {
    return sharedPreferences.getString('last_message_id');
  }

  //************************************************* */

  Future<void> saveMessages(List<String> list) async {
    await sharedPreferences.setStringList('offline_message', list);
  }

  List<String> getMessages() {
    return sharedPreferences.getStringList('offline_message') ?? [];
  }

  Future<void> savePosts(List<String> list) async {
    await sharedPreferences.setStringList('offline_post', list);
  }

  List<String> getPosts() {
    return sharedPreferences.getStringList('offline_post') ?? [];
  }

  Future<void> saveBanner(List<String> list) async {
    await sharedPreferences.setStringList('offline_banner', list);
  }

  List<String> getBanner() {
    return sharedPreferences.getStringList('offline_banner') ?? [];
  }

  Future<void> saveCategory(List<String> list) async {
    await sharedPreferences.setStringList('offline_category', list);
  }

  List<String> getCategory() {
    return sharedPreferences.getStringList('offline_category') ?? [];
  }

  Future<void> saveBrand(List<String> list) async {
    await sharedPreferences.setStringList('offline_brand', list);
  }

  List<String> getBrand() {
    return sharedPreferences.getStringList('offline_brand') ?? [];
  }
}

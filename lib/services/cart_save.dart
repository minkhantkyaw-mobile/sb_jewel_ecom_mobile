import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

Future<List<CartModel>> getDataList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonStringList = prefs.getStringList('cart_list');

  if (jsonStringList != null) {
    return jsonStringList
        .map((jsonString) => CartModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  return [];
}

Future<void> saveDataList(List<CartModel> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> jsonStringList =
      data.map((person) => jsonEncode(person.toJson())).toList();
  await prefs.setStringList('cart_list', jsonStringList).then((value) {
    // BotToast.showText(text: "Success Add To Cart");
  });
}

Future<void> removeDataAll() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('cart_list').then((value) {
    BotToast.showText(text: "Cleared");
  });
}

/*
Future<void> init() async {
    await getDataList().then((value) {
      controller.calList.assignAll(value);
    });
  }

Future<List<CalModel>> getDataList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonStringList = prefs.getStringList('cal_list');
  if (jsonStringList != null) {
    print("DataList>>>$jsonStringList");
    return jsonStringList
        .map((jsonString) => CalModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  return [];
}*/

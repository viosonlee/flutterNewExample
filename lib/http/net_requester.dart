import 'dart:convert';

import 'package:big5/big5.dart' as Big5Tool;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:simple_news/models/new_list.dart';

class NetRequester {
  static const String TAG = "NetRequester=>";
  static const String baseUrl = "http://fund.megabank.com.tw";

  static Dio _getDio() {
    return new Dio(
        new BaseOptions(baseUrl: baseUrl, responseType: ResponseType.bytes));
  }

  static Future<NewList> getListData(int type, String date) async {
    Map<String, dynamic> params = Map();
    params["a"] = type;
    params["b"] = date;
    debugPrint(TAG + params.toString());
    var response = await _getDio()
        .get("/ETFData/djjson/ETNEWSjson.djjson", queryParameters: params);
    List<int> bytes = response.data;
    var big5 = Big5Tool.big5.decode(bytes);
    debugPrint(TAG + "big5:" + big5);
    return NewList.fromJson(jsonDecode(big5));
  }

  static Future<NewList> getListDataNow(int type) async {
    var now = DateTime.now().toLocal();
    String date = DateFormat("yyyy/MM/dd").format(now);
    return getListData(type, date);
  }
}

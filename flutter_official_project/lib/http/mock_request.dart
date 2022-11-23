import 'dart:async';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

// 模拟数据
class MockRequest {
  Future<dynamic> get(String action, {Map? params}) async {
    return mock(action: getJsonName(action), params: params);
  }

  Future<dynamic> post({required String action, Map? params}) async {
    return mock(action: action, params: params);
  }

  Future<dynamic> mock({required String action, Map? params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  Future<dynamic> mock2(String action) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  Map<String, String> map = {
    API.IN_THEATERS: 'in_theaters',
    API.COMING_SOON: 'coming_soon',
    API.TOP_250: 'top250',
    API.WEEKLY: 'weekly',
    API.REIVIEWS: 'reviews',
    API.CELEBRITY: 'celebrity',
    API.WORKS: 'works'
  };

  getJsonName(String action) {
    return map[action];
  }
}

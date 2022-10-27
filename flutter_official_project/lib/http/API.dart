// ignore_for_file: constant_identifier_names, unused_element, prefer_final_fields, unused_field, file_names
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/http/mock_request.dart';
import 'package:flutter_official_project/http/http_request.dart';
import 'package:palette_generator/palette_generator.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const String BASE_URL = 'https://api.douban.com';

  ///TOP250
  static const String TOP_250 = '/v2/movie/top250';

  ///正在热映
  static const String IN_THEATERS =
      '/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///即将上映
  static const String COMING_SOON =
      '/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///一周口碑榜
  static const String WEEKLY =
      '/v2/movie/weekly?apikey=0b2bdeda43b5688921839c8ecb20399b';

  ///影人条目信息
  static const String CELEBRITY = '/v2/movie/celebrity/';
  static const String REIVIEWS = '/v2/movie/subject/26266893/reviews';

  var _request = HttpRequest(API.BASE_URL);
  var _mockRequest = MockRequest();

  Future<dynamic> _query(String uri, String value) async {
    final result = await _request
        .get('$uri$value?apikey=0b2bdeda43b5688921839c8ecb20399b');
    return result;
  }

  void getTodayPlay(RequestCallBack requestCallBack) async {
    int start = math.Random().nextInt(220);
    final Map result = await _request.get('$TOP_250?start=$start&count=4');

    // var resultList = result['subjects'];
    // List<Subject> list =
    //     resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    // List<String> todayUrls = [];
    // todayUrls.add(list[0].images.medium);
    // todayUrls.add(list[1].images.medium);
    // todayUrls.add(list[2].images.medium);

    // var paletteGenerator = await PaletteGenerator.fromImageProvider(
    //     NetworkImage(list[0].images.small));
    // var todayPlayBg = const Color(0x44000000);
    // if (paletteGenerator.colors.isNotEmpty) {
    //   todayPlayBg = (paletteGenerator.colors.toList()[0]);
    // }
    // requestCallBack({'list': todayUrls, 'todayPlayBg': todayPlayBg});

    requestCallBack({'result': result});
  }

  void top250(RequestCallBack requestCallBack, {count = 250}) async {
    final Map result = await _request.get(
        '$TOP_250?start=0&count=$count&apikey=0b2bdeda43b5688921839c8ecb20399b');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///影院热映 + 即将上映
  void getHotComingSoon(RequestCallBack requestCallBack) async {
    //影院热映
    Map result = await _request.get(IN_THEATERS);
    var resultList = result['subjects'];
    List<Subject> hots =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();

    //即将上映
    result = await _request
        .get('$COMING_SOON?apikey=0b2bdeda43b5688921839c8ecb20399b');
    resultList = result['subjects'];
    List<Subject> comingSoons =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack({'hots': hots, 'comingSoons': comingSoons});
  }

  ///影院热映 https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b
  void getIntheaters(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(IN_THEATERS);
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///https://api.douban.com/v2/movie/coming_soon?apikey=0b2bdeda43b5688921839c8ecb20399b
  ///即将上映
  void commingSoon(RequestCallBack requestCallBack) async {
    final Map result = await _request
        .get('$COMING_SOON?apikey=0b2bdeda43b5688921839c8ecb20399b');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  ///豆瓣热门
  void getHot(RequestCallBack requestCallBack) async {
    ///随机生成热门
    int start = math.Random().nextInt(220);
    final Map result = await _request.get('$TOP_250?start=$start&count=7');
    var resultList = result['subjects'];
    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    requestCallBack(list);
  }

  void getWeekly(RequestCallBack requestCallBack) async {
    final Map result = await _request.get(WEEKLY);
    var resultList = result['subjects'];
    List<SubjectEntity> list = resultList
        .map<SubjectEntity>((item) => SubjectEntity.fromMap(item))
        .toList();
    requestCallBack(list);
  }
}

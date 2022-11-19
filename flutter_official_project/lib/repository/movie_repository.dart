// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/bean/top_item_bean.dart';
import 'package:flutter_official_project/constant/cache_key.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/http/http_request.dart';
import 'package:flutter_official_project/http/mock_request.dart';
import 'dart:math' as math;
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieRepository {
  var _request;
  List<Subject>? hotShowBeans; // 影院热映
  List<Subject>? comingSoonBeans; // 即将上映
  List<Subject>? hotBeans; // 豆瓣榜单
  List<SubjectEntity>? weeklyBeans; // 一周口碑电影榜
  List<Subject>? top250Beans; // Top250
  List<String>? todayUrls;
  TopItemBean? weeklyTopBean, weeklyHotBean, weeklyTop250Bean;
  Color? weeklyTopColor, weeklyHotColor, weeklyTop250Color, todayPlayBg;

  MovieRepository({List<Subject>? hotShowBeans, List<Subject>? comingSoonBeans, List<Subject>? hotBeans, List<SubjectEntity>? weeklyBeans, List<Subject>? top250Beans, List<String>? todayUrls, TopItemBean? weeklyTopBean, TopItemBean? weeklyHotBean, TopItemBean? weeklyTop250Bean, Color? weeklyTopColor, Color? weeklyHotColor, Color? weeklyTop250Color, Color? todayPlayBg});

  Future<MovieRepository> requestAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool useNetData = prefs.getBool(CacheKey.USE_NET_DATA) ?? false;
    if (useNetData) {
      _request = HttpRequest(API.BASE_URL);
    } else {
      _request = MockRequest();
    }

    // 影院热映
    var result = await _request.get(API.IN_THEATERS);
    var resultList = result['subjects'];
    hotShowBeans = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();

    // 即将上映
    result = await _request.get(API.COMING_SOON);
    resultList = result['subjects'];
    comingSoonBeans = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    int start = math.Random().nextInt(220);

    // 这里使用了下面的模拟请求
    if (useNetData) {
      result = await _request.get('${API.TOP_250}?start=$start&count=7&apikey=0b2bdeda43b5688921839c8ecb20399b');
    } else {
      result = await _request.get(API.TOP_250);
    }

    resultList = result['subjects'];

    // 豆瓣榜单
    hotBeans = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();

    // 一周热门电影榜
    weeklyHotBean = TopItemBean.convertHotBeans(hotBeans!);
    var paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(hotBeans![0].images?.medium));
    if (paletteGenerator.colors.isNotEmpty) {
      weeklyHotColor = (paletteGenerator.colors.toList()[0]);
    }

    // 一周口碑电影榜
    result = await _request.get(API.WEEKLY);
    resultList = result['subjects'];
    weeklyBeans = resultList.map<SubjectEntity>((item) => SubjectEntity.fromMap(item)).toList();
    weeklyTopBean = TopItemBean.convertWeeklyBeans(weeklyBeans!);
    paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(weeklyBeans![0].subject!.images!.medium));
    if (paletteGenerator.colors.isNotEmpty) {
      weeklyTopColor = (paletteGenerator.colors.toList()[0]);
    }

    // 今日可播放电影
    start = math.Random().nextInt(220);

    // 这里使用了下面的模拟请求
    if (useNetData) {
      result = await _request.get('${API.TOP_250}?start=$start&count=7&apikey=0b2bdeda43b5688921839c8ecb20399b');
    } else {
      result = await _request.get(API.TOP_250);
    }

    resultList = result['subjects'];
    List<Subject> beans = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    todayUrls = [];
    todayUrls!.add(beans[0].images?.medium);
    todayUrls!.add(beans[1].images?.medium);
    todayUrls!.add(beans[2].images?.medium);
    paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(todayUrls![0]));
    if (paletteGenerator.colors.isNotEmpty) {
      todayPlayBg = (paletteGenerator.colors.toList()[0]);
    }

    // 豆瓣 TOP250
    // 这里使用了下面的模拟请求
    // result = await _request.get(API.TOP_250 + '?start=0&count=5&apikey=0b2bdeda43b5688921839c8ecb20399b');

    if (useNetData) {
      result = await _request.get('${API.TOP_250}?start=0&count=5&apikey=0b2bdeda43b5688921839c8ecb20399b');
    } else {
      result = await _request.get(API.TOP_250);
    }

    resultList = result['subjects'];
    top250Beans = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    weeklyTop250Bean = TopItemBean.convertTopBeans(top250Beans!);
    paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(top250Beans![0].images?.medium));

    if (paletteGenerator.colors.isNotEmpty) {
      weeklyTop250Color = (paletteGenerator.colors.toList()[0]);
    }

    return MovieRepository(hotShowBeans: hotShowBeans, comingSoonBeans: comingSoonBeans, hotBeans: hotBeans, weeklyBeans: weeklyBeans, top250Beans: top250Beans, todayUrls: todayUrls, weeklyTopBean: weeklyTopBean, weeklyHotBean: weeklyHotBean, weeklyTop250Bean: weeklyTop250Bean, weeklyTopColor: weeklyTopColor, weeklyHotColor: weeklyHotColor, weeklyTop250Color: weeklyTop250Color, todayPlayBg: todayPlayBg);
  }
}

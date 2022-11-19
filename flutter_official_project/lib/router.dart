import 'package:flutter/material.dart';
import 'package:flutter_official_project/pages/container_page.dart';
import 'package:flutter_official_project/pages/detail/detail_page.dart';
import 'package:flutter_official_project/pages/person_detail_page.dart';
import 'package:flutter_official_project/pages/photo_hero_page.dart';
import 'package:flutter_official_project/pages/search/search_page.dart';
import 'package:flutter_official_project/pages/web_view_page.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:doubanapp/pages/detail/detail_page.dart';
// import 'package:doubanapp/pages/container_page.dart';
// import 'package:doubanapp/pages/videos_play_page.dart';
// import 'package:doubanapp/pages/search/search_page.dart';
// import 'package:doubanapp/pages/photo_hero_page.dart';
// import 'package:doubanapp/pages/person_detail_page.dart';
// import 'package:doubanapp/pages/web_view_page.dart';

///https://www.jianshu.com/p/b9d6ec92926f

class MyRouter {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';
  static const playListPage = 'app://VideosPlayPage';
  static const searchPage = 'app://SearchPage';
  static const photoHero = 'app://PhotoHero';
  static const personDetailPage = 'app://PersonDetailPage';

//  Widget _router(String url, dynamic params) {
//    String pageId = _pageIdMap[url];
//    return _getPage(pageId, params);
//  }
//
//  Map<String, dynamic> _pageIdMap = <String, dynamic>{
//    'app/': 'ContainerPageWidget',
//    detailPage: 'DetailPage',
//  };

  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return WebViewPage(url, params);
    } else {
      switch (url) {
        case detailPage:
          return DetailPage(params);
        case homePage:
          return const ContainerPage();
        case playListPage:
          // return VideoPlayPage(params);
          return const Text('Placeholder Widget');
        case searchPage:
          return SearchPage(searchHintContent: params);
        case photoHero:
          return PhotoHeroPage(photoUrl: params['photoUrl'], width: params['width']);
        case personDetailPage:
          return PersonDetailPage(id: params['id'], personImgUrl: params['personImgUrl']);
      }
    }
    // return null;
    return const Text('Placeholder Widget');
  }

//
//  void push(BuildContext context, String url, dynamic params) {
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return _getPage(url, params);
//    }));
//  }

  MyRouter.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  MyRouter.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}

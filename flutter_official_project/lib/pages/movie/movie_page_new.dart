// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/constant/color_constant.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/pages/douya_top_250_list_widget.dart';
import 'package:flutter_official_project/pages/movie/hot_soon_tab_bar.dart';
import 'package:flutter_official_project/pages/movie/title_widget.dart';
import 'package:flutter_official_project/widgets/image/LaminatedImage.dart';
import 'package:flutter_official_project/widgets/subject_mark_image_widget.dart';

// import 'package:doubanapp/pages/movie/title_widget.dart';
// import 'package:doubanapp/pages/movie/today_play_movie_widget.dart';
// import 'package:doubanapp/http/API.dart';
// import 'package:doubanapp/pages/movie/hot_soon_tab_bar.dart';
// import 'package:doubanapp/widgets/item_count_title.dart';
// import 'package:doubanapp/widgets/subject_mark_image_widget.dart';
// import 'package:doubanapp/bean/subject_entity.dart';
// import 'package:doubanapp/bean/top_item_bean.dart';
// import 'package:doubanapp/widgets/rating_bar.dart';
// import 'package:doubanapp/constant/color_constant.dart';
// import 'dart:math' as math;
// import 'package:doubanapp/widgets/image/cache_img_radius.dart';
// import 'package:doubanapp/constant/constant.dart';
// import 'package:doubanapp/pages/movie/top_item_widget.dart';
// import 'package:doubanapp/router.dart';
// import 'package:doubanapp/http/http_request.dart';
// import 'package:palette_generator/palette_generator.dart';
// import 'package:flutter/rendering.dart';
// import 'package:doubanapp/repository/movie_repository.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:doubanapp/widgets/loading_widget.dart';
// import 'package:doubanapp/widgets/image/LaminatedImage.dart';
// import 'package:flutter/material.dart';
// import 'package:doubanapp/constant/text_size_constant.dart';
// import 'package:doubanapp/constant/color_constant.dart';

final API _api = API();

// 书影音-电影(优化后)
class MoviePage extends StatelessWidget {
  final _HotComingSoonWidget __hotComingSoonWidget = _HotComingSoonWidget();

  MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('MoviePage build');

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          // 头部的找电影、豆瓣榜单、etc
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: TitleWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: _TodayPlayMovieWidget(),
          ),
          SliverToBoxAdapter(
            child: HotSoonTabBar(),
          ),
          // 影院热映、即将上映
          SliverToBoxAdapter(
            child: __hotComingSoonWidget,
          ),
        ],
      ),
    );
  }
}

// 今日可播放电影已更新 Widget
class _TodayPlayMovieWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodayPlayMovieState();
}

class _TodayPlayMovieState extends State<_TodayPlayMovieWidget> {
  var backgroundColor;
  List<String>? urls;

  @override
  void initState() {
    super.initState();
    _api.getTodayPlay((map) {
      debugPrint('_TodayPlayMovieState setState ');

      setState(() {
        urls = map['list'];
        backgroundColor = map['todayPlayBg'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (urls == null || urls!.isEmpty) {
      debugPrint('_TodayPlayMovieState urls == null');

      return Container();
    }

    debugPrint('_TodayPlayMovieState update ');

    return Stack(
      alignment: const AlignmentDirectional(1.0, 1.0),
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(color: backgroundColor ?? const Color.fromARGB(255, 47, 22, 74), shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(4.0))),
            ),
            Container(
              height: 140.0,
              margin: const EdgeInsets.only(left: 13.0, bottom: 14.0),
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      LaminatedImage(urls: urls, w: 90.0),
                      Positioned(
                        left: 90.0 / 3,
                        child: Image.asset(
                          'assets/images/ic_action_playable_video_s.png',
                          width: 30.0,
                          height: 30.0,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            '今日可播放电影已更新',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              '全部 30 > ',
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Image.asset(
                'assets/images/sofa.png',
                width: 15.0,
                height: 15.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 5.0),
              child: Text(
                '看电影',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}

// 影院热映、即将上映
class _HotComingSoonWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HotComingSoonWidgetState();
}

class _HotComingSoonWidgetState extends State<_HotComingSoonWidget> {
  int selectIndex = 0;
  // ignore: deprecated_member_use
  List<Subject> hotShowBeans = []; // 影院热映
  List<Subject> comingSoonBeans = []; // 即将上映

  var itemW;
  var hotChildAspectRatio;
  var comingSoonChildAspectRatio;

  @override
  void initState() {
    super.initState();
    _api.getHotComingSoon((map) {
      debugPrint('_HotComingSoonWidgetState setState');

      setState(() {
        hotShowBeans = map['hots'];
        comingSoonBeans = map['comingSoons'];
      });
    });
  }

  double _getRadio() {
    if (selectIndex == 0) {
      return hotChildAspectRatio;
    } else {
      return comingSoonChildAspectRatio;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_HotComingSoonWidgetState build');

    itemW = (MediaQuery.of(context).size.width - 30.0 - 20.0) / 3;
    hotChildAspectRatio = (377.0 / 674.0);
    comingSoonChildAspectRatio = (377.0 / 742.0);

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 0.0, childAspectRatio: _getRadio()),
        itemBuilder: (BuildContext context, int index) {
          var hotMovieBean;
          var comingSoonBean;
          if (hotShowBeans.isNotEmpty) {
            hotMovieBean = hotShowBeans[index];
          }

          if (comingSoonBeans.isNotEmpty) {
            comingSoonBean = comingSoonBeans[index];
          }

          return Stack(
            children: <Widget>[
              Offstage(
                offstage: !(selectIndex == 1 && comingSoonBeans.isNotEmpty),
                child: _getComingSoonItem(comingSoonBean, itemW),
              ),
              Offstage(offstage: !(selectIndex == 0 && hotShowBeans.isNotEmpty), child: _getHotMovieItem(hotMovieBean, itemW))
            ],
          );
        });
  }

  // 即将上映 item
  Widget _getComingSoonItem(Subject comingSoonBean, var itemW) {
    if (comingSoonBean.casts == null) {
      return Container();
    }

    // 将 2019-02-14 转成 02 月 14 日
    // ignore: non_constant_identifier_names
    String mainland_pubdate = comingSoonBean.mainland_pubdate;
    mainland_pubdate = mainland_pubdate.substring(5, mainland_pubdate.length);
    // ignore: prefer_interpolation_to_compose_strings
    mainland_pubdate = mainland_pubdate.replaceFirst(RegExp(r'-'), '月') + '日';
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SubjectMarkImageWidget(
              comingSoonBean.images?.large,
              width: itemW,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              // ignore: sized_box_for_whitespace
              child: Container(
                width: double.infinity,
                child: Text(
                  comingSoonBean.title,
                  // 文本只显示一行
                  softWrap: false,
                  // 多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(color: ColorConstant.colorRed277), borderRadius: BorderRadius.all(Radius.circular(2.0))),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    mainland_pubdate,
                    style: const TextStyle(fontSize: 8.0, color: ColorConstant.colorRed277),
                  ),
                ))
          ],
        ),
      ),
      onTap: () {
        // 功能待开放
        // MyRouter.push(context, MyRouter.detailPage, comingSoonBean.id);
      },
    );
  }

  // 影院热映 item
  Widget _getHotMovieItem(Subject hotMovieBean, var itemW) {
    // ignore: unnecessary_null_comparison
    if (hotMovieBean == null) {
      return Container();
    }

    return GestureDetector(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: <Widget>[
            SubjectMarkImageWidget(
              imgNetUrl: hotMovieBean.images!.large,
              width: itemW,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              // ignore: sized_box_for_whitespace
              child: Container(
                width: double.infinity,
                child: Text(
                  hotMovieBean.title,
                  // 文本只显示一行
                  softWrap: false,
                  // 多出的文本渐隐方式
                  overflow: TextOverflow.fade,
                  style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RatingBar(
              hotMovieBean.rating?.average,
              size: 12.0,
            )
          ],
        ),
      ),
      onTap: () {
        // 待开放
        // MyRouter.push(context, MyRouter.detailPage, hotMovieBean.id);
      },
    );
  }
}

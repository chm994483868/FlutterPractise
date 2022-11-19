// ignore_for_file: prefer_typing_uninitialized_variables, must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/bean/top_item_bean.dart';
import 'package:flutter_official_project/constant/color_constant.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'dart:math' as math;

import 'package:flutter_official_project/pages/movie/hot_soon_tab_bar.dart';
import 'package:flutter_official_project/pages/movie/title_widget.dart';
import 'package:flutter_official_project/pages/movie/today_play_movie_widget.dart';
import 'package:flutter_official_project/pages/movie/top_item_widget.dart';
import 'package:flutter_official_project/repository/movie_repository.dart';
import 'package:flutter_official_project/widgets/image/cache_img_radius.dart';
import 'package:flutter_official_project/widgets/item_count_title.dart';
import 'package:flutter_official_project/widgets/loading_widget.dart';
import 'package:flutter_official_project/widgets/rating_bar.dart';
import 'package:flutter_official_project/widgets/subject_mark_image_widget.dart';

// 书影音-电影
// 这个 Widget 整个布局较为复杂
// 整个是使用 CustomScrollView 内存放各种 Slivers 构成
class MoviePage extends StatefulWidget {

  const MoviePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MoviePageState();
  }
}

class _MoviePageState extends State<MoviePage>  with AutomaticKeepAliveClientMixin {
  late Widget titleWidget, hotSoonTabBarPadding;
  late HotSoonTabBar hotSoonTabBar;
  List<Subject> hotShowBeans = []; // 影院热映
  List<Subject> comingSoonBeans = []; // 即将上映
  List<Subject> hotBeans = []; // 豆瓣榜单
  List<SubjectEntity> weeklyBeans = []; // 一周口碑电影榜
  List<Subject> top250Beans = []; // Top250
  var hotChildAspectRatio;
  var comingSoonChildAspectRatio;
  int selectIndex = 0; // 选中的是热映、即将上映
  var itemW;
  var imgSize;
  List<String> todayUrls = [];
  TopItemBean? weeklyTopBean, weeklyHotBean, weeklyTop250Bean;
  Color? weeklyTopColor, weeklyHotColor, weeklyTop250Color;
  Color todayPlayBg = const Color.fromARGB(255, 47, 22, 74);

  @override
  void initState() {
    super.initState();
    debugPrint('initState movie_page');

    titleWidget = const Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TitleWidget(),
    );

    hotSoonTabBar = HotSoonTabBar(
      onTabCallBack: (index) {
        setState(() {
          selectIndex = index;
        });
      },
    );

    hotSoonTabBarPadding = Padding(
      padding: const EdgeInsets.only(top: 35.0, bottom: 15.0),
      child: hotSoonTabBar,
    );
    
    requestAPI();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build movie_page');

    if (itemW == null || imgSize <= 0) {
      MediaQuery.of(context);
      var w = MediaQuery.of(context).size.width;
      imgSize = w / 5 * 3;
      itemW = (w - 30.0 - 20.0) / 3;
      hotChildAspectRatio = (377.0 / 674.0);
      comingSoonChildAspectRatio = (377.0 / 742.0);
    }
    
    return Stack(
      children: <Widget>[
        containerBody(),
        Offstage(
          offstage: !loading,
          child: LoadingWidget.getLoading(backgroundColor: Colors.transparent),
        )
      ],
    );
  }

  // 即将上映 item
  Widget _getComingSoonItem(Subject comingSoonBean, var itemW) {
    // ignore: unnecessary_null_comparison
    if (comingSoonBean == null) {
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
              imgNetUrl: comingSoonBean.images?.large,
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
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.colorRed277),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    mainland_pubdate,
                    style: const TextStyle(
                        fontSize: 8.0, color: ColorConstant.colorRed277),
                  ),
                ))
          ],
        ),
      ),
      onTap: () {
        // 暂时未开放
        // MyRouter.push(context, MyRouter.detailPage, comingSoonBean.id);
      },
    );
  }

  // 影院热映 item
  Widget _getHotMovieItem(Subject? hotMovieBean, var itemW) {
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
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RatingBar(
              hotMovieBean.rating!.average,
              size: 12.0,
            )
          ],
        ),
      ),
      onTap: () {
        // 功能待开放
        // MyRouter.push(context, MyRouter.detailPage, hotMovieBean.id);
      },
    );
  }

  int _getChildCount() {
    if (selectIndex == 0) {
      return hotShowBeans.length;
    } else {
      return comingSoonBeans.length;
    }
  }

  double _getRadio() {
    if (selectIndex == 0) {
      return hotChildAspectRatio;
    } else {
      return comingSoonChildAspectRatio;
    }
  }

  // 图片+订阅+名称+星标
  SliverGrid getCommonSliverGrid(List<Subject> hotBeans) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return _getHotMovieItem(hotBeans[index], itemW);
        }, childCount: math.min(hotBeans.length, 6)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: hotChildAspectRatio));
  }

  // R 角图片
  getCommonImg(String url, OnTab? onTab) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: CacheImgRadius(
          imgUrl: url,
          radius: 5.0,
          onTab: () {
            if (onTab != null) {
              onTab();
            }
          },
        ),
      ),
    );
  }

  MovieRepository repository = MovieRepository();
  bool loading = true;

  void requestAPI() async {
    Future(() => (repository.requestAPI())).then((value) {
      hotShowBeans = value.hotShowBeans!;
      comingSoonBeans = value.comingSoonBeans!;
      hotBeans = value.hotBeans!;
      weeklyBeans = value.weeklyBeans!;
      top250Beans = value.top250Beans!;
      todayUrls = value.todayUrls!;
      weeklyTopBean = value.weeklyTopBean;
      weeklyHotBean = value.weeklyHotBean;
      weeklyTop250Bean = value.weeklyTop250Bean;
      weeklyTopColor = value.weeklyTopColor;
      weeklyHotColor = value.weeklyHotColor;
      weeklyTop250Color = value.weeklyTop250Color;
      todayPlayBg = value.todayPlayBg!;
      hotSoonTabBar.setCount(hotShowBeans);
      hotSoonTabBar.setComingSoon(comingSoonBeans);

//      hotTitle.setCount(hotBeans.length);
//      topTitle.setCount(weeklyBeans.length);

      setState(() {
        loading = false;
      });
    });
  }

  Widget containerBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: titleWidget,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: TodayPlayMovieWidget(todayUrls, backgroundColor: todayPlayBg),
            ),
          ),
          SliverToBoxAdapter(
            child: hotSoonTabBarPadding,
          ),
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
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
                    Offstage(
                        offstage: !(selectIndex == 0 && hotShowBeans.isNotEmpty),
                        child: _getHotMovieItem(hotMovieBean, itemW))
                  ],
                );
              }, childCount: math.min(_getChildCount(), 6)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: _getRadio())),
          getCommonImg(Constant.IMG_TMP1, (){
            // 功能待开放
            // MyRouter.pushNoParams(context, "http://www.flutterall.com");
          }),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: ItemCountTitle(
                title: '豆瓣热门',
                fontSize: 13.0,
                count: hotBeans.length,
              ),
            ),
          ),
          getCommonSliverGrid(hotBeans),
          getCommonImg(Constant.IMG_TMP2, null),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
              child: ItemCountTitle(
                title: '豆瓣榜单',
                count: weeklyBeans.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: imgSize,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TopItemWidget(
                    title: '一周口碑电影榜',
                    bean: weeklyTopBean!,
                    partColor: weeklyTopColor!,
                  ),
                  TopItemWidget(
                    title: '一周热门电影榜',
                    bean: weeklyHotBean!,
                    partColor: weeklyHotColor!,
                  ),
                  TopItemWidget(
                    title: '豆瓣电影 Top250',
                    bean: weeklyTop250Bean!,
                    partColor: weeklyTop250Color!,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

typedef OnTab = void Function();

//var loadingBody = new Container(
//  alignment: AlignmentDirectional.center,
//  decoration: new BoxDecoration(
//    color: Color(0x22000000),
//  ),
//  child: new Container(
//    decoration: new BoxDecoration(
//        color: Colors.white, borderRadius: new BorderRadius.circular(10.0)),
//    width: 70.0,
//    height: 70.0,
//    alignment: AlignmentDirectional.center,
//    child: SizedBox(
//      height: 25.0,
//      width: 25.0,
//      child: CupertinoActivityIndicator(
//        radius: 15.0,
//      ),
//    ),
//  ),
//);

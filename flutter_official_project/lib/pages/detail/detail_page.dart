// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_official_project/bean/comments_entity.dart';
import 'package:flutter_official_project/bean/movie_detail_bean.dart';
import 'package:flutter_official_project/bean/movie_long_comments_entity.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/http/http_request.dart';
import 'package:flutter_official_project/http/mock_request.dart';
import 'package:flutter_official_project/pages/detail/detail_title_widget.dart';
import 'package:flutter_official_project/pages/detail/long_comment_widget.dart';
import 'package:flutter_official_project/pages/detail/score_start.dart';
import 'package:flutter_official_project/router.dart';
import 'package:flutter_official_project/widgets/animal_photo.dart';
import 'package:flutter_official_project/widgets/bottom_drag_widget.dart';
import 'package:flutter_official_project/widgets/rating_bar.dart';
import 'dart:math' as math;
import 'package:palette_generator/palette_generator.dart';

// 影片、电视详情页面
class DetailPage extends StatefulWidget {
  final subjectId;

  const DetailPage(this.subjectId, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(subjectId);
  }
}

class _DetailPageState extends State<DetailPage> {
  final subjectId;
  // Color pickColor = const Color(0xffffffff); // 默认主题色
  Color pickColor = Colors.black;
  CommentsEntity? commentsEntity;
  MovieLongCommentsEntity? movieLongCommentReviews;
  bool loading = true;
  MovieDetailBean? _movieDetailBean;

  _DetailPageState(this.subjectId);

  // ignore: unused_field
  final _request = HttpRequest(API.BASE_URL);

  double get screenH => MediaQuery.of(context).size.height;

  // 记录上一个页面的状态栏颜色
  SystemUiOverlayStyle? _lastStyle;

  @override
  void initState() {
    // 获取上一个页面的状态栏颜色
    // ignore: invalid_use_of_visible_for_testing_member
    _lastStyle = SystemChrome.latestStyle;
    // 设置当前页面状态栏颜色为白色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    super.initState();

    requestAPI();
  }

  @override
  void dispose() {
    // 将状态栏设置为之前的颜色
    if (_lastStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(_lastStyle!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_movieDetailBean == null) {
      return const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: pickColor,
      body: Container(
        child: SafeArea(
            child: BottomDragWidget(
                body: _getBody(),
                dragContainer: DragContainer(
                    drawer: Container(
                      decoration: const BoxDecoration(color: Color.fromARGB(255, 243, 244, 248), borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
                      child: OverscrollNotificationWidget(
                        child: LongCommentWidget(movieLongCommentsEntity: movieLongCommentReviews!),
                      ),
                    ),
                    defaultShowHeight: screenH * 0.1,
                    height: screenH * 0.8))),
      ),
    );
  }

  // 所属频道
  SliverToBoxAdapter sliverTags() {
    return SliverToBoxAdapter(
      child: Container(
        height: 30.0,
        padding: padding(),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _movieDetailBean!.tags!.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      '所属频道',
                      style: TextStyle(color: Colors.white70, fontSize: 13.0),
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: const BoxDecoration(color: Color(0x23000000), borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  child: Text(
                    '${_movieDetailBean?.tags?[index - 1]}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }

  // 剧情简介
  SliverToBoxAdapter sliverSummary() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(color: Color(0x44000000), borderRadius: BorderRadius.all(Radius.circular(10.0))),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: Text(
                '剧情简介',
                style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              _movieDetailBean?.summary ?? "",
              style: const TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // 演职员
  SliverToBoxAdapter sliverCasts() {
    return SliverToBoxAdapter(
      child: getPadding(Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                const Expanded(child: Text('演职员', style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold))),
                Text(
                  '全部 ${_movieDetailBean?.casts?.length} >',
                  style: const TextStyle(fontSize: 12.0, color: Colors.white70),
                )
              ],
            ),
          ),
          Container(
            height: 150.0,
            child: ListView.builder(
              itemBuilder: ((BuildContext context, int index) {
                if (index == 0 && _movieDetailBean != null && _movieDetailBean!.directors != null && _movieDetailBean!.directors!.isNotEmpty) {
                  // 第一个显示导演
                  Director director = _movieDetailBean!.directors![0];
                  if (director.avatars == null) {
                    return Container();
                  }
                  return getCast(director.id!, director.avatars!.large!, director.name!);
                } else {
                  Cast? cast = _movieDetailBean?.casts?[index - 1];
                  if (cast == null || cast.avatars == null) {
                    return Container();
                  }

                  return getCast(cast.id!, cast.avatars!.large!, cast.name!);
                }
              }),
              itemCount: math.min(9, _movieDetailBean!.casts!.length + 1),
              // 最多显示 9 个演员
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      )),
    );
  }

  // 演职表图片
  Widget getCast(String id, String imgUrl, String name) {
    return Hero(
        tag: imgUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, right: 14.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    child: Image.network(
                      imgUrl,
                      height: 120.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 13.0, color: Colors.white),
                ),
              ],
            ),
            onTap: () {
              MyRouter.push(context, MyRouter.personDetailPage, {'personImgUrl': imgUrl, 'id': id});
            },
          ),
        ));
  }

  // 预告片、剧照 727x488
  trailers(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 5 * 3;
    var h = w / 727 * 488;
    _movieDetailBean!.trailers!.addAll(_movieDetailBean!.bloopers!);
    return SliverToBoxAdapter(
      child: getPadding(Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                const Expanded(
                    child: Text(
                  '预告片 / 剧照',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
                )),
                Text(
                  '全部 ${_movieDetailBean!.photos!.length} >',
                  style: const TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 192, 193, 203)),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            height: h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0 && _movieDetailBean!.trailers!.isNotEmpty) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: _getTrailers(w, h),
                          ),
                          Container(
                            width: w,
                            height: h,
                            child: const Icon(
                              Icons.play_circle_outline,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 232, 145, 66),
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                            ),
                            child: const Text(
                              '预告片',
                              style: TextStyle(fontSize: 11.0, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      MyRouter.push(context, MyRouter.playListPage, _movieDetailBean?.trailers);
                    },
                  );
                } else {
                  Photo bean = _movieDetailBean!.photos![index - (_movieDetailBean!.trailers!.isNotEmpty ? 1 : 0)];
                  return showBigImg(
                      Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Image.network(
                          bean.cover!,
                          fit: BoxFit.cover,
                          width: w,
                          height: h,
                        ),
                      ),
                      bean.cover!);
                }
              },
              itemCount: _movieDetailBean!.photos!.length + (_movieDetailBean!.trailers!.isNotEmpty ? 1 : 0),
            ),
          )
        ],
      )),
    );
  }

  // 短评，默认显示4个
  sliverComments() {
    if (commentsEntity == null || commentsEntity!.comments!.isEmpty) {
      return const SliverToBoxAdapter();
    } else {
      var backgroundColor = const Color(0x44000000);
      int allCount = math.min(4, commentsEntity!.comments!.length);
      allCount = allCount + 2; // 多出来的2个表示头和脚
      return SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index == 0) {
          // 头布局
          return Container(
            margin: const EdgeInsets.only(top: 30.0, left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT),
            decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    '短评',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                Text(
                  '全部短评 ${commentsEntity!.total!} >',
                  // ignore: use_full_hex_values_for_flutter_colors
                  style: const TextStyle(color: Color(0x88fffffff), fontSize: 12.0),
                )
              ],
            ),
          );
        } else if (index == allCount - 1) {
          ///显示脚布局
          return Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 20.0, left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT),
            decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Text(
                    '查看全部评价',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                // ignore: use_full_hex_values_for_flutter_colors
                Icon(Icons.keyboard_arrow_right, size: 20.0, color: Color(0x88fffffff))
              ],
            ),
          );
        } else {
          CommantsBeanCommants bean = commentsEntity!.comments![index - 1];
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              margin: padding(),
              decoration: const BoxDecoration(
                color: Color(0x44000000),
              ),
              padding: const EdgeInsets.all(12.0),

              // 内容 item
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 5.0),
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(bean.author!.avatar!),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            bean.author!.name!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
                          ),
                          RatingBar(
                            ((bean.rating!.value * 1.0) / (bean.rating!.max * 1.0)) * 10.0,
                            size: 11.0,
                            fontSize: 0.0,
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    bean.content!,
                    softWrap: true,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  Row(
                    // 赞的数量
                    children: <Widget>[
                      Image.asset(
                        '${Constant.ASSETS_IMG}ic_vote_normal_large.png',
                        width: 20.0,
                        height: 20.0,
                      ),
                      Text(
                        '${getUsefulCount(bean.usefulCount!)}',
                        // ignore: use_full_hex_values_for_flutter_colors
                        style: const TextStyle(color: Color(0x88fffffff)),
                      )
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              // 功能待开放
              MyRouter.push(context, bean.author!.alt!, {'title': '个人主页'});
            },
          );
        }
      }, childCount: allCount));
    }
  }

  // 将 34123 转成 3.4k
  getUsefulCount(int usefulCount) {
    double a = usefulCount / 1000;
    if (a < 1.0) {
      return usefulCount;
    } else {
      return '${a.toStringAsFixed(1)}k'; // 保留一位小数
    }
  }

  _getTrailers(double w, double h) {
    if (_movieDetailBean == null || _movieDetailBean!.trailers == null || _movieDetailBean!.trailers!.isEmpty) {
      return Container();
    }
    return CachedNetworkImage(width: w, height: h, fit: BoxFit.cover, imageUrl: _movieDetailBean!.trailers![0].medium!);
  }

  // 传入的图片组件，点击后，会显示大图页面
  Widget showBigImg(Widget widget, String imgUrl) {
    return Hero(
      tag: imgUrl,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: widget,
          onTap: () {
            AnimalPhoto.show(context, imgUrl);
          },
        ),
      ),
    );
  }

  MockRequest _mockRequest = MockRequest();

  void requestAPI() async {
    Future(() {
      return _mockRequest.mock2("subject_26266893");
      // return _request.get('/v2/movie/subject/$subjectId?apikey=0b2bdeda43b5688921839c8ecb20399b');
    }).then((result) {
      _movieDetailBean = MovieDetailBean.fromJson(result);
      return PaletteGenerator.fromImageProvider(NetworkImage(_movieDetailBean!.images!.large!));
    }).then((paletteGenerator) {
      if (paletteGenerator.colors.isNotEmpty) {
        // pickColor = paletteGenerator.colors.toList()[0];
        pickColor = Colors.black;
      }
      // return _request.get(
      // '/v2/movie/subject/$subjectId/comments?apikey=0b2bdeda43b5688921839c8ecb20399b');
      return _mockRequest.mock2("comments");
    }).then((result2) {
      commentsEntity = CommentsEntity.fromJson(result2);
    }).then((_) {
      // return _request.get(
      // '/v2/movie/subject/$subjectId/reviews?apikey=0b2bdeda43b5688921839c8ecb20399b');
      //使用模拟数据
      return _mockRequest.get(API.REIVIEWS);
    }).then((result3) {
      movieLongCommentReviews = MovieLongCommentsEntity.fromJson(result3);
      setState(() {
        loading = false;
      });
    });
  }

  Widget _getBody() {
    var allCount = _movieDetailBean!.rating!.details!.d1 + _movieDetailBean!.rating!.details!.d2 + _movieDetailBean!.rating!.details!.d3 + _movieDetailBean!.rating!.details!.d4 + _movieDetailBean!.rating!.details!.d5;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('电影'),
          centerTitle: true,
          pinned: true,
          backgroundColor: pickColor,
        ),
        SliverToBoxAdapter(
          child: getPadding(DetailTitleWidget(_movieDetailBean!, pickColor)),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
            margin: padding(),
            child: ScoreStartWidget(
              score: _movieDetailBean!.rating!.average,
              p1: _movieDetailBean!.rating!.details!.d1 / allCount,
              p2: _movieDetailBean!.rating!.details!.d2 / allCount,
              p3: _movieDetailBean!.rating!.details!.d3 / allCount,
              p4: _movieDetailBean!.rating!.details!.d4 / allCount,
              p5: _movieDetailBean!.rating!.details!.d5 / allCount,
            ),
          ),
        ),
        sliverTags(),
        sliverSummary(),
        sliverCasts(),
        trailers(context),
        sliverComments(),
      ],
    );
  }

  padding() {
    return const EdgeInsets.only(left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT);
  }

  getPadding(Widget body) {
    return Padding(
      padding: const EdgeInsets.only(left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT),
      child: body,
    );
  }
}

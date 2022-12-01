// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, sort_child_properties_last, prefer_interpolation_to_compose_strings, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_official_project/bean/subject_entity.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/http/mock_request.dart';
import 'package:flutter_official_project/router.dart';
import 'package:flutter_official_project/widgets/image/radius_img.dart';
import 'package:flutter_official_project/widgets/search_text_field_widget.dart';
import 'package:flutter_official_project/widgets/video_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build HomePage');

    // 首页的 Widget，返回一个 DefaultTabController，左右两边分别展示 动态 和 推荐 的内容
    return getWidget();
  }
}

NestedScrollView getWidget() {
  return NestedScrollView(
    // 头视图是一个搜索框视图和左右切换 动态 和 推荐 的视图
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            pinned: true,
            expandedHeight: 44.0,
            primary: true,
            titleSpacing: 0.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.white,
                child: SearchTextFieldWidget(
                  enabled: false,
                  hintText: '请输入你想要了解的影片...',
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  onTap: () {
                    // 暂时未开放
                    // 输入框被点击
                    debugPrint('click...');

                    MyRouter.push(context, MyRouter.searchPage, '影视作品中你难忘的离别');
                  },
                ),
                // 子 Widget 内容居中显示
                alignment: const Alignment(0.0, 0.5),
              ),
            ),
          ),
        ),
      ];
    },
    // 内容视图
    body: const SliverContainer(
      name: '',
    ),
  );
}

class SliverContainer extends StatefulWidget {
  // 这里根据传递的 name 来判断当前是 动态 还是 推荐 Widget
  final String name;

  const SliverContainer({super.key, required this.name});

  @override
  _SliverContainerState createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {
  @override
  void initState() {
    super.initState();
    debugPrint('init state${widget.name}');

    // 请求动态数据
    if (list == null || list!.isEmpty) {
      // 请求推荐数据
      requestAPI();
    }
  }

  List<Subject>? list;

  // 这里使用了假数据
  void requestAPI() async {
    var _request = MockRequest();
    var result = await _request.get(API.TOP_250);
    var resultList = result['subjects'];
    list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(context, list);
  }

  getContentSliver(BuildContext context, List<Subject>? list) {
    debugPrint('getContentSliver');

    // 如果推荐的 list 无数据，则展示暂无数据
    if (list == null || list.isEmpty) {
      return const Text('暂无数据');
    }

    // 返回安全区 Widget
    return SafeArea(
      top: false,
      bottom: false,
      // 子 Widget 是一个自定义的 ScrollView
      child: Builder(
        builder: (BuildContext context) {
          // 自定义滚动 View
          return CustomScrollView(
            // 物理效果
            physics: const BouncingScrollPhysics(),
            // key
            key: PageStorageKey<String>(widget.name),
            // sliver
            slivers: <Widget>[
              // 这里是什么呀？
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(((BuildContext context, int index) {
                // 获取 common item
                return getCommonItem(list, index);
              }), childCount: list.length)),
            ],
          );
        },
      ),
    );
  }

  double singleLineImgHeight = 180.0;
  double contentVideoHeight = 350.0;

  // 列表的普通单个 item
  getCommonItem(List<Subject> items, int index) {
    // 对应索引的数据模型
    Subject item = items[index];
    // 如 index 是 1 或者 3 的话则展示视频
    bool showVideo = index == 1 || index == 3;

    // 返回一个 容器 Widget
    return Container(
      // 根据是视频还是其他 item 指定高度
      height: showVideo ? contentVideoHeight : singleLineImgHeight,
      // 颜色
      color: Colors.white,
      // 外边距，底部是 10
      margin: const EdgeInsets.only(bottom: 10.0),
      // 内边距
      padding: const EdgeInsets.only(left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT, top: Constant.MARGIN_RIGHT, bottom: 10.0),
      // 子 Widget 是一个列 Widget
      child: Column(
        // 顶部开始
        crossAxisAlignment: CrossAxisAlignment.start,
        // 列 Widget 中都有哪些子 Widget
        children: <Widget>[
          // 首先是一个行 Widget
          Row(
            children: <Widget>[
              // 从网络加载图片，并设置为圆角图片
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(item.casts?[0].avatars?.medium),
                backgroundColor: Colors.white,
              ),
              // 距离左边图片 10 的 item.title 的 Text Widget
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(item.title),
              ),
              // 延伸 Widget 占满横向的所有空间，展示一个 三个点 更多的小 Icon 图标
              const Expanded(
                // 一个 Align Widget
                child: Align(
                  // 居中的 Icon Widget
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  // 右边沿居中
                  alignment: Alignment.centerRight,
                ),
              )
            ],
          ),
          // 行 Widget 下面是一个 Expanded 延伸 Widget
          Expanded(
              // 子 Widget 是一个 容器 Container Widget
              child: Container(
            // 根据是否需要展示 Video 返回不同 Widget（视频内容或者图片内容）
            child: showVideo ? getContentVideo(index) : getItemCenterImg(item),
          )),
          // 下面是一组横向的 Image Widget，分别展示三个图标：点赞、评论、转发
          Padding(
            // 距离左右分别是 15
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            // 下面一行三个 Image Widget
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_vote.png',
                  width: 25.0,
                  height: 25.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_notification_tv_calendar_comments.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_status_detail_reshare_icon.png',
                  width: 25.0,
                  height: 25.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 返回一组横向的图片 Widget，这里对应的是如果是 图片 Item 时，横向展示 3 个 Image Widget
  getItemCenterImg(Subject item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          // 返回三个横向撑满屏幕的自定义的 Image Widget，左右两边的 Image Widget 分别切 左上左下 和 右上右下的圆角
          child: RadiusImg.get(item.images?.large, null,
              shape: const RoundedRectangleBorder(
                // 切 左上左下 的圆角
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
              )),
        ),
        Expanded(
          // 不切圆角
          child: RadiusImg.get(item.casts?[1].avatars?.medium, null, radius: 0.0),
        ),
        Expanded(
          child: RadiusImg.get(item.casts?[2].avatars?.medium, null,
              shape: const RoundedRectangleBorder(
                // 切 右上右下 的圆角
                borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
              )),
        ),
      ],
    );
  }

  // 返回一个播放视频的 Widget
  getContentVideo(int index) {
    // [【Flutter】mounted](https://blog.csdn.net/weixin_39370093/article/details/106815969)
    if (!mounted) {
      return Container();
    }

    return VideoWidget(
      url: index == 1 ? Constant.URL_MP4_DEMO_0 : Constant.URL_MP4_DEMO_1,
      previewImgUrl: index == 1 ? Constant.IMG_TMP1 : Constant.IMG_TMP2,
      showProgressBar: true,
    );
  }
}

// 动态 TAB
// ignore: unused_element
_loginContainer(BuildContext context) {
  // 返回一个 Align Widget
  return Align(
    // 居中
    alignment: const Alignment(0.0, 0.0),
    // 子 Widget 是一个 Column Widget
    child: Column(
      // 居中
      mainAxisAlignment: MainAxisAlignment.center,
      // 放在列中的子 Widget
      children: <Widget>[
        // 最上面是一个提示登录的默认图片 Image Widget
        Image.asset(
          // ignore: prefer_interpolation_to_compose_strings
          Constant.ASSETS_IMG + 'ic_new_empty_view_default.png',
          width: 120.0,
        ),
        // 一个提示文字的 Text Widget
        const Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
          child: Text(
            '登录后查看关注人动态',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
        // 可以点击的 Widget
        GestureDetector(
          // 子 Widget 是一个 Container 容器 Widget
          child: Container(
            // 内边距，左右距离为 35 上下距离为 8
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 8.0, bottom: 8.0),
            // 装饰
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            ),
            // 子 Widget 是 Text Widget
            child: const Text(
              '去登录',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ),
          ),
          // 点击事件暂时未开放
          onTap: () {
            // 暂时未开放
            MyRouter.push(context, MyRouter.searchPage, '搜索任意东西');
          },
        )
      ],
    ),
  );
}


// [{
// 	"resource": "/Users/hmc/Documents/GitHub/GitHub_Sourcetree/SSH/FlutterPractise/flutter_official_project/android",
// 	"owner": "_generated_diagnostic_collection_name_#4",
// 	"code": "0",
// 	"severity": 8,
// 	"message": "The supplied phased action failed with an exception.\nCould not create task ':generateLockfiles'.\nA problem occurred starting process 'command '/Users/hmc/Documents/GitHub/GitHub_Sourcetree/SSH/FlutterPractise/flutter_official_project/android/gradlew''\nCould not start '/Users/hmc/Documents/GitHub/GitHub_Sourcetree/SSH/FlutterPractise/flutter_official_project/android/gradlew'\nCannot run program \"/Users/hmc/Documents/GitHub/GitHub_Sourcetree/SSH/FlutterPractise/flutter_official_project/android/gradlew\" (in directory \"/Users/hmc/Documents/GitHub/GitHub_Sourcetree/SSH/FlutterPractise/flutter_official_project/android\"): error=2, No such file or directory\nerror=2, No such file or directory",
// 	"source": "Java",
// 	"startLineNumber": 1,
// 	"startColumn": 1,
// 	"endLineNumber": 1,
// 	"endColumn": 1
// }]
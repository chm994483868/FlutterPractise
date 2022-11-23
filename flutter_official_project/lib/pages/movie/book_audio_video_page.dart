// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_official_project/router.dart';
import 'package:flutter_official_project/widgets/my_tab_bar_widget.dart';
import 'dart:math' as math;
import 'package:flutter_official_project/widgets/search_text_field_widget.dart';

var titleList = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

List<Widget>? tabList;

// 书影音
// 包含了'电影', '电视', '综艺', '读书', '音乐', '同城' item Widget
// 这个 Widget 是整个项目中，十分复杂的 Widget 之一
class BookAudioVideoPage extends StatefulWidget {
  const BookAudioVideoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookAudioVideoPageState();
  }
}

TabController? _tabController;

class _BookAudioVideoPageState extends State<BookAudioVideoPage> with SingleTickerProviderStateMixin {
  var tabBar;

  @override
  void initState() {
    super.initState();

    tabBar = const HomePageTabBar();
    tabList = getTabList();
    _tabController = TabController(vsync: this, length: tabList?.length ?? 0);
  }

  List<Widget> getTabList() {
    return titleList.map((item) => Text('$item', style: const TextStyle(fontSize: 15),)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: DefaultTabController(length: titleList.length, child: _getNestedScrollView(tabBar))),
    );
  }
}

Widget _getNestedScrollView(Widget tabBar) {
  String hintText = '用一部电影来形容你的2018';
  
  return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // 这里是顶部的输入框
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: SearchTextFieldWidget(
                enabled: true,
                hintText: hintText,
                onTap: () {
                  // 暂时未开放
                  MyRouter.push(context, MyRouter.searchPage, hintText);
                },
              ),
            ),
          ),
          // 这里是顶部的：电影、电视、综艺、读书、音乐、同城 横向的 TabBar
          SliverPersistentHeader(
              floating: true,
              pinned: true,
              // 这里用了一个 _SliverAppBarDelegate 与 TabBar 进行联动，横行滑动时标签跟着切换，点击标签时下面内容自动进行横向滑动
              delegate: _SliverAppBarDelegate(
                  maxHeight: 49.0,
                  minHeight: 49.0,
                  child: Container(
                    color: Colors.white,
                    child: tabBar,
                  )))
        ];
      },
      // 下面是各个 TabBar 对应的内容 _tabController
      body: FlutterTabBarView(
        tabController: _tabController!,
      ));
}

class HomePageTabBar extends StatefulWidget {
  const HomePageTabBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageTabBarState createState() {
    return _HomePageTabBarState();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.minHeight, required this.maxHeight, required this.child,});

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _HomePageTabBarState extends State<HomePageTabBar> {
  Color? selectColor, unselectedColor;
  TextStyle? selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Colors.black;
    unselectedColor = const Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tab小部件列表
//    List<Widget>  @required this.tabs,
    // 组件选中以及动画的状态
//   TabController this.controller,
    // Tab是否可滑动(false->整个tab会把宽度填满，true-> tab包裹)
//  bool  this.isScrollable = false,
    // 选项卡下方的导航条的颜色
//   Color this.indicatorColor,
    // 选项卡下方的导航条的线条粗细
//   double this.indicatorWeight = 2.0,
//  EdgeInsetsGeometry  this.indicatorPadding = EdgeInsets.zero,
//   Decoration this.indicator,
//   TabBarIndicatorSize this.indicatorSize,导航条的长度，（tab：默认等分；label：跟标签长度一致）
//  Color  this.labelColor,所选标签标签的颜色
//  TextStyle  this.labelStyle,所选标签标签的文本样式
//  EdgeInsetsGeometry  this.labelPadding,,所选标签标签的内边距
// Color   this.unselectedLabelColor,未选定标签标签的颜色
//  TextStyle  this.unselectedLabelStyle,未选中标签标签的文字样式
//   void Function(T value) this.onTap,按下时的响应事件

    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TabBar(
        tabs: tabList!,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectedStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

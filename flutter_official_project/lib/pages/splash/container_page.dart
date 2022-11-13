import 'package:flutter/material.dart';
import 'package:flutter_official_project/pages/group/group_page.dart';
import 'package:flutter_official_project/pages/home/home_page.dart';
import 'package:flutter_official_project/pages/movie/book_audio_video_page.dart';
import 'package:flutter_official_project/pages/person/person_center_page.dart';
import 'package:flutter_official_project/pages/shop_page.dart';

// 首页的 Widget
class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContainerPageState();
}

// 一个自定义的 Item 类，用于表示一个底部的 BottomNavigationBarItem：文字、选中图片、非选中图片
class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}

// 首页的 Widget 的 State
class _ContainerPageState extends State<ContainerPage> {
  // ShopPageWidget 它比较特殊，所以这里把它单拎出来初始化
  final ShopPageWidget shopPageWidget = const ShopPageWidget();

  // 存放 5 个 BottomNavigationBarItem 对应的页面的 List
  // 5 个 Widget 分别是首页、书影音、小组、市集、我的
  late final List<Widget> pages;

  // 一个半灰色的色值
  final defaultItemColor = const Color.fromARGB(255, 125, 125, 125);

  // 5 个 BottomNavigationBarItem 的标题文字、选中图片、非选中图片
  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.png', 'assets/images/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/ic_tab_subject_active.png', 'assets/images/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/ic_tab_group_active.png', 'assets/images/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/ic_tab_shiji_active.png', 'assets/images/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/ic_tab_profile_active.png', 'assets/images/ic_tab_profile_normal.png')
  ];

  // 存放 5 个 BottomNavigationBarItem 的 List
  late final List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    debugPrint('initState _ContainerPageState');

    // State 的 init 函数中，初始化 pages、itemList 的值
    pages = [const HomePage(), const BookAudioVideoPage(), const GroupPage(), shopPageWidget, PersonCenterPage()];

    // 根据 itemNames List 中的数据初始化 5 个 BottomNavigationBarItem 存放在 itemList List 中
    itemList = itemNames
        .map((item) => BottomNavigationBarItem(
              icon: Image.asset(item.normalIcon, width: 30.0, height: 30.0),
              label: item.name,
              activeIcon: Image.asset(item.activeIcon, width: 30.0, height: 30.0),
            ))
        .toList();
  }

  // 标记当前选中了第几个 BottomNavigationBarItem
  int _selectIndex = 0;

  // Stack (层叠布局)+ Offstage 组合，解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    // 共 5 个页面，一个页面对应的一个 Offstage Widget，每次仅需显示一个页面，用 Offstage 的 offstage 属性控制指定页面显示与否
    return Offstage(
      // 根据当前的 _selectIndex 的值判定此页面是否要显示
      offstage: _selectIndex != index,
      // [【Flutter 组件集录】TickerMode｜ 8月更文挑战](https://cloud.tencent.com/developer/article/1958461)
      // 这里用到了一个从来没见过的 Widget：TickerMode，
      // Ticker 是动画控制器的底层驱动力，TickerMode 组件可以禁用/启用子树下所有的 Ticker，也就是说它可以让子树的所有动画无效或生效
      child: TickerMode(
        // 仅对当前选中的 page 开启动画
        enabled: _selectIndex == index,
        // 指定索引的 Page
        child: pages[index],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ContainerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build _ContainerPageState');

    return Scaffold(
      // 栈 Widget 中是 5 个页面
      body: Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
          _getPagesWidget(4),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      // 底部的 items
      bottomNavigationBar: BottomNavigationBar(
        // 5 个 BottomNavigationBarItem 的 List
        items: itemList,
        // 对应的的每个 item 的点击事件，对当前选中的 index 赋值
        onTap: (index) {
          // 这里根据点击的 index 来显示选中的 page
          setState(() {
            _selectIndex = index;
            // 这个是用来控制比较特别的 shopPage 中 WebView 不能动态隐藏的问题
            shopPageWidget.setShowState(pages.indexOf(shopPageWidget) == _selectIndex);
          });
        },
        // 图标大小
        iconSize: 24,
        // 当前选中的索引
        currentIndex: _selectIndex,
        // 选中后，底部 BottomNavidationBar 内容的颜色（选中时，默认为主题色）（仅当 type: BottomNavidationBarType.fixed 时生效）
        fixedColor: const Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

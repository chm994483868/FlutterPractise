import 'package:flutter/material.dart';
import 'package:flutter_official_project/pages/group/group_page.dart';
import 'package:flutter_official_project/pages/home/home_page.dart';
import 'package:flutter_official_project/pages/movie/book_audio_video_page.dart';
import 'package:flutter_official_project/pages/person/person_center_page.dart';
import 'package:flutter_official_project/pages/shop_page.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContainerPageState();
}

class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerPageState extends State<ContainerPage> {
  final ShopPageWidget shopPageWidget = const ShopPageWidget();
  late final List<Widget> pages;
  final defaultItemColor = const Color.fromARGB(255, 125, 125, 125);

  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.png', 'assets/images/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/ic_tab_subject_active.png', 'assets/images/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/ic_tab_group_active.png', 'assets/images/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/ic_tab_shiji_active.png', 'assets/images/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/ic_tab_profile_active.png', 'assets/images/ic_tab_profile_normal.png')
  ];

  late final List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    debugPrint('initState _ContainerPageState');

    pages = [const HomePage(), const BookAudioVideoPage(), const GroupPage(), shopPageWidget, const PersonCenterPage()];
    itemList = itemNames
        .map((item) => BottomNavigationBarItem(
            icon: Image.asset(
              item.normalIcon,
              width: 30.0,
              height: 30.0,
            ),
            label: item.name,
            activeIcon: Image.asset(item.activeIcon, width: 30.0, height: 30.0)))
        .toList();
  }

  int _selectIndex = 0;

  // Stack (层叠布局)+ Offstage 组合，解决状态被重置的问题
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
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
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (index) {
          // 这里根据点击的 index 来显示，非 index 的 page 均隐藏
          setState(() {
            _selectIndex = index;
            // 这个是用来控制比较特别的 shopPage 中 WebView 不能动态隐藏的问题
            // shopPageWidget
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

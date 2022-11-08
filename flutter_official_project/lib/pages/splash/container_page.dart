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
  List<Widget>? pages;
  final defaultItemColor = const Color.fromARGB(255, 125, 125, 125);

  final itemNames = [
    _Item('首页', 'assets/images/ic_tab_home_active.png', 'assets/images/ic_tab_home_normal.png'),
    _Item('书影音', 'assets/images/ic_tab_subject_active.png', 'assets/images/ic_tab_subject_normal.png'),
    _Item('小组', 'assets/images/ic_tab_group_active.png', 'assets/images/ic_tab_group_normal.png'),
    _Item('市集', 'assets/images/ic_tab_shiji_active.png', 'assets/images/ic_tab_shiji_normal.png'),
    _Item('我的', 'assets/images/ic_tab_profile_active.png', 'assets/images/ic_tab_profile_normal.png')
  ];

  List<BottomNavigationBarItem>? itemList;

  @override
  void initState() {
    super.initState();
    debugPrint('initState _ContainerPageState');

    pages ??= [const HomePage(), const BookAudioVideoPage(), const GroupPage(), shopPageWidget, const PersonCenterPage()];

    itemList ??= itemNames
        .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 30.0,
                height: 30.0,
              ),
              label: item.name,
              activeIcon: Image.asset(item.activeIcon, width: 30.0, height: 30.0),
            ))
        .toList();
  }

  final int _selectIndex = 0;

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages?[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text(
        'Temp placeholder!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

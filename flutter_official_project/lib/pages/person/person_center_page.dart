// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_official_project/constant/cache_key.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/widgets/image/heart_img_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart';

typedef VoidCallback = void Function();

// 个人中心
class PersonCenterPage extends StatelessWidget {
  const PersonCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');

    return Scaffold(
      // 白色背景
      backgroundColor: Colors.white,
      // 安全区
      body: SafeArea(
          child: Padding(
        // 顶部距离 10
        padding: const EdgeInsets.only(top: 10.0),
        // 自定义滚动视图
        child: CustomScrollView(
          // 物理效果
          physics: const BouncingScrollPhysics(),
          // 是否在滚动方向上有约束
          shrinkWrap: false,
          // 在 CustomScrollView 中，每一个独立的，可滚动的 Widget 被称之为 Sliver
          // [Flutter-Slivers](https://www.jianshu.com/p/39dab5c40acb)
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: HeartImgWidget(img: Image.asset(Constant.ASSETS_IMG + 'bg_person_center_default.webp')),
              // flexibleSpace: Image.asset(Constant.ASSETS_IMG + 'bg_person_center_default.webp'),
              expandedHeight: 200.0,
            ),

            // 顶部的提醒视图
            SliverToBoxAdapter(
              // 横向三个视图：一个小铃铛的图片、一个提醒的文字、一个最右边的向右的箭头
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 20.0, right: 10.0),
                    // 一个提醒的图片
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'ic_notify.png',
                      width: 30.0,
                      height: 30.0,
                    ),
                  ),
                  // 一个提醒的文字
                  const Expanded(
                    child: Text(
                      '提醒',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  // 最右边是一个箭头图标
                  _rightArrow()
                ],
              ),
            ),
            // 紧接着下面是一个 暂无新提醒 的文字
            SliverToBoxAdapter(
              // 高度是 100 的容器 Widget，居中显示
              child: Container(
                height: 100.0,
                alignment: Alignment.center,
                child: const Text(
                  '暂无新提醒',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            // 一个高度是 10 颜色是灰色的 SliverToBoxAdapter，作为分隔线使用
            _divider(),

            // "我的书影音" 五个大字的 Text Widget
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 20.0),
                child: Text(
                  '我的书影音',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
            ),

            // 这里是 影音、图书、音乐 三个 Tab
            SliverToBoxAdapter(
              child: Container(
                child: _VideoBookMusicBookWidget(),
              ),
            ),

            // 一个高度是 10 颜色是灰色的 SliverToBoxAdapter，作为分隔线使用
            _divider(),

            // 书影音数据是否来自网络的开关
            // _dataSelect(),

            // 一个高度是 10 颜色是灰色的 SliverToBoxAdapter，作为分隔线使用
            _divider(),

            // 一组左边是一个图标一个文字右边是一个箭头的 SliverToBoxAdapter
            _personItem('ic_me_journal.png', '我的发布'),
            _personItem('ic_me_follows.png', '我的关注'),
            _personItem('ic_me_photo_album.png', '相册'),
            _personItem('ic_me_doulist.png', '豆列 / 收藏'),

            // 一个高度是 10 颜色是灰色的 SliverToBoxAdapter，作为分隔线使用
            _divider(),

            _personItem('ic_me_wallet.png', '钱包'),
          ],
        ),
      )),
    );
  }

  // 一个向右的箭头的 Icon widget
  _rightArrow() {
    return const Icon(
      Icons.chevron_right,
      color: Color.fromARGB(255, 204, 204, 204),
    );
  }

  // SliverToBoxAdapter 内部是一个高度是 10 颜色是灰色的 Container Widget
  SliverToBoxAdapter _divider() {
    return SliverToBoxAdapter(
      child: Container(
        height: 10.0,
        color: const Color.fromARGB(255, 247, 247, 247),
      ),
    );
  }

  // 封装一个 _personItem，一个比较常见的样子，左边是一个图标和一个标题文字，右边是一个向右的按钮
  SliverToBoxAdapter _personItem(String imgAsset, String title, {VoidCallback? onTab}) {
    return SliverToBoxAdapter(
      // 用 GestureDetector 包裹，指定一个点击事件
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTab,
        child: Row(
          children: <Widget>[
            // 图标
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                Constant.ASSETS_IMG + imgAsset,
                width: 25.0,
                height: 25.0,
              ),
            ),

            // 标题文字
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15.0),
              ),
            ),

            // 一个指向右向的按钮
            _rightArrow()
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  _dataSelect() {
    return const UseNetDataWidget();
  }
}

// 这个用来改变书影音数据来自网络还是本地模拟
class UseNetDataWidget extends StatefulWidget {
  const UseNetDataWidget({super.key});

  @override
  _UseNetDataWidgetState createState() => _UseNetDataWidgetState();
}

class _UseNetDataWidgetState extends State<UseNetDataWidget> {
  bool mSelectNetData = false;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  // 对应到 iOS 这里是从本地的 user default 中读取数据：一个布尔值判断是从本地读取数据还是从网络加载数据
  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // 读取数据，默认是 false
      mSelectNetData = prefs.getBool(CacheKey.USE_NET_DATA) ?? false;
    });
  }

  // 往本地写入数据
  _setData(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 写入数据
    prefs.setBool(CacheKey.USE_NET_DATA, value);
  }

  @override
  Widget build(BuildContext context) {
    // SliverToBoxAdapter Widget 放在 CustomScrollView Widget 中
    return SliverToBoxAdapter(
      child: Padding(
        // 左右距离 10
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            // 文字提示
            const Text(
              '书影音数据是否来自网络',
              style: TextStyle(color: Colors.redAccent, fontSize: 17.0),
            ),

            // 中间隔开
            Expanded(
              child: Container(),
            ),

            // 最右边是一个 iOS 中的 UISwitch 控件，作为开关使用
            CupertinoSwitch(
              value: mSelectNetData,
              onChanged: (bool value) {
                mSelectNetData = value;
                _setData(value);

                // ignore: prefer_typing_uninitialized_variables
                var tmp;
                // 这里提示用户，设置开关以后需要重启 APP 生效
                if (value) {
                  tmp = '书影音数据 使用网络数据，重启APP后生效';
                } else {
                  tmp = '书影音数据 使用本地数据，重启APP后生效';
                }

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('提示'),
                        content: Text(tmp),
                        actions: const <Widget>[
                          // FlatButton(
                          //   child: const Text('稍后我自己重启'),
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          // ),
                          // FlatButton(
                          //   child: const Text('现在重启'),
                          //   onPressed: () {
                          //     RestartWidget.restartApp(context);
                          //     Navigator.of(context).pop();
                          //   },
                          // )
                        ],
                      );
                    });

                // 刷新开关
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}

// 影视、图书、音乐 TAB
class _VideoBookMusicBookWidget extends StatefulWidget {
  @override
  _VideoBookMusicBookWidgetState createState() => _VideoBookMusicBookWidgetState();
}

class _VideoBookMusicBookWidgetState extends State<_VideoBookMusicBookWidget> with SingleTickerProviderStateMixin {
  
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabTxt.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: DefaultTabController(
          length: tabTxt.length,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _TabBarWidget(),
              ),
              _tabView()
            ],
          )),
    );
  }

  Widget _tabView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          _tabBarItem('bg_videos_stack_default.png'),
          _tabBarItem('bg_books_stack_default.png'),
          _tabBarItem('bg_music_stack_default.png'),
        ],
      ),
    );
  }

  Widget getTabViewItem(String img, String txt) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 7.0),
            child: Image.asset(
              Constant.ASSETS_IMG + img,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(txt)
      ],
    );
  }

  _tabBarItem(String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        getTabViewItem(img, '想看'),
        getTabViewItem(img, '在看'),
        getTabViewItem(img, '看过'),
      ],
    );
  }
}

class _TabBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabBarWidgetState();
}

late TabController _tabController;

class _TabBarWidgetState extends State<_TabBarWidget> {
  late Color selectColor, unselectedColor;
  late TextStyle selectStyle, unselectedStyle;
  late List<Widget> tabWidgets;

  @override
  void initState() {
    super.initState();

    selectColor = Colors.black;
    unselectedColor = const Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
    tabWidgets = tabTxt
        .map((item) => Text(
              item,
              style: const TextStyle(fontSize: 15),
            ))
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabWidgets,
      isScrollable: true,
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.label,
      controller: _tabController,
    );
  }
}

final List<String> tabTxt = ['影视', '图书', '音乐'];

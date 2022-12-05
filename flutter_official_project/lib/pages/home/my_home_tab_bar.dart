import 'package:flutter/material.dart';
import 'package:flutter_official_project/router.dart';
import 'package:flutter_official_project/util/screen_utils.dart';
import 'package:stack_trace/stack_trace.dart';

const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 42.0;

class HomeTabBar extends StatefulWidget implements PreferredSizeWidget {
  final TabBar tabBar;
  final double translate;

  const HomeTabBar({super.key, required this.tabBar, required this.translate});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTabBarState createState() => _HomeTabBarState();

  @override
  Size get preferredSize {
    debugPrint('🐑🐑🐑 ${Trace.current().frames[0].member}');
    debugPrint('preferredSize');

    for (Widget item in tabBar.tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if (tab.text != null && tab.icon != null) {
          // 返回一个指定高度和无限宽度的 Size
          return Size.fromHeight(_kTextAndIconTabHeight + tabBar.indicatorWeight);
        }
      }
    }

    // 如果不存在 tabs 的话就返回一个默认的 Size
    return Size.fromHeight(_kTabHeight + tabBar.indicatorWeight);
  }
}

class _HomeTabBarState extends State<HomeTabBar> {
  double get allHeight => widget.preferredSize.height;

  @override
  Widget build(BuildContext context) {
    // [Flutter 94: 初识 MediaQuery](https://www.jianshu.com/p/254aa5610396)
    MediaQuery.of(context);

    // 获取一个适配屏幕的指定的宽度
    var value = ScreenUtils.screenW(context) * 0.75 - 10.0;

    // 返回一个堆栈 Widget
    return Stack(
      // 内部是一个 Positioned Widget 和一个 Padding Widget
      children: <Widget>[
        // 绝对定位
        Positioned(
          // 左边
          left: 15.0,
          // 右边
          right: value,
          // 顶部
          top: getTop(widget.translate),
          // 子 Widget
          child: getOpacityWidget(Container(
            // 顶 3 底 3 右 10 左 5
            padding: const EdgeInsets.only(top: 3.0, bottom: 3.0, right: 10.0, left: 5.0),
            // 装饰
            decoration: const BoxDecoration(
              color: Color.fromARGB(245, 236, 236, 236),
              borderRadius: BorderRadius.all(Radius.circular(17.0)),
            ),
            // 行 Widget 内部左边展示一个搜索图标右边展示一个 “搜索” 文字
            child: Row(
              children: <Widget>[
                // 搜索按钮图标
                const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 128, 128, 129),
                ),
                // 右边延伸到最右边
                Expanded(
                  // 添加一个手势响应
                  child: GestureDetector(
                    // 使用 Align 包裹一个 Text Widget，位于屏幕最右边
                    child: const Align(
                      // x 值为 1，表示最右边
                      alignment: Alignment(1.0, 0.0),
                      // 搜索文字的 Widget
                      child: Text(
                        '搜索',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 192, 192, 192),
                        ),
                      ),
                    ),
                    // 点击事件
                    onTap: () {
                      // 暂时未开放
                      MyRouter.push(context, MyRouter.searchPage, '搜索流浪地球试一试');
                    },
                  ),
                )
              ],
            ),
          )),
        ),
        // 仅是底部距离为 5 的 Padding
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          // Row Widget 里面包含三个 Expanded Widget，所占空间是 1:3:1
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                // 宽度占 3 份的 Expanded Widget 中是 tabBar
                child: widget.tabBar,
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        )
      ],
    );
  }

  double getTop(double translate) {
    return Tween<double>(begin: allHeight, end: 0.0).transform(widget.translate);
  }

  Widget getOpacityWidget(Widget child) {
    if (widget.translate == 1) {
      return child;
    }

    return Opacity(
      opacity: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn).transform(widget.translate),
      child: child,
    );
  }
}

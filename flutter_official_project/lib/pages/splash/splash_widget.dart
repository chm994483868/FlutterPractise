import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_official_project/constant/constant.dart';
import 'package:flutter_official_project/pages/splash/container_page.dart';
import 'package:flutter_official_project/util/screen_utils.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  // App 的内容，包含启动后整个 App 的 5 个 Tab 页面
  var container = const ContainerPage();
  // 指示是否显示启动屏广告
  bool showAd = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('build splash');

    // 栈 Widget，里面包了两个 Offstage Widget
    return Stack(
      children: <Widget>[
        // 使用两个 Offstage，一个用于控制显示 App 的内容，一个用于控制显示 5 秒倒计时的启动屏广告
        // 它们分别使用 showAd 和 !showAd 作为 offstage 的值，即一次控制显示其中一个

        // 第一个 Offstage 控制显示首页
        Offstage(
          offstage: showAd,
          child: container,
        ),

        // 第二个 Offstage 控制显示启动屏
        Offstage(
          offstage: !showAd,
          // Container 展示启动屏内容，其宽高就是当前屏幕的宽高
          child: Container(
            // 白色
            color: Colors.white,
            // 宽高是屏幕的宽高
            width: ScreenUtils.screenW(context),
            height: ScreenUtils.screenH(context),
            // 栈 Widght，分了两大块：一个是屏幕中心的圆形展示图和一句文字描述的 Align，一个是包含顶部倒计时和底部 logo 的 SafeArea
            child: Stack(
              children: <Widget>[
                // [flutter Align 与 Center](https://www.jianshu.com/p/40561e06f87f)
                Align(
                  // (0.0, 0.0) 指居中
                  alignment: const Alignment(0.0, 0.0),
                  // 列 Widget：上面一个圆形图像下面一行诗句
                  child: Column(
                    // 居中
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // 圆形图像的 Widget
                      CircleAvatar(
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        // ignore: prefer_interpolation_to_compose_strings
                        backgroundImage: const AssetImage(Constant.ASSETS_IMG + 'home.png'),
                      ),

                      // 这里 Text Widget 作为 Padding Widget 的 child widget，即可表示在 Flutter 中 Paddging 也是一个 Widget
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        // Text Widget
                        child: Text(
                          '落花有意随流水，流水无心恋落花',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),

                // 安全区 Widget，适配不同的异形屏
                SafeArea(
                    // 列 Widget，顶部是一个倒计时文字 Widget，底部是一个 logo Widget
                    child: Column(
                  // MainAxisAlignment.spaceBetween 可以使 Column 中的 倒计时文字 和 Hi豆芽 文字分别位于屏幕的上下两端
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // 屏幕顶部倒计时文字的 Widget
                    Align(
                      // 这个 const Alignment(1.0, 0.0) 值 x 值是 1 使其父视图位于屏幕的右边
                      alignment: const Alignment(1.0, 0.0),
                      // 然后它的 child 属性放置一个 Container 来包裹倒计时的文字
                      child: Container(
                        // 这里给它一个固定宽高，要不然倒计时数字 -1 变化的过程中文字宽度发生变化，这个小视图会跳动
                        width: 80,
                        height: 30,
                        // 扩充右边和顶部与屏幕边缘的距离
                        margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                        // 使 Container 中的 child 居中显示
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                        // 给 Container 添加一个圆角带背景色的装饰
                        decoration: const BoxDecoration(
                          // color: Color(0xffEDEDED),
                          color: Colors.black26,
                          // 4 个角切圆角
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        // Container 的子 widget 用于显示倒计时的文字
                        child: CountDownWidget(
                          onCountDownFinishCallBack: (bool value) {
                            // 倒计时结束的回调，当倒计时结束后，隐藏启动屏，展示 APP 的首页
                            if (value) {
                              setState(() {
                                showAd = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    // 屏幕底部的 Hi，豆芽 文字的 Widget
                    Padding(
                      // 这里也是经典的 Padding Widget 包裹 child Widget 为其添加 padding
                      // 首先来一个距离上下左右的距离都是 40
                      padding: const EdgeInsets.only(left: 40.0),
                      // child 是一个 Row 行，包含两个 Widget，一个是左边的图片，一个是右边的文字
                      child: Row(
                        // 居中显示
                        mainAxisAlignment: MainAxisAlignment.center,
                        // 子 Widget，一个图片一个文字
                        children: <Widget>[
                          // 豆瓣的小 logo 图片
                          Image.asset(
                            // ignore: prefer_interpolation_to_compose_strings
                            Constant.ASSETS_IMG + 'ic_launcher.png',
                            width: 50,
                            height: 50,
                          ),

                          // 经典 Padding Widget 里面包裹一个子 Widget 为其添加 padding
                          const Padding(
                            // 左边距离 logo 图片 10
                            padding: EdgeInsets.only(left: 10.0),
                            // 文字展示
                            child: Text(
                              'Hi，豆芽',
                              style: TextStyle(color: Colors.green, fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}

// 倒计时的 Widget
class CountDownWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onCountDownFinishCallBack;

  const CountDownWidget({super.key, required this.onCountDownFinishCallBack});

  @override
  // ignore: library_private_types_in_public_api
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  var _seconds = 6;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 在 State 初始化函数中开启倒计时
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // 外层添加一个点击手势，点击跳过按钮结束倒计时直接进入首页
    return GestureDetector(
      // 启动屏倒计时读秒
      child: Text(
        '跳过：$_seconds',
        style: const TextStyle(fontSize: 12.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      // 点击回调
      onTap: () {
        // 结束倒计时展示首页
        _showContainerPage();
      },
    );
  }

  // 启动倒计时的计时器
  void _startTimer() {
    // 倒计时 1 秒执行一次
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});

      if (_seconds <= 1) {
        // 倒计时结束，展示首页
        _showContainerPage();
        return;
      }
      _seconds--;
    });
  }

  // 跳过启动屏倒计时，直接展示首页
  void _showContainerPage() {
    widget.onCountDownFinishCallBack(true);
    _cancelTimer();
  }

  // 取消倒计时的计时器
  void _cancelTimer() {
    _timer?.cancel();
  }
}

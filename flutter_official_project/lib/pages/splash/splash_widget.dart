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
  var container = const ContainerPage();
  bool showAd = true;

  @override
  Widget build(BuildContext context) {
    debugPrint('build splash');

    return Stack(
      children: <Widget>[
        // 使用两个 Offstage，一个用于显示 App 的内容，一个是用于显示 5 秒倒计时的启动屏广告
        Offstage(
          offstage: showAd,
          child: container,
        ),
        Offstage(
          offstage: !showAd,
          child: Container(
            color: Colors.white,
            width: ScreenUtils.screenW(context),
            height: ScreenUtils.screenH(context),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: const Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        // ignore: prefer_interpolation_to_compose_strings
                        backgroundImage: const AssetImage(Constant.ASSETS_IMG + 'home.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          '落花有意随流水，流水无心恋落花',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: const Alignment(1.0, 0.0),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                        decoration: const BoxDecoration(
                          color: Color(0xffEDEDED),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: CountDownWidget(
                          onCountDownFinishCallBack: (bool value) {
                            // 倒计时结束以后隐藏广告
                            if (value) {
                              setState(() {
                                showAd = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            // ignore: prefer_interpolation_to_compose_strings
                            Constant.ASSETS_IMG + 'ic_launcher.png',
                            width: 50,
                            height: 50,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
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

class CountDownWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onCountDownFinishCallBack;

  const CountDownWidget({Key? key, required this.onCountDownFinishCallBack}) : super(key: key);

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
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style: const TextStyle(fontSize: 17.0),
    );
  }

  /// 启动倒计时的计时器
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  /// 取消倒计时的计时器
  void _cancelTimer() {
    _timer?.cancel();
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_official_project/pages/splash/splash_widget.dart';

void main() {
  runApp(const MyApp());
  setAndroidOverlayStyle();
}

// 仅针对 Android 平台，设置 android 头部的导航栏透明
void setAndroidOverlayStyle() {
  if (!Platform.isAndroid) {
    return;
  }

  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // RestartWidget 是一个自定义的 Widget，用于控制重启整个应用
    return RestartWidget(
      // Material 设计风格的 Widget
      child: MaterialApp(
        theme: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
        home: const Scaffold(
          // body 是启动引导页
          body: SplashWidget(),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget? child;

  const RestartWidget({Key? key, required this.child})
      : assert(child != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state = context.findAncestorStateOfType<_RestartWidgetState>()!;
    state.restartApp();
  }

  @override
  // ignore: library_private_types_in_public_api
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  // 此处的 widget 变量是获取当前 state 所属的 StatefulWidget
  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}

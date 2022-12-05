import 'package:flutter/material.dart';
import 'package:flutter_official_project/pages/container_page.dart';
import 'package:flutter_official_project/pages/splash/splash_new_widget.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  bool _showAD = true;
  var container = const ContainerPage();

  @override
  Widget build(BuildContext context) {
    return _showAD ? SplashNewWidget(onCountDownFinishCallBack: (bool value) {
    if (value) {
      setState(() {
        _showAD = false;
      });
    }
  }) : container;
  }
}

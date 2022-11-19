import 'package:flutter/material.dart';
import 'package:flutter_official_project/constant/constant.dart';

typedef OnTabBack = void Function();

// 导航头，如果设置了 body，则不用再次使用 Scaffold
class TitleBar extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Widget? body;
  final OnTabBack? onTabBack;
  final EdgeInsetsGeometry? padding;

  const TitleBar(
      {super.key,
      this.title,
      this.backgroundColor = Colors.white,
      this.onTabBack,
      this.padding,
      this.body});

  @override
  Widget build(BuildContext context) {
    if (body == null) {
      return _title(context);
    }
    
    return Scaffold(
      body: Container(
        padding: padding ?? const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        color: backgroundColor,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _title(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: body,
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            child: Padding(
              padding: padding ?? const EdgeInsets.all(10.0),
              child: Image.asset(
                '${Constant.ASSETS_IMG}ic_arrow_back.png',
                width: 25.0,
                height: 25.0,
              ),
            ),
            onTap: () {
              if (onTabBack == null) {
                Navigator.of(context).pop();
              } else {
                onTabBack!();
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title ?? '',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

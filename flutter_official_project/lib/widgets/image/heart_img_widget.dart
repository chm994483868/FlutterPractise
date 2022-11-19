// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class HeartImgWidget extends StatefulWidget {
  final Image img;

  const HeartImgWidget({super.key, required this.img});

  @override
  State<StatefulWidget> createState() => _HeartImgWidgetState();
}

class _HeartImgWidgetState extends State<HeartImgWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedImg(
      img: widget.img,
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _AnimatedImg extends StatelessWidget {
  static final _opacityTween = Tween<double>(begin: 0.5, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 290.0, end: 300.0);

  final Image img;
  final Animation<double> animation;

  const _AnimatedImg({required this.img, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: img,
        ),
      ),
    );
  }
}

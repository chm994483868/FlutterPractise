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
    // return _AnimatedImg(widget.img, animation: animation);
    return const Text('暂时不知道怎么处理这里...');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// class _AnimatedImg extends AnimatedWidget {
//   static final _opacityTween = Tween<double>(begin: 0.5, end: 1.0);
//   static final _sizeTween = Tween<double>(begin: 290.0, end: 300.0);
//   final Image img;
//   // _AnimatedImg(this.img, {Key? key, Animation<double>? animation})
//       // : super(key: key, listenable: animation);
// // ignore: unused_element
// _AnimatedImg({super.key, required super.listenable, required this.img});
//   @override
//   Widget build(BuildContext context) {
//     // final Animation<double> animation = listenable;
//     return Center(
//       child: Opacity(
//         // opacity: _opacityTween.evaluate(animation),
//         opacity: 0.5,
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 10.0),
//           // height: _sizeTween.evaluate(animation),
//           // width: _sizeTween.evaluate(animation),
//           child: img,
//         ),
//       ),
//     );
//   }
// }

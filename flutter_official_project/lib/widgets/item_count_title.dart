import 'package:flutter/material.dart';
import 'package:flutter_official_project/constant/color_constant.dart';
import 'package:flutter_official_project/constant/text_size_constant.dart';

typedef OnClick = void Function();

// 左边是豆瓣热门，右边是全部
class ItemCountTitle extends StatelessWidget {
//  final state = _ItemCountTitleState();
  // ignore: prefer_typing_uninitialized_variables
  final count;
  final OnClick? onClick;
  final String title;
  final double? fontSize;

  const ItemCountTitle({super.key, this.count, this.onClick, required this.title, this.fontSize});

  // const ItemCountTitle(this.title, double? fontSize, OnClick? onClick, {super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize ?? TextSizeConstant.BookAudioPartTabBar,
                fontWeight: FontWeight.bold,
                color: ColorConstant.colorDefaultTitle),
          )),
          Text(
            '全部 ${count ?? 0} > ',
            style: const TextStyle(
                fontSize: 12, color: Colors.grey, ),
          )
        ],
      ),
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
    );
  }
}

//class _ItemCountTitleState extends State<ItemCountTitle> {
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      child: Row(
//        children: <Widget>[
//          Expanded(
//              child: Text(
//            widget.title,
//            style: TextStyle(
//                fontSize: TextSizeConstant.BookAudioPartTabBar,
//                fontWeight: FontWeight.bold,
//                color: ColorConstant.colorDefaultTitle),
//          )),
//          Text(
//            '全部 ${widget.count} > ',
//            style: TextStyle(
//                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
//          )
//        ],
//      ),
//      onTap: () {
//        if (widget.onClick != null) {
//          widget.onClick();
//        }
//      },
//    );
//  }
//
//}

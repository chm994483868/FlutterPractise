import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final String? hintText;
  final EdgeInsetsGeometry? margin;
  final bool enabled;

  const SearchTextFieldWidget({super.key, this.hintText, this.onSubmitted, this.onTap, this.margin, required this.enabled});

  @override
  Widget build(BuildContext context) {
    // 一个容器 Widget
    return GestureDetector(
      onTap: enabled == false ? onTap : null,
      child: Container(
        // 外边距
        margin: margin ?? const EdgeInsets.all(0.0),
        // 容器宽度是屏幕宽度
        width: MediaQuery.of(context).size.width,
        // 容器中的内容居中展示
        alignment: AlignmentDirectional.center,
        // 容器高度
        height: 40.0,
        // 装饰
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // 子 Widget 是一个输入框
        child: TextField(
          enabled: enabled,
          // 输入内容发生变化的回调
          onSubmitted: onSubmitted,
          // 点击的回调
          onTap: onTap,
          // 光标颜色
          // cursorColor: const Color.fromARGB(255, 0, 189, 96),
          cursorColor: Colors.blue,
          // 装饰
          decoration: InputDecoration(
            // 内边距
            contentPadding: const EdgeInsets.only(top: 5.0),
            // 边缘
            border: InputBorder.none,
            // 输入框的占位文字
            hintText: hintText,
            // 占位文字的 Style
            hintStyle: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 192, 191, 191)),
            // 左边显示一个 Icon
            prefixIcon: const Icon(
              Icons.search,
              size: 25,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
          // 输入文字的 Style
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // 一个没有被调用的函数
  getContainer(BuildContext context, ValueChanged<String> onSubmitted) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 237, 236, 237), borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        cursorColor: const Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 20),
            prefixIcon: const Icon(
              Icons.search,
              size: 29,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

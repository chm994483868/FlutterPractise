// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class NetworkImgWidget extends StatefulWidget {
  final imgUrl;
  final placeHolderAsset;

  const NetworkImgWidget({super.key, this.placeHolderAsset, this.imgUrl});

  @override
  // ignore: no_logic_in_create_state
  State<NetworkImgWidget> createState() => _NetworkImgWidgetState(placeHolderAsset, imgUrl);
}

class _NetworkImgWidgetState extends State<NetworkImgWidget> {
  final placeHolderAsset;
  final imgUrl;
  late Image img, netImg;

  _NetworkImgWidgetState(this.placeHolderAsset, this.imgUrl);

  @override
  void initState() {
    super.initState();

    img = Image.asset(placeHolderAsset);
    try {
      netImg = Image.network(imgUrl);
    } on Exception catch (e) {
      debugPrint(e as String?);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[img, netImg],
    );
  }
}

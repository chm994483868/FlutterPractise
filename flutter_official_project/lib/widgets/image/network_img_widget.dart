// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, unused_element

// import 'package:flutter/material.dart';

// class NetworkImgWidget extends StatefulWidget {
//   final imgUrl;
//   final placeHolderAsset;

//   const NetworkImgWidget({super.key, this.placeHolderAsset, this.imgUrl});

//   @override
//   State<StatefulWidget> createState() {
//     return _NetworkImgWidgetState(placeHolderAsset: placeHolderAsset, imgUrl: imgurl);
//   }
// }

// class _NetworkImgWidgetState extends State<NetworkImgWidget> {
//   final imgUrl;
//   final placeHolderAsset;
//   Image img, netImg;

//   _NetworkImgWidgetState({required this.placeHolderAsset, required this.imgUrl});

//   @override
//   void initState() {
//     super.initState();

//     img = Image.asset(placeHolderAsset);
//     try{
//       netImg = Image.network(imgUrl);
//     }on Exception catch(e){
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: <Widget>[
//       img,
//       netImg
//     ],);
//   }

// }

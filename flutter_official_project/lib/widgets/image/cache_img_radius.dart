import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef OnTab = void Function();

class CacheImgRadius extends StatelessWidget {
  final String imgUrl;
  final double? radius;
  final OnTab? onTab;

  const CacheImgRadius({super.key, required this.imgUrl, this.radius, this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0.0)),
        child: CachedNetworkImage(imageUrl: imgUrl),
      ),
      onTap: () {
        if (onTab != null) {
          onTab!();
        }
      },
    );
  }
}

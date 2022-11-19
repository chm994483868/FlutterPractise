import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

typedef ColorCallBack = void Function(Color? color);

class PickImgMainColor {
  static Future<void> pick(ImageProvider imageProvider, ColorCallBack callBack) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    if (paletteGenerator.colors.isNotEmpty) {
      callBack(paletteGenerator.colors.toList()[0]);
    } else {
      callBack(null);
    }
  }

  static Future<Color?> pick2(ImageProvider imageProvider) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    if (paletteGenerator.colors.isNotEmpty) {
      return (paletteGenerator.colors.toList()[0]);
    } else {
      return (null);
    }
  }
}

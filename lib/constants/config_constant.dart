import 'package:flutter/material.dart';

class ConfigConstant {
  static const double radius = 8.0;
  static const double appBarHeight = kToolbarHeight;
  static const double toolbarHeight = kToolbarHeight;

  static const double margin1 = 8;
  static const double margin2 = 16;

  static final double objectHeight1 = 48.0;
  static final double objectHeight2 = 54.0;
  static final double objectHeight3 = 72.0;
  static final double objectHeight4 = 96.0;
  static final double objectHeight5 = 120.0;

  static final double iconSize1 = 16.0;
  static final double iconSize2 = 32.0;

  static const Duration duration = Duration(milliseconds: 350);
  static const Duration fadeDuration = Duration(milliseconds: 150);

  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 10,
      color: Colors.black.withOpacity(0.2),
      offset: Offset(0, 2),
    )
  ];
}

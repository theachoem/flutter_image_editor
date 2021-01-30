import 'package:flutter/material.dart';

class ConfigConstant {
  static const double radius = 8.0;
  static const double margin = 16;
  static const double iconSize = 16;
  static const double objectSize = 48;
  static const double appBarHeight = kToolbarHeight;
  static const double toolbarHeight = kToolbarHeight;

  static const Duration duration = Duration(milliseconds: 350);
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 10,
      color: Colors.black.withOpacity(0.2),
      offset: Offset(0, 2),
    )
  ];
}

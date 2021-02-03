import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';

mixin BottomNavMixin {
  Widget positionedBottomNav({
    BuildContext context,
    Widget child,
    double bottomNavHeight = ConfigConstant.margin2,
  }) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(bottom: bottomNavHeight),
        child: Material(
          elevation: 0,
          color: Theme.of(context).primaryColor,
          child: child,
        ),
      ),
    );
  }
}

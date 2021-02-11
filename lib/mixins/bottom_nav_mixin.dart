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

  PersistentBottomSheetController showStylesBottomSheet({
    EdgeInsets margin,
    GlobalKey<ScaffoldState> scaffoldKey,
    double objectHeight,
    @required Widget child,
  }) {
    return scaffoldKey.currentState.showBottomSheet(
      (context) {
        return Container(
          margin: margin,
          height: objectHeight,
          color: Theme.of(context).primaryColor,
          child: child,
        );
      },
      backgroundColor: Colors.transparent,
    );
  }
}

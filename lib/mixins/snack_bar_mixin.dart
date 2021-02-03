import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';

mixin SnackBarMixin {
  showFieSnackBar({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    double bottomNavHeight,
    String label,
    String actionLabel,
    Function onPressed,
  }) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        padding: EdgeInsets.only(
          bottom: bottomNavHeight != null ? bottomNavHeight + 22 : 0,
          left: ConfigConstant.margin2,
        ),
        content: Text(
          'Auto-adjusted',
          textAlign: TextAlign.start,
        ),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onPressed,
              )
            : null,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

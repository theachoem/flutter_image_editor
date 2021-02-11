import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/constants/theme_constant.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';

class FieButton extends StatelessWidget {
  const FieButton({
    Key key,
    @required this.item,
    this.isSelected = false,
    @required this.onTap,
  }) : super(key: key);

  final BottomNavButtonModel item;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: isSelected ? Theme.of(context).accentColor : null,
    );

    return InkWell(
      onTap: onTap != null ? onTap : () {},
      child: Container(
        alignment: Alignment.center,
        height: ConfigConstant.toolbarHeight,
        width: MediaQuery.of(context).size.width / 3,
        child: Text(item.label, style: style),
      ),
    );
  }

  static Widget icon({
    Key key,
    BottomNavButtonModel item,
    bool isSelected = false,
    Function onTap,
  }) {
    return InkWell(
      onTap: onTap != null ? onTap : () {},
      child: Container(
        alignment: Alignment.center,
        height: ConfigConstant.toolbarHeight,
        width: ConfigConstant.toolbarHeight,
        child: Icon(
          item.iconData,
          color: isSelected ? ThemeConstant.skyPrimary : null,
        ),
      ),
    );
  }
}

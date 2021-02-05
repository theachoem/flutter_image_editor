import 'package:flutter/material.dart';
import 'package:flutter_image_editor/mixins/snack_bar_mixin.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/fire_text_button.dart';

class FieBottomNav extends StatelessWidget with SnackBarMixin {
  const FieBottomNav({
    Key key,
    @required this.scaffoldKey,
    @required this.editingNotifier,
    @required this.centeredItems,
    @required this.onSaved,
  }) : super(key: key);

  final EditingNotifier editingNotifier;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<BottomNavButtonModel> centeredItems;
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          FieButton.icon(
            item: BottomNavButtonModel(
              type: BottomNavsType.Cancels,
              label: 'Cancels',
              iconData: Icons.clear,
            ),
            isSelected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Spacer(),
          for (var i = 0; i < centeredItems.length; i++)
            FieButton.icon(
              item: centeredItems[i],
              isSelected: true,
              onTap: centeredItems[i].onPressed,
            ),
          Spacer(),
          FieButton.icon(
            item: BottomNavButtonModel(
              type: BottomNavsType.Apply,
              label: 'Apply',
              iconData: Icons.check,
            ),
            isSelected: true,
            onTap: onSaved,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/models/app_bar_button_model.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:hooks_riverpod/all.dart';

class FieAppBar extends PreferredSize {
  final bool isEditing;

  FieAppBar({this.isEditing = false})
      : super(
          preferredSize: const Size.fromHeight(ConfigConstant.toolbarHeight),
          child: null,
        );

  final List<AppBarButtonModel> appActionsButton = AppBarButtonModel.appActionsButton;
  final AppBarButtonModel leading = AppBarButtonModel.leading;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, reader, child) {
      var notifier = reader(imageNotifier);
      return AppBar(
        elevation: 0.0,
        excludeHeaderSemantics: true,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: FlatButton(
          onPressed: () async {
            await notifier.pickAnImage();
            if (notifier.requestStatus && !isEditing) {
              Navigator.pushReplacementNamed(context, '/editing');
            }
          },
          child: Text(
            leading.label.toUpperCase(),
          ),
        ),
        actions: List.generate(
          appActionsButton.length,
          (index) => Container(
            padding: const EdgeInsets.all(ConfigConstant.margin1),
            child: IgnorePointer(
              ignoring: !isEditing,
              child: Opacity(
                opacity: isEditing ? 1 : 0.5,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  tooltip: appActionsButton[index].label,
                  onPressed: () {
                    switch (index) {
                      case 1:
                        Navigator.pushNamed(context, '/image_info');
                        break;
                    }
                  },
                  icon: Icon(
                    appActionsButton[index].iconData,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

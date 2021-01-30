import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/base_item_model.dart';
import 'package:flutter_image_editor/types/app_bar_type.dart';

class AppBarButtonModel extends BaseItemModel {
  final AppBarType type;

  AppBarButtonModel({
    @required this.type,
    String label,
    IconData iconData,
  }) : super(label, iconData);

  static AppBarButtonModel get leading {
    return AppBarButtonModel(
      label: "Open",
      type: AppBarType.Open,
    );
  }

  static List<AppBarButtonModel> get appActionsButton {
    return [
      AppBarButtonModel(
        iconData: Icons.layers,
        label: "Edit Stack",
        type: AppBarType.EditStack,
      ),
      AppBarButtonModel(
        iconData: Icons.info,
        label: "Image Details",
        type: AppBarType.ImageDetails,
      ),
      AppBarButtonModel(
        iconData: Icons.more_vert,
        label: "More Options",
        type: AppBarType.MoreOptions,
      ),
    ];
  }
}

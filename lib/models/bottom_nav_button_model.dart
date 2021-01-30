import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/base_item_model.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';

class BottomNavButtonModel extends BaseItemModel {
  final BottomNavsType type;

  BottomNavButtonModel({
    @required this.type,
    String label,
    IconData iconData,
  }) : super(label, iconData);

  static List<BottomNavButtonModel> get items {
    return [
      BottomNavButtonModel(
        label: "Styles",
        type: BottomNavsType.Styles,
      ),
      BottomNavButtonModel(
        label: "Tools",
        type: BottomNavsType.Tools,
      ),
      BottomNavButtonModel(
        label: "Export",
        type: BottomNavsType.Export,
      ),
    ];
  }
}

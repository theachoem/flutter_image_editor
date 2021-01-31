import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/base_item_model.dart';
import 'package:flutter_image_editor/types/styles_type.dart';

class StylesItemModel extends BaseItemModel {
  final StyleType type;

  StylesItemModel({
    @required this.type,
    String label,
    IconData iconData,
  }) : super(label, iconData);

  static List<StylesItemModel> get items {
    return [
      StylesItemModel(
        type: StyleType.Current,
        label: "Currents",
      ),
      StylesItemModel(
        label: "Portrait",
        type: StyleType.Portrait,
      ),
      StylesItemModel(
        label: "Smooth",
        type: StyleType.Smooth,
      ),
      StylesItemModel(
        label: "Pop",
        type: StyleType.Pop,
      ),
      StylesItemModel(
        label: "Accentuate",
        type: StyleType.Accentuate,
      ),
      StylesItemModel(
        label: "Faded Glow",
        type: StyleType.FadedGlow,
      ),
      StylesItemModel(
        label: "Morning",
        type: StyleType.Morning,
      ),
      StylesItemModel(
        label: "Bright",
        type: StyleType.Bright,
      ),
      StylesItemModel(
        label: "FineArt",
        type: StyleType.FineArt,
      ),
      StylesItemModel(
        label: "Push",
        type: StyleType.Push,
      ),
      StylesItemModel(
        label: "Structure",
        type: StyleType.Structure,
      ),
      StylesItemModel(
        label: "Sihouette",
        type: StyleType.Sihouette,
      ),
    ];
  }
}

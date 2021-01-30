import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/base_item_model.dart';
import 'package:flutter_image_editor/types/export_type.dart';

class ExportItemModel extends BaseItemModel {
  final ExportType type;
  final String subtitle;

  ExportItemModel({
    @required this.type,
    this.subtitle,
    String label,
    IconData iconData,
  }) : super(label, iconData);

  static List<ExportItemModel> get items {
    return [
      ExportItemModel(
        label: "Share",
        subtitle: "Share your image with people or open it in another app",
        iconData: Icons.share,
        type: ExportType.Share,
      ),
      ExportItemModel(
        label: "Save",
        subtitle: "Create a copy of your photo.",
        iconData: Icons.save,
        type: ExportType.Save,
      ),
      ExportItemModel(
        label: "Export",
        subtitle: "Create a copy of your photo. Chane sizing format & quanlity in Settings menu.",
        iconData: Icons.image,
        type: ExportType.Export,
      ),
      ExportItemModel(
        label: "Export As",
        subtitle: "Create a copy of a selected folder.",
        iconData: Icons.folder,
        type: ExportType.ExportAs,
      ),
    ];
  }
}

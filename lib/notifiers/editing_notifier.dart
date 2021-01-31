import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/export_item_model.dart';
import 'package:flutter_image_editor/models/styles_item_model.dart';
import 'package:flutter_image_editor/models/tools_item_model.dart';
import 'package:flutter_image_editor/types/styles_type.dart';
import 'package:hooks_riverpod/all.dart';

class EditingNotifier extends ChangeNotifier {
  List<ToolsItemModel> _toolsItems = ToolsItemModel.tools;
  List<ExportItemModel> _exportItems = ExportItemModel.items;
  List<StylesItemModel> _stylesItems = StylesItemModel.items;

  bool _isZooming = false;

  EditingNotifier() {
    _toolsItems = ToolsItemModel.tools;
    _exportItems = ExportItemModel.items;
    _stylesItems = StylesItemModel.items;
  }

  StyleType _currentStyleType;
  int _currentIndex;

  setCurrentIndex(int index) {
    this._currentIndex = index;
    notifyListeners();
  }

  setCurrentStyleType(StyleType type) {
    this._currentStyleType = type;
    notifyListeners();
  }

  onModalClose() {
    setCurrentIndex(null);
    setCurrentStyleType(null);
  }

  setIsZoom(bool isZooming) {
    this._isZooming = isZooming;
    notifyListeners();
  }

  bool get isZooming => this._isZooming;
  int get currentIndex => this._currentIndex;
  List get toolsItems => this._toolsItems;
  List get exportItems => this._exportItems;
  List get stylesItems => this._stylesItems;
  StyleType get currentStyleType => this._currentStyleType;
}

final editingNotifier = ChangeNotifierProvider<EditingNotifier>((ref) {
  var notifier = EditingNotifier();
  return notifier;
});

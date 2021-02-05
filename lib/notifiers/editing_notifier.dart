import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/models/export_item_model.dart';
import 'package:flutter_image_editor/models/styles_item_model.dart';
import 'package:flutter_image_editor/models/tools_item_model.dart';
import 'package:flutter_image_editor/models/tune_type_model.dart';
import 'package:flutter_image_editor/types/styles_type.dart';
import 'package:hooks_riverpod/all.dart';

class EditingNotifier extends ChangeNotifier {
  final List<TuneTypeModel> tuneTypeList = TuneTypeModel.tuneTypesList;
  final List<ToolsItemModel> _toolsItems = ToolsItemModel.tools;
  final List<ExportItemModel> _exportItems = ExportItemModel.items;
  final List<StylesItemModel> _stylesItems = StylesItemModel.items;

  /// This refer to current [BottomNav]
  int _currentIndex;

  DragUpdateDetails _onHorizontalDragUpdateDetails;
  DragUpdateDetails _onVerticalDragUpdateDetails;

  bool _isZooming = false;
  StyleType _currentStyleType;

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

  double _tuneTypeValue = 0;
  double _tuneTypeValueAsPercentage = 0;

  ///This were called in `onHorizontalDragUpdate()`
  void calcTuneTypeValue(double primaryDelta, double width) {
    var newValue = this._tuneTypeValue + primaryDelta;

    /// In TuneImage screen, we use tuneTypeValue to animate to meter on top (above at AppBar).
    /// we use halfWidth since our meter is divided to 2 containers which are nagative and positive.
    double halfWidth = width / 2;
    if (newValue < halfWidth && newValue > -halfWidth) {
      this._tuneTypeValue = newValue;
      this._tuneTypeValueAsPercentage = newValue * 100 / halfWidth;

      this.tuneTypeList[this.currentTuneTypeIndex].setValue(this._tuneTypeValue);
      this.tuneTypeList[this.currentTuneTypeIndex].setValueAsPercentage(this._tuneTypeValueAsPercentage);

      notifyListeners();
    }
  }

  double _popScroll = 0;
  bool _isPopScrolling = false;
  int _currentTuneTypeIndex = 0;

  ///This were called in `onVerticalDragUpdate()`
  void calcTuneTypeScroll(double primaryDelta) {
    int typeLength = tuneTypeList.length;
    var objectHeight = ConfigConstant.objectHeight2;
    var margin = ConfigConstant.margin2;

    double height = objectHeight * typeLength;
    height = (objectHeight * typeLength - margin * 2 - 20) / 2;

    /// In TuneImage screen, we use popScroll to
    /// animated tune type container on scrolling
    /// using `transform` which is something like this:
    /// `offset: Offset(0, editNotifier.popScroll),`
    /// -----------------------------------------
    var newPopScroll = this._popScroll + primaryDelta;
    if (newPopScroll < height && newPopScroll > -height) {
      this._popScroll = newPopScroll;
      print("popScroll" + this._popScroll.toString());
      notifyListeners();
    }

    /// Check if value is between this max and min
    /// => change current tune type index
    for (int i = 0; i < this.tuneTypeList.length; i++) {
      var max = height - objectHeight * i + 8;
      var min = height - (i + 1) * objectHeight - 8;
      if (newPopScroll < max && newPopScroll > min) {
        this._currentTuneTypeIndex = i;
      }
    }
  }

  void onHorizontalDragDetail(DragUpdateDetails detail) {
    this._onHorizontalDragUpdateDetails = detail;
    notifyListeners();
  }

  void onVerticalDragDetail(DragUpdateDetails detail) {
    this._onVerticalDragUpdateDetails = detail;
    notifyListeners();
  }

  void onVerticalDragEnd(DragEndDetails detail) {
    this._isPopScrolling = false;
    notifyListeners();
  }

  void onVerticalDragStart(DragStartDetails detail) {
    this._isPopScrolling = true;
    notifyListeners();
  }

  void setPopScrolling(bool val) {
    this._isPopScrolling = val;
    notifyListeners();
  }

  bool get isZooming => this._isZooming;
  bool get isColorPicking => false;
  double get tuneTypeValue => this._tuneTypeValue;
  double get popScroll => this._popScroll;
  bool get isPopScrolling => this._isPopScrolling;
  double get tuneTypeValueAsPercentage => this._tuneTypeValueAsPercentage;
  int get currentIndex => this._currentIndex;
  int get currentTuneTypeIndex => this._currentTuneTypeIndex;
  List get toolsItems => this._toolsItems;
  List get exportItems => this._exportItems;
  List get stylesItems => this._stylesItems;
  StyleType get currentStyleType => this._currentStyleType;
  DragUpdateDetails get onHorizontalDragUpdateDetails => this._onHorizontalDragUpdateDetails;
  DragUpdateDetails get onVerticalDragUpdateDetails => this._onVerticalDragUpdateDetails;
}

final editingNotifier = ChangeNotifierProvider<EditingNotifier>((ref) {
  var notifier = EditingNotifier();
  return notifier;
});

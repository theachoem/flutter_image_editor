import 'package:flutter/material.dart';
import 'package:flutter_image_editor/models/tune_type_model.dart';

class TuneData {
  final List<TuneTypeModel> tuneTypeList;
  int currentTuneTypeIndex;
  bool isPopScrolling = false;
  double tuneTypeValue;
  double popScroll;
  TuneData({@required this.tuneTypeList, this.isPopScrolling, this.currentTuneTypeIndex = 0, this.tuneTypeValue = 0});
}

class TuneNotifier extends ValueNotifier<TuneData> {
  TuneNotifier(TuneData value) : super(value);

  int get tuneTypeValueAsPercent {
    return value.tuneTypeList[value.currentTuneTypeIndex].valueAsPercent.roundToDouble().toInt();
  }

  String get currentTuneTypeLabel {
    return value.tuneTypeList[value.currentTuneTypeIndex].label;
  }

  void setScale(double scale) {
    notifyListeners();
  }

  void setScaleUpdateDetail(ScaleUpdateDetails scaleDetail) {
    notifyListeners();
  }

  void setIsPopScrolling(bool isScrolling) {
    value.isPopScrolling = isScrolling;
    notifyListeners();
  }
}

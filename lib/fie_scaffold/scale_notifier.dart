import 'package:flutter/material.dart';

class ScaleData {
  double scale;
  ScaleUpdateDetails scaleDetail;
}

class ScaleNotifier extends ValueNotifier<ScaleData> {
  ScaleNotifier(ScaleData value) : super(value);

  void setScale(double scale) {
    value.scale = scale;
    notifyListeners();
  }

  void setScaleUpdateDetail(ScaleUpdateDetails scaleDetail) {
    value.scaleDetail = scaleDetail;
    notifyListeners();
  }
}

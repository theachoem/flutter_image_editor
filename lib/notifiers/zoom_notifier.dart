import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class ZoomNotifier extends ChangeNotifier {
  double _scale;
  ScaleUpdateDetails _details;

  ZoomNotifier(TransformationController controller) {
    controller.addListener(() {
      this._scale = controller.value.storage[10];
      // print("ROTATION");
      // print(controller.value.getRotation());
      notifyListeners();
    });
  }

  setDragDetail(ScaleUpdateDetails details) {
    this._details = details;
    notifyListeners();
  }

  double get scale => this._scale;
  ScaleUpdateDetails get details => this._details;
}

final zoomNotifier = ChangeNotifierProvider.family<ZoomNotifier, TransformationController>(
  (ref, transformationController) {
    var notifier = ZoomNotifier(transformationController);
    return notifier;
  },
);

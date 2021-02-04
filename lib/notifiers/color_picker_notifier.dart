import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:image/image.dart' as img;

class ColorPickerNotifier extends ChangeNotifier {
  Color _color;
  Offset _globalPosition;
  img.Image _image;

  ColorPickerNotifier() {
    _color = Colors.amber;
  }

  setColor(Color _color) {
    this._color = _color;
    notifyListeners();
  }

  Color get color => this._color;
  Offset get globalPosition => this._globalPosition;
  img.Image get image => this._image;

  void setOffset(Offset details) {
    _globalPosition = details;
    notifyListeners();
  }

  void setImage(img.Image _image) {
    this._image = _image;
  }
}

final colorPickerNotifier = ChangeNotifierProvider<ColorPickerNotifier>((ref) {
  var notifier = ColorPickerNotifier();
  return notifier;
});

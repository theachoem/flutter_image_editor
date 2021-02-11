import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_editor/helper/app_helper.dart';
import 'package:flutter_image_editor/models/fie_image_model.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:image_picker/image_picker.dart';

class ImageNotifier extends ChangeNotifier {
  File _image;
  final picker = ImagePicker();
  bool requestStatus;
  Uint8List _readFile;

  DateTime _lastModify;
  DateTime _lastAccessed;

  FieImageModel _imageDecode;

  Future pickAnImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setData();
      requestStatus = true;
    } else {
      requestStatus = false;
      print('No image selected.');
    }
    notifyListeners();
  }

  setImageFile(File image) {
    if (this._image != image) this._image = image;
    notifyListeners();
  }

  Future setData() async {
    _lastModify = await _image.lastModified();
    _lastAccessed = await _image.lastAccessed();
    _imageDecode = AppHelper.imageDecode(image.path);
    _readFile = await _image.readAsBytes();
  }

  File get image => this._image;
  FieImageModel get imageDecode => this._imageDecode;
  DateTime get lastModify => this._lastModify;
  DateTime get lastAccessed => this._lastAccessed;
  Uint8List get readFile => this._readFile;
}

final imageNotifier = ChangeNotifierProvider<ImageNotifier>((ref) {
  var notifier = ImageNotifier();
  return notifier;
});

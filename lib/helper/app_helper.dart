import 'package:date_format/date_format.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter_image_editor/models/fie_image_model.dart';
import 'package:image/image.dart';
import 'dart:io';

class AppHelper {
  static fileSize(int lengthInBytes, [int round = 2]) {
    return filesize(lengthInBytes, round);
  }

  static FieImageModel imageDecode(String path) {
    Image image = decodeImage(File(path).readAsBytesSync());
    return FieImageModel.from(image);
  }

  static String dateFormate(DateTime date) {
    return formatDate(date, [yyyy, ' ', MM, ' ', dd, ', ', hh, ':', nn]);
  }
}

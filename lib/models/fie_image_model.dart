import 'package:image/image.dart';

class FieImageModel extends Image {
  FieImageModel(int width, int height) : super(width, height);
  FieImageModel.from(Image other) : super.from(other);
  FieImageModel.fromBytes(int width, int height, List<int> bytes) : super.fromBytes(width, height, bytes);
  FieImageModel.rgb(int width, int height) : super.rgb(width, height);
}

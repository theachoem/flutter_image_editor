import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/helper/app_helper.dart';
import 'package:flutter_image_editor/mixins/bottom_nav_mixin.dart';
import 'package:flutter_image_editor/mixins/navigator_mixin.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/models/styles_item_model.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/types/styles_type.dart';
import 'package:flutter_image_editor/widgets/fie_bottom_nav.dart';
import 'package:flutter_image_editor/widgets/style_list_widget.dart';
import 'package:image_crop/image_crop.dart';
import 'package:hooks_riverpod/all.dart';

class CropScreen extends StatefulWidget {
  const CropScreen({Key key}) : super(key: key);

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> with BottomNavMixin, NavigatorMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool isShowingBottomSheet = false;

  Future<void> cropImage(File imagePath, Function(File) onCroped) async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) return;

    var image = AppHelper.imageDecode(imagePath.path);

    /// picture will have higher resolution with bigger `preferredSize`
    final sample = await ImageCrop.sampleImage(
      file: imagePath,
      preferredSize: (image.width > image.height ? image.width : image.height / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();
    // this.path?.delete();
    // setState(() {
    //   this.path = file;
    // });

    onCroped(file);
  }

  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    var imgNotifier = context.read(imageNotifier);
    var editNotifier = context.read(editingNotifier);

    // final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomNavHeight = MediaQuery.of(context).padding.bottom;

    var image = AppHelper.imageDecode(imgNotifier.image.path);
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          body: Center(
            child: AspectRatio(
              aspectRatio: image.width / image.height,
              child: Crop(
                key: cropKey,
                image: FileImage(imgNotifier.image),
              ),
            ),
          ),
        ),
        positionedBottomNav(
          context: context,
          bottomNavHeight: bottomNavHeight,
          child: FieBottomNav(
            scaffoldKey: _scaffoldKey,
            editingNotifier: editNotifier,
            afterPop: () {
              editNotifier.setTuneTypeValue(0);
            },
            onSaved: () async {
              setState(() {
                loading = true;
              });
              await cropImage(imgNotifier.image, (file) {
                imgNotifier.setImageFile(file);
              });
              setState(() {
                loading = false;
              });
            },
            centeredItems: [
              BottomNavButtonModel(
                type: BottomNavsType.Adjust,
                label: 'Adjust',
                iconData: Icons.restore,
                onPressed: () {
                  editNotifier.setPopScrolling(!editNotifier.isPopScrolling);
                },
              ),
              BottomNavButtonModel(
                type: BottomNavsType.AutoAdjust,
                label: 'Auto-adjust',
                iconData: Icons.aspect_ratio_sharp,
                onPressed: () async {
                  var objectHeight = ConfigConstant.objectHeight4 + ConfigConstant.margin1 * 3;

                  if (isShowingBottomSheet) {
                    this.isShowingBottomSheet = false;
                    closeModal(context);
                  } else {
                    this.isShowingBottomSheet = true;
                    showStylesBottomSheet(
                      scaffoldKey: _scaffoldKey,
                      objectHeight: objectHeight,
                      margin: EdgeInsets.only(bottom: bottomNavHeight + ConfigConstant.toolbarHeight + 1),
                      child: StylesListWidget(
                        onPressed: (type) {},
                        items: [
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "Free",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "Original",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "Square",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "DIN",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "3:2",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "4:3",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "5:4",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "7:5",
                          ),
                          StylesItemModel(
                            type: StyleType.Accentuate,
                            label: "16:9",
                          ),
                        ],
                      ),
                    );
                  }
                  // await cropImage(imgNotifier.image);
                  // imgNotifier.setImageFile(this.path);
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: this.loading ? 1 : 0,
              duration: ConfigConstant.duration,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

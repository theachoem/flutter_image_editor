//////////////////////////////
//
// 2019, roipeker.com
// screencast - demo simple image:
// https://youtu.be/EJyRH4_pY8I
//
// screencast - demo snapshot:
// https://youtu.be/-LxPcL7T61E
//
//////////////////////////////
///
/// NOTE: I did customize it,
/// But origin code here: https://gist.github.com/roipeker/9315aa25301f5c0362caaebd15876c2f

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/mixins/bottom_nav_mixin.dart';
import 'package:flutter_image_editor/screens/image_view.dart';
import 'package:flutter_image_editor/widgets/meter_app_bar.dart';
import 'package:flutter_image_editor/mixins/snack_bar_mixin.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/notifiers/color_picker_notifier.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/fie_bottom_nav.dart';
import 'package:flutter_image_editor/widgets/fire_text_button.dart';
import 'package:flutter_image_editor/widgets/tune_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle, rootBundle;

class ColorPickerWidget extends ConsumerWidget with BottomNavMixin, SnackBarMixin {
  final GlobalKey imageKey = GlobalKey();
  final GlobalKey paintKey = GlobalKey();

  @override
  Widget build(BuildContext context, reader) {
    // final bottomNavHeight = MediaQuery.of(context).padding.bottom;

    final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

    var imgNotifier = reader(imageNotifier);
    var colorPickNotifier = reader(colorPickerNotifier);
    var editNotifier = reader(editingNotifier);

    Color selectedColor = colorPickNotifier.color ?? Colors.green;
    var tuneTypeValueAsPercent =
        editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].valueAsPercent.roundToDouble().toInt();
    var currentTuneTypeLabel = editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].label;

    Size size = MediaQuery.of(context).size;

    var colorPopOffset = colorPickNotifier.globalPosition ??
        Offset(
          size.width / 2,
          size.height / 2,
        );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Container(
      color: Theme.of(context).primaryColor,
      child: WillPopScope(
        onWillPop: () {
          editNotifier.setTuneTypeValue(null);
          return;
        },
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: MeterAppBar(
              title: "$currentTuneTypeLabel $tuneTypeValueAsPercent",
              tuneValue: editNotifier.tuneTypeValue ?? 0,
            ),
            body: Stack(
              children: <Widget>[
                RepaintBoundary(
                  key: paintKey,
                  child: ImageView(
                    imageKey: imageKey,
                    onPickColor: editNotifier.isColorPicking
                        ? (details) {
                            colorPickNotifier.setOffset(details.globalPosition);
                            searchPixel(
                              details.globalPosition,
                              imgNotifier.image.path,
                              colorPickNotifier,
                            );
                          }
                        : null,
                  ),
                ),
                if (!editNotifier.isColorPicking) TuneWidget(editingNotifier: editNotifier),
                if (editNotifier.isColorPicking) buildColorFloatingBox(colorPopOffset, selectedColor),
                if (editNotifier.isColorPicking) buildColorTextBox(colorPopOffset, selectedColor),
                positionedBottomNav(
                  context: context,
                  bottomNavHeight: 0,
                  child: buildFieBottomNav(_scaffoldKey, editNotifier),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FieBottomNav buildFieBottomNav(GlobalKey<State<StatefulWidget>> _scaffoldKey, EditingNotifier editNotifier) {
    return FieBottomNav(
      onSaved: () {},
      afterPop: () {
        editNotifier.setTuneTypeValue(null);
      },
      scaffoldKey: _scaffoldKey,
      editingNotifier: editNotifier,
      selectedIndex: editNotifier.isColorPicking
          ? 2
          : editNotifier.isPopScrolling
              ? 1
              : null,
      centeredItems: [
        BottomNavButtonModel(
          type: BottomNavsType.Adjust,
          label: 'Auto',
          iconData: Icons.wb_auto,
          onPressed: () {},
        ),
        BottomNavButtonModel(
          type: BottomNavsType.AutoAdjust,
          label: 'Adjust',
          iconData: Icons.tune,
          onPressed: () {
            editNotifier.setPopScrolling(!editNotifier.isPopScrolling);
          },
        ),
        BottomNavButtonModel(
          type: BottomNavsType.AutoAdjust,
          label: 'Colour Picker',
          iconData: Icons.colorize_sharp,
          onPressed: () {
            editNotifier.toggleIsColorPicking();
          },
        ),
      ],
    );
  }

  Transform buildColorTextBox(Offset colorPopOffset, Color selectedColor) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          colorPopOffset.dx,
          colorPopOffset.dy + 20,
        ),
      child: Text(
        selectedColor.toString().toUpperCase().replaceAll("COLOR(0X", "").replaceAll(")", ""),
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }

  Transform buildColorFloatingBox(Offset colorPopOffset, Color selectedColor) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          colorPopOffset.dx - 95,
          colorPopOffset.dy - 95,
        ),
      child: Container(
        margin: EdgeInsets.all(70),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedColor,
          border: Border.all(width: 2.0, color: Colors.white),
          boxShadow: ConfigConstant.boxShadow,
        ),
      ),
    );
  }

  void searchPixel(Offset globalPosition, String imagePath, ColorPickerNotifier colorPickNotifier) async {
    if (colorPickNotifier.image == null) {
      await (loadImageBundleBytes(imagePath, colorPickNotifier));
    }
    _calculatePixel(globalPosition, colorPickNotifier);
  }

  void _calculatePixel(Offset globalPosition, ColorPickerNotifier colorPickNotifier) {
    RenderBox box = imageKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    double widgetScale = box.size.width / colorPickNotifier.image.width;
    print(py);
    px = (px / widgetScale);
    py = (py / widgetScale);

    int pixel32 = colorPickNotifier.image.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    colorPickNotifier.setColor(Color(hex));
  }

  Future<void> loadImageBundleBytes(String imagePath, ColorPickerNotifier colorPickNotifier) async {
    ByteData imageBytes = await rootBundle.load(imagePath);
    setImageBytes(imageBytes, colorPickNotifier);
  }

  void setImageBytes(ByteData imageBytes, ColorPickerNotifier colorPickNotifier) {
    List<int> values = imageBytes.buffer.asUint8List();
    colorPickNotifier.setImage(null);
    colorPickNotifier.setImage(img.decodeImage(values));
  }

  Widget buildMainBottomNavigation({
    BuildContext context,
    EditingNotifier editingNotifier,
    double bottomNavHeight,
    GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    return positionedBottomNav(
      context: context,
      bottomNavHeight: bottomNavHeight,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            FieButton.icon(
              item: BottomNavButtonModel(
                type: BottomNavsType.Cancels,
                label: 'Cancels',
                iconData: Icons.clear,
              ),
              isSelected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Spacer(),
            FieButton.icon(
              item: BottomNavButtonModel(
                type: BottomNavsType.Adjust,
                label: 'Adjust',
                iconData: Icons.tune,
              ),
              isSelected: true,
              onTap: () {
                if (editingNotifier != null) editingNotifier.setPopScrolling(!editingNotifier.isPopScrolling);
              },
            ),
            FieButton.icon(
              item: BottomNavButtonModel(
                type: BottomNavsType.AutoAdjust,
                label: 'Auto-adjust',
                iconData: Icons.auto_fix_high,
              ),
              isSelected: true,
              onTap: () {
                showFieSnackBar(
                  scaffoldKey: scaffoldKey,
                  bottomNavHeight: bottomNavHeight,
                  label: "Auto-adjusted",
                  actionLabel: "UNDO",
                  onPressed: () {},
                );
              },
            ),
            Spacer(),
            FieButton.icon(
              item: BottomNavButtonModel(
                type: BottomNavsType.Apply,
                label: 'Apply',
                iconData: Icons.check,
              ),
              isSelected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_editor/fie_scaffold/scale_notifier.dart';
import 'package:flutter_image_editor/fie_scaffold/tune_notifier.dart';
import 'package:flutter_image_editor/helper/app_helper.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/models/fie_image_model.dart';
import 'package:flutter_image_editor/models/tune_type_model.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/fire_text_button.dart';
import 'package:flutter_image_editor/widgets/meter_app_bar.dart';

class FieScaffold extends StatefulWidget {
  FieScaffold({Key key, this.image}) : super(key: key);
  final File image;

  @override
  _FieScaffoldState createState() => _FieScaffoldState();
}

const double marginHeight1 = 8.0;
const double marginHeight2 = 16.0;

const double objectHeight1 = 48.0;
const double objectHeight2 = 54.0;
const double objectHeight3 = 72.0;
const double objectHeight4 = 96.0;
const double objectHeight5 = 120.0;

const Duration duration = const Duration(milliseconds: 350);
const Duration fadeDuration = const Duration(milliseconds: 150);

class _FieScaffoldState extends State<FieScaffold> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TransformationController transformationController;

  int currentIndex = 0;
  bool isZooming = false;

  FieImageModel imageDecode;

  ScaleNotifier fieNotifier = ScaleNotifier(ScaleData());
  TuneNotifier tuneNotifier = TuneNotifier(TuneData(tuneTypeList: TuneTypeModel.tuneTypesList));

  @override
  void initState() {
    imageDecode = AppHelper.imageDecode(widget.image.path);
    transformationController = TransformationController()
      ..addListener(() {
        fieNotifier.value.scale = transformationController.value.storage[10];
      });
    super.initState();
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  void setScaleUpdateDetail(ScaleUpdateDetails _details) {
    fieNotifier.setScaleUpdateDetail(_details);
  }

  void setIsZoom(bool value) {
    this.isZooming = value;
  }

  List<BottomNavButtonModel> get centeredItems {
    return [
      BottomNavButtonModel(
        type: BottomNavsType.Adjust,
        label: 'Adjust',
        iconData: Icons.tune,
        onPressed: () {},
      ),
      BottomNavButtonModel(
        type: BottomNavsType.AutoAdjust,
        label: 'Auto-adjust',
        iconData: Icons.auto_fix_high,
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final bottomNavHeight = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            key: scaffoldKey,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ValueListenableBuilder(
                valueListenable: tuneNotifier,
                builder: (context, TuneData data, child) {
                  return MeterAppBar(
                    title: "${tuneNotifier.currentTuneTypeLabel}" + " " + "${tuneNotifier.tuneTypeValueAsPercent}",
                    tuneValue: data.tuneTypeValue,
                  );
                },
              ),
            ),
            body: buildBody(),
          ),
          buildSmallMap(),
          buildBottomNavigation(context),
        ],
      ),
    );
  }

  Positioned buildBottomNavigation(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Material(
          elevation: 0,
          color: Theme.of(context).primaryColor,
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
                  onTap: () async {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                for (var i = 0; i < centeredItems.length; i++)
                  FieButton.icon(
                    item: centeredItems[i],
                    isSelected: currentIndex == i,
                    onTap: () {
                      setState(() => currentIndex = i);
                      centeredItems[i].onPressed();
                    },
                  ),
                Spacer(),
                FieButton.icon(
                  item: BottomNavButtonModel(
                    type: BottomNavsType.Apply,
                    label: 'Apply',
                    iconData: Icons.check,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildTuneTypeContainerList({
    double width,
    BuildContext context,
  }) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: IgnorePointer(
          child: ValueListenableBuilder(
              valueListenable: tuneNotifier,
              builder: (context, TuneData data, child) {
                return AnimatedOpacity(
                  opacity: data.isPopScrolling ? 1 : 0,
                  duration: fadeDuration,
                  child: Transform.translate(
                    offset: Offset(0, data.popScroll),
                    child: Container(
                      width: width * 0.75,
                      constraints: const BoxConstraints(maxWidth: 360, minWidth: 250),
                      alignment: Alignment.center,
                      child: Wrap(
                        children: [
                          Container(
                            height: marginHeight2,
                            color: Theme.of(context).primaryColor,
                            width: double.infinity,
                            child: Transform.translate(
                              offset: Offset(0, -4),
                              child: const Icon(Icons.arrow_drop_up),
                            ),
                          ),
                          Wrap(
                            children: List.generate(
                              data.tuneTypeList.length,
                              (index) {
                                var tuneItem = data.tuneTypeList[index];
                                var valueAsPercent = tuneItem.valueAsPercent.roundToDouble().toInt();
                                return Container(
                                  height: objectHeight2,
                                  child: Material(
                                    color: Theme.of(context).primaryColor,
                                    child: ListTile(
                                      title: Text(tuneItem.label),
                                      trailing: Text("$valueAsPercent"),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: marginHeight2,
                            color: Theme.of(context).primaryColor,
                            width: double.infinity,
                            child: Transform.translate(
                              offset: const Offset(0, -4),
                              child: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Positioned buildSmallMap() {
    double imageWidth = 120;
    bool decodeNotNull = imageDecode != null && imageDecode.height != null && imageDecode.width != null;
    double imageHeight = decodeNotNull ? imageWidth * imageDecode.height / imageDecode.width : 0;
    return Positioned(
      left: marginHeight2,
      bottom: kToolbarHeight * 2,
      child: ValueListenableBuilder(
        valueListenable: fieNotifier,
        builder: (context, data, child) {
          bool zooming = imageHeight != null && data.scale != null && data.scale > 1 && data.scaleDetail != null;
          return IgnorePointer(
            ignoring: !zooming,
            child: AnimatedOpacity(
              duration: fadeDuration,
              opacity: zooming ? 1 : 0,
              child: Container(
                width: 120,
                height: imageHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: AspectRatio(
                  aspectRatio: data.scale != null ? imageWidth / data.scale / imageHeight : 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody() {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(objectHeight5),
      color: Colors.black.withOpacity(0.1),
    );
    var margin = EdgeInsets.fromLTRB(
      marginHeight1,
      0,
      marginHeight1,
      currentIndex == 0 ? objectHeight4 : 0,
    );
    return GestureDetector(
      child: Center(
        child: AnimatedContainer(
          duration: duration,
          decoration: boxDecoration,
          curve: Curves.easeInQuad,
          margin: margin,
          child: InteractiveViewer(
            transformationController: transformationController,
            onInteractionStart: (ScaleStartDetails detail) {
              setIsZoom(true);
            },
            onInteractionEnd: (ScaleEndDetails detail) {
              setIsZoom(false);
            },
            onInteractionUpdate: (ScaleUpdateDetails detail) {
              setScaleUpdateDetail(detail);
            },
            child: Image.file(
              widget.image,
            ),
          ),
        ),
      ),
    );
  }
}

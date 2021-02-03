import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/mixins/bottom_nav_mixin.dart';
import 'package:flutter_image_editor/mixins/snack_bar_mixin.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:flutter_image_editor/screens/image_view.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/fire_text_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TuneImageScreen extends StatelessWidget with BottomNavMixin, SnackBarMixin {
  const TuneImageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavHeight = MediaQuery.of(context).padding.bottom;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    final width = MediaQuery.of(context).size.width;
    final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

    return Consumer(
      builder: (context, reader, child) {
        var editNotifier = reader(editingNotifier);
        var imgNotifier = reader(imageNotifier);
        var tuneTypeValueAsPercent =
            editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].valueAsPercent.roundToDouble().toInt();
        var currentTuneTypeLabel = editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].label;

        var meterStack = Stack(
          children: [
            Container(
              color: Colors.black38,
              width: width,
              height: statusBarHeight + 4.0,
            ),
            buildMeter(
              width: width,
              context: context,
              editNotifier: editNotifier,
            ),
          ],
        );

        var actionButton = [
          IconButton(
            icon: Icon(Icons.flip),
            onPressed: () {},
          )
        ];

        var appBar = AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          flexibleSpace: meterStack,
          title: Text(
            '$currentTuneTypeLabel $tuneTypeValueAsPercent',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: actionButton,
        );

        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              appBar: appBar,
              body: ImageView(
                imgNotifier: imgNotifier,
                editNotifier: editNotifier,
              ),
            ),
            buildTuneTypeContainerList(
              editNotifier: editNotifier,
              width: width,
              context: context,
            ),
            buildCurrentTuneTypeContainer(
              editNotifier: editNotifier,
              width: width,
              context: context,
              currentTuneTypeLabel: currentTuneTypeLabel,
              tuneTypeValueAsPercent: tuneTypeValueAsPercent,
            ),
            buildMainBottomNavigation(
              context: context,
              editingNotifier: editNotifier,
              bottomNavHeight: bottomNavHeight,
              scaffoldKey: _scaffoldKey,
            ),
          ],
        );
      },
    );
  }

  Positioned buildCurrentTuneTypeContainer({
    EditingNotifier editNotifier,
    double width,
    BuildContext context,
    String currentTuneTypeLabel,
    int tuneTypeValueAsPercent,
  }) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: editNotifier.isPopScrolling ? 1 : 0,
          duration: ConfigConstant.fadeDuration,
          child: Center(
            child: Container(
              width: width * 0.75,
              height: ConfigConstant.objectHeight2,
              alignment: Alignment.center,
              child: Material(
                color: Theme.of(context).accentColor,
                child: ListTile(
                  title: Text(
                    "$currentTuneTypeLabel",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '$tuneTypeValueAsPercent',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildTuneTypeContainerList({
    EditingNotifier editNotifier,
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
          child: AnimatedOpacity(
            opacity: editNotifier.isPopScrolling ? 1 : 0,
            duration: ConfigConstant.fadeDuration,
            child: Transform.translate(
              offset: Offset(0, editNotifier.popScroll),
              child: Container(
                width: width * 0.75,
                constraints: const BoxConstraints(maxWidth: 360, minWidth: 250),
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    Container(
                      height: ConfigConstant.margin2,
                      color: Theme.of(context).primaryColor,
                      width: double.infinity,
                      child: Transform.translate(
                        offset: Offset(0, -4),
                        child: const Icon(Icons.arrow_drop_up),
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                        editNotifier.tuneTypeList.length,
                        (index) {
                          var tuneItem = editNotifier.tuneTypeList[index];
                          var valueAsPercent = tuneItem.valueAsPercent.roundToDouble().toInt();
                          return Container(
                            height: ConfigConstant.objectHeight2,
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
                      height: ConfigConstant.margin2,
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
          ),
        ),
      ),
    );
  }

  Widget buildMeter({
    double width,
    BuildContext context,
    EditingNotifier editNotifier,
  }) {
    final meters = 4;
    final meterHeight = 4.0;

    // var tuneTypeValue = editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].value;
    var tuneTypeValue = editNotifier.tuneTypeValue;

    return SafeArea(
      child: Container(
        alignment: Alignment.bottomCenter,
        height: meterHeight * 2.5,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: width / 2,
                  height: meterHeight * 2.5,
                  alignment: Alignment.centerRight,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: Container(
                    color: Theme.of(context).accentColor,
                    width: tuneTypeValue < 0 ? -tuneTypeValue : 0,
                    height: meterHeight,
                  ),
                ),
                Container(
                  width: width / 2,
                  height: meterHeight * 2.5,
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: Container(
                    color: Theme.of(context).accentColor,
                    width: tuneTypeValue > 0 ? tuneTypeValue : 0,
                    height: meterHeight,
                  ),
                ),
              ],
            ),
            buildRuler(meters, width, context, meterHeight),
          ],
        ),
      ),
    );
  }

  Row buildRuler(int meters, double width, BuildContext context, double meterHeight) {
    return Row(
      children: List.generate(
        meters,
        (index) {
          var isCenter = index + 1 == meters / 2;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width / meters - 1,
                height: meterHeight,
              ),
              Transform.translate(
                offset: Offset(0, isCenter ? 3 : 0),
                child: Container(
                  width: 1,
                  height: isCenter ? meterHeight * 2.5 : meterHeight,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          );
        },
      ),
    );
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
                editingNotifier.setPopScrolling(!editingNotifier.isPopScrolling);
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

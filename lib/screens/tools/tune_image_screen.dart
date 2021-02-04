import 'package:flutter/material.dart';
import 'package:flutter_image_editor/mixins/bottom_nav_mixin.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/meter_app_bar.dart';
import 'package:flutter_image_editor/mixins/snack_bar_mixin.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/screens/image_view.dart';
import 'package:flutter_image_editor/widgets/fie_bottom_nav.dart';
import 'package:flutter_image_editor/widgets/tune_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TuneImageScreen extends StatelessWidget with BottomNavMixin, SnackBarMixin {
  const TuneImageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavHeight = MediaQuery.of(context).padding.bottom;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

    return Consumer(
      builder: (context, reader, child) {
        var editNotifier = reader(editingNotifier);
        var tuneTypeValueAsPercent =
            editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].valueAsPercent.roundToDouble().toInt();
        var currentTuneTypeLabel = editNotifier.tuneTypeList[editNotifier.currentTuneTypeIndex].label;

        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              appBar: MeterAppBar(
                title: "$currentTuneTypeLabel $tuneTypeValueAsPercent",
                statusBarHeight: statusBarHeight,
                tuneValue: editNotifier.tuneTypeValue,
              ),
              body: ImageView(),
            ),
            TuneWidget(),
            positionedBottomNav(
              context: context,
              bottomNavHeight: bottomNavHeight,
              child: FieBottomNav(
                scaffoldKey: _scaffoldKey,
                editingNotifier: editNotifier,
                onSaved: () {},
                centeredItems: [
                  BottomNavButtonModel(
                    type: BottomNavsType.Adjust,
                    label: 'Adjust',
                    iconData: Icons.tune,
                    onPressed: () {
                      editNotifier.setPopScrolling(!editNotifier.isPopScrolling);
                    },
                  ),
                  BottomNavButtonModel(
                    type: BottomNavsType.AutoAdjust,
                    label: 'Auto-adjust',
                    iconData: Icons.auto_fix_high,
                    onPressed: () {
                      showFieSnackBar(
                        scaffoldKey: _scaffoldKey,
                        bottomNavHeight: bottomNavHeight,
                        label: "Auto-adjusted",
                        actionLabel: "UNDO",
                        onPressed: () {},
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:hooks_riverpod/all.dart';

class TuneWidget extends ConsumerWidget {
  const TuneWidget({
    Key key,
    @required this.editingNotifier,
  }) : super(key: key);
  final EditingNotifier editingNotifier;

  @override
  Widget build(BuildContext context, reader) {
    var tuneTypeValueAsPercent =
        editingNotifier.tuneTypeList[editingNotifier.currentTuneTypeIndex].valueAsPercent.roundToDouble().toInt();
    var currentTuneTypeLabel = editingNotifier.tuneTypeList[editingNotifier.currentTuneTypeIndex].label;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        buildTuneTypeContainerList(
          width: width,
          context: context,
        ),
        buildCurrentTuneTypeContainer(
          editingNotifier: editingNotifier,
          width: width,
          context: context,
          currentTuneTypeLabel: currentTuneTypeLabel,
          tuneTypeValueAsPercent: tuneTypeValueAsPercent,
        ),
      ],
    );
  }

  Positioned buildCurrentTuneTypeContainer({
    EditingNotifier editingNotifier,
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
          opacity: editingNotifier.isPopScrolling ? 1 : 0,
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
            opacity: editingNotifier.isPopScrolling ? 1 : 0,
            duration: ConfigConstant.fadeDuration,
            child: Transform.translate(
              offset: Offset(0, editingNotifier.popScroll),
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
                        editingNotifier.tuneTypeList.length,
                        (index) {
                          var tuneItem = editingNotifier.tuneTypeList[index];
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
}

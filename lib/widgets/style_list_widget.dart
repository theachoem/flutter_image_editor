import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/models/styles_item_model.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/types/styles_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class StylesListWidget extends StatefulWidget {
  StylesListWidget({Key key, @required this.items, @required this.onPressed}) : super(key: key);
  final List<StylesItemModel> items;
  final Function(StyleType) onPressed;

  @override
  _StylesListWidgetState createState() => _StylesListWidgetState();
}

class _StylesListWidgetState extends State<StylesListWidget> {
  AutoScrollController authScrollController;
  final double boxSize = ConfigConstant.objectHeight3;

  @override
  void initState() {
    authScrollController = AutoScrollController(initialScrollOffset: boxSize);
    super.initState();
  }

  @override
  void dispose() {
    authScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, reader, child) {
        var notifier = reader(editingNotifier);

        if (notifier.currentStyleType == null) {
          authScrollController.scrollToIndex(1, preferPosition: AutoScrollPosition.begin);
        }
        return ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          controller: authScrollController,
          children: List.generate(
            widget.items.length,
            (index) {
              var item = widget.items[index];
              return AutoScrollTag(
                key: ValueKey(index),
                controller: authScrollController,
                index: index,
                child: AspectRatio(
                  aspectRatio: 0.7,
                  child: buildStyleButton(notifier, item, index),
                ),
              );
            },
          ),
        );
      },
    );
  }

  FlatButton buildStyleButton(EditingNotifier notifier, StylesItemModel item, int index) {
    bool isSelected = notifier.currentStyleType != null && item.type == notifier.currentStyleType;
    var style = Theme.of(context).textTheme.caption.copyWith(
          color: isSelected ? Theme.of(context).accentColor : null,
        );
    if (item.type == StyleType.Current && notifier.currentStyleType == null) {
      return FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          widget.onPressed(item.type);
          authScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
        },
        child: Container(
          child: const SizedBox(height: ConfigConstant.margin2),
        ),
      );
    } else
      return FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          widget.onPressed(item.type);
          authScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
        },
        child: Column(
          children: [
            const SizedBox(height: ConfigConstant.margin2),
            Transform.translate(
              offset: Offset(0, isSelected ? -4 : 0),
              child: AnimatedContainer(
                duration: ConfigConstant.fadeDuration,
                width: isSelected ? boxSize + 8 : boxSize,
                height: isSelected ? boxSize + 8 : boxSize,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: ConfigConstant.margin1),
            Transform.translate(
              offset: Offset(0, isSelected ? -8.5 : 0),
              child: Text(
                item.label,
                style: style,
              ),
            ),
          ],
        ),
      );
  }
}

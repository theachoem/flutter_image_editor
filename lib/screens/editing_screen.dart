import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/mixins/bottom_nav_mixin.dart';
import 'package:flutter_image_editor/mixins/navigator_mixin.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/models/export_item_model.dart';
import 'package:flutter_image_editor/models/tools_item_model.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/screens/image_view.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/export_list_widget.dart';
import 'package:flutter_image_editor/widgets/fie_appbar.dart';
import 'package:flutter_image_editor/widgets/fire_text_button.dart';
import 'package:flutter_image_editor/widgets/style_list_widget.dart';
import 'package:flutter_image_editor/widgets/tools_gridview.dart';
import 'package:hooks_riverpod/all.dart';

class EditingScreen extends StatelessWidget with NavigatorMixin, BottomNavMixin {
  final List<BottomNavButtonModel> _bottomNavigationBar = BottomNavButtonModel.items;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomNavHeight = MediaQuery.of(context).padding.bottom;

    return Consumer(
      builder: (context, reader, child) {
        var editNotifier = reader(editingNotifier);

        return Stack(
          children: [
            Scaffold(
              key: scaffoldKey,
              extendBody: true,
              extendBodyBehindAppBar: true,
              appBar: FieAppBar(isEditing: true),
              body: ImageView(),
            ),
            positionedBottomNav(
              bottomNavHeight: bottomNavHeight,
              context: context,
              child: buildMainBottomNavigation(
                editingNotifier: editNotifier,
                bottomNavHeight: bottomNavHeight,
                statusBarHeight: statusBarHeight,
                context: context,
              ),
            ),
            buildOnStylingBottomNavigation(
              notifier: editNotifier,
              bottomNavHeight: bottomNavHeight,
              statusBarHeight: statusBarHeight,
              context: context,
            ),
          ],
        );
      },
    );
  }

  onBottomNavTapped(
    EditingNotifier notifier,
    BottomNavsType type, {
    @required BuildContext context,
    int index,
    double statusBarHeight,
    double bottomNavHeight,
  }) async {
    if (notifier.currentIndex == index) {
      closeModal(context);
      notifier.onModalClose();
      return;
    }
    notifier.setCurrentIndex(index);

    final height = MediaQuery.of(context).size.height;
    final initSize = 1 - (statusBarHeight + 100) / (height);
    final margin = EdgeInsets.only(
      bottom: bottomNavHeight + ConfigConstant.toolbarHeight + 1,
    );

    if (type == BottomNavsType.Styles) {
      var objectHeight = ConfigConstant.objectHeight4 + ConfigConstant.margin1 * 3;
      showStylesBottomSheet(
        margin,
        objectHeight,
      ).closed.whenComplete(() => notifier.onModalClose());
    }
    if (type == BottomNavsType.Tools) {
      showToolsBottomSheet(
        initSize,
        margin,
        statusBarHeight,
        notifier,
      ).closed.whenComplete(() => notifier.onModalClose());
    }
    if (type == BottomNavsType.Export) {
      showExportModalBottomSheet(
        context,
        margin,
        notifier,
      ).whenComplete(() => notifier.onModalClose());
    }
  }

  PersistentBottomSheetController showStylesBottomSheet(
    EdgeInsets margin,
    double objectHeight,
  ) {
    return scaffoldKey.currentState.showBottomSheet(
      (context) {
        return Container(
          margin: margin,
          height: objectHeight,
          color: Theme.of(context).primaryColor,
          child: StylesListWidget(),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }

  PersistentBottomSheetController showToolsBottomSheet(
    double initSize,
    EdgeInsets margin,
    double statusBarHeight,
    EditingNotifier notifier,
  ) {
    return scaffoldKey.currentState.showBottomSheet(
      (context) => DraggableScrollableSheet(
        initialChildSize: initSize,
        maxChildSize: 1,
        minChildSize: 0.5,
        builder: (context, controller) {
          return Container(
            color: Theme.of(context).primaryColor,
            margin: margin.copyWith(top: statusBarHeight),
            child: ToolsGridView(
              controller: controller,
              tools: notifier.toolsItems,
              onTap: (int index, ToolsItemModel item) {
                if (item.routeName != null) {
                  Navigator.pop(context);
                  notifier.setTuneItem(item.type);
                  Navigator.of(context).pushNamed(item.routeName);
                }
              },
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future showExportModalBottomSheet(
    BuildContext context,
    EdgeInsets margin,
    EditingNotifier notifier,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).primaryColor,
      builder: (context) {
        return ExportListWidget(
          exportItems: notifier.exportItems,
          onTap: (int index, ExportItemModel item) {
            print(index);
            print(item);
          },
        );
      },
    );
  }

  Widget buildMainBottomNavigation({
    EditingNotifier editingNotifier,
    double bottomNavHeight,
    double statusBarHeight,
    @required BuildContext context,
  }) {
    var itemsWidget = Row(
      children: List.generate(
        _bottomNavigationBar.length,
        (index) {
          var item = _bottomNavigationBar[index];
          bool isSelected = editingNotifier.currentIndex != null && editingNotifier.currentIndex == index;

          return FieButton(
            item: item,
            isSelected: isSelected,
            onTap: () {
              onBottomNavTapped(
                editingNotifier,
                item.type,
                index: index,
                statusBarHeight: statusBarHeight,
                bottomNavHeight: bottomNavHeight,
                context: context,
              );
            },
          );
        },
      ),
    );

    return itemsWidget;
  }

  Widget buildOnStylingBottomNavigation({
    EditingNotifier notifier,
    double bottomNavHeight,
    double statusBarHeight,
    @required BuildContext context,
  }) {
    bool isShowing = notifier.currentStyleType != null;
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        duration: ConfigConstant.duration,
        padding: EdgeInsets.only(bottom: isShowing ? bottomNavHeight : 0),
        height: isShowing ? ConfigConstant.toolbarHeight + bottomNavHeight : 0,
        child: Material(
          elevation: 0,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: List.generate(
              2,
              (index) {
                return InkWell(
                  onTap: () {
                    notifier.setCurrentStyleType(null);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ConfigConstant.toolbarHeight,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Icon(index == 0 ? Icons.clear : Icons.check),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

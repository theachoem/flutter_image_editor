import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/models/bottom_nav_button_model.dart';
import 'package:flutter_image_editor/models/export_item_model.dart';
import 'package:flutter_image_editor/models/tools_item_model.dart';
import 'package:flutter_image_editor/notifiers/editing_notifier.dart';
import 'package:flutter_image_editor/types/bottom_navs_type.dart';
import 'package:flutter_image_editor/widgets/export_list_widget.dart';
import 'package:flutter_image_editor/widgets/fie_appbar.dart';
import 'package:flutter_image_editor/widgets/style_list_widget.dart';
import 'package:flutter_image_editor/widgets/tools_gridview.dart';
import 'package:hooks_riverpod/all.dart';

class EditingScreen extends ConsumerWidget {
  final List<BottomNavButtonModel> _bottomNavigationBar = BottomNavButtonModel.items;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, reader) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomNavHeight = MediaQuery.of(context).padding.bottom;

    var notifier = reader(editingNotifier);
    return Stack(
      children: [
        Scaffold(
          key: scaffoldKey,
          appBar: FieAppBar(isEditing: true),
          body: buildBody(
            notifier: notifier,
            context: context,
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
        ),
        buildMainBottomNavigation(
          notifier: notifier,
          bottomNavHeight: bottomNavHeight,
          statusBarHeight: statusBarHeight,
          context: context,
        ),
        buildOnStylingBottomNavigation(
          notifier: notifier,
          bottomNavHeight: bottomNavHeight,
          statusBarHeight: statusBarHeight,
          context: context,
        ),
      ],
    );
  }

  Widget buildBody({
    EditingNotifier notifier,
    @required BuildContext context,
  }) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(ConfigConstant.objectHeight5),
      color: Colors.black.withOpacity(0.1),
    );
    var margin = EdgeInsets.fromLTRB(
      ConfigConstant.margin1,
      0,
      ConfigConstant.margin1,
      notifier.currentIndex == 0 ? ConfigConstant.objectHeight4 : 0,
    );
    return GestureDetector(
      onTap: () {
        if (notifier.currentIndex != null) {
          closeModal(context);
          notifier.onModalClose();
          return;
        }
      },
      child: Center(
        child: AnimatedContainer(
          duration: ConfigConstant.duration,
          decoration: boxDecoration,
          curve: Curves.easeInQuad,
          margin: margin,
          child: Image.network(
            'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/134182425/original/eba17619f415cdda3df45653a71960c9d0e52f3c/make-a-beautiful-t-shirt-design.jpg',
          ),
        ),
      ),
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
        notifier,
      ).whenComplete(() => notifier.onModalClose());
    }
  }

  void closeModal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
    });
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
                print(index);
                print(item);
              },
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future showExportModalBottomSheet(BuildContext context, EditingNotifier notifier) {
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
    EditingNotifier notifier,
    double bottomNavHeight,
    double statusBarHeight,
    @required BuildContext context,
  }) {
    var itemsWidget = Row(
      children: List.generate(
        _bottomNavigationBar.length,
        (index) {
          var item = _bottomNavigationBar[index];
          bool isSelected = notifier.currentIndex != null && notifier.currentIndex == index;
          var style = TextStyle(
            color: isSelected ? Theme.of(context).accentColor : null,
          );
          return InkWell(
            onTap: () {
              onBottomNavTapped(
                notifier,
                item.type,
                index: index,
                statusBarHeight: statusBarHeight,
                bottomNavHeight: bottomNavHeight,
                context: context,
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: ConfigConstant.toolbarHeight,
              width: MediaQuery.of(context).size.width / 3,
              child: Text(item.label, style: style),
            ),
          );
        },
      ),
    );

    return Positioned(
      bottom: 0,
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(bottom: bottomNavHeight),
        child: Material(
          elevation: 0,
          color: Theme.of(context).primaryColor,
          child: itemsWidget,
        ),
      ),
    );
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
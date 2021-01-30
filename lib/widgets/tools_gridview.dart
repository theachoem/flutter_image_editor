import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/models/tools_item_model.dart';

class ToolsGridView extends StatelessWidget {
  const ToolsGridView({
    Key key,
    @required this.controller,
    @required this.tools,
    @required this.onTap,
  }) : super(key: key);

  final List<ToolsItemModel> tools;
  final ScrollController controller;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      childAspectRatio: 1,
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: ConfigConstant.margin2,
        horizontal: ConfigConstant.margin2,
      ),
      children: List.generate(
        tools.length,
        (index) {
          return buildItemIconButton(
            context,
            tool: tools[index],
            onTap: () {
              onTap(index, tools[index]);
            },
          );
        },
      ),
    );
  }

  Widget buildItemIconButton(
    BuildContext context, {
    ToolsItemModel tool,
    Function onTap,
  }) {
    return Container(
      width: ConfigConstant.objectHeight1,
      height: ConfigConstant.objectHeight1,
      alignment: Alignment.center,
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConfigConstant.objectHeight1,
          ),
        ),
        onPressed: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: ConfigConstant.margin1),
                alignment: Alignment.center,
                child: Icon(
                  tool.iconData,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              Container(
                height: 32,
                child: Text(
                  tool.label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

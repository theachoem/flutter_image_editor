import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';
import 'package:flutter_image_editor/models/export_item_model.dart';

class ExportListWidget extends StatelessWidget {
  const ExportListWidget({
    Key key,
    @required this.exportItems,
    @required this.onTap,
  }) : super(key: key);

  final List<ExportItemModel> exportItems;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        this.exportItems.length,
        (index) {
          var item = this.exportItems[index];
          return Column(
            children: [
              if (index == 0) const SizedBox(height: ConfigConstant.margin1),
              ListTile(
                onTap: () {
                  onTap(index, item);
                },
                leading: Icon(item.iconData),
                title: Text(item.label),
                subtitle: Text(item.subtitle),
                contentPadding: EdgeInsets.symmetric(
                  vertical: ConfigConstant.margin2,
                  horizontal: ConfigConstant.margin2,
                ),
              ),
              if (index == 0) const Divider(),
            ],
          );
        },
      ),
    );
  }
}

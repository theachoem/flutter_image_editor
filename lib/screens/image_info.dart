import 'package:flutter/material.dart';
import 'package:flutter_image_editor/helper/app_helper.dart';
import 'package:flutter_image_editor/notifiers/image_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageInfoModel {
  final IconData iconData;
  final String title;
  final String subtitle;

  ImageInfoModel({
    this.iconData,
    this.title,
    this.subtitle,
  });
}

class FieImageInfo extends StatelessWidget {
  const FieImageInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, reader, child) {
        var notifier = reader(imageNotifier);

        String imageWH = "${notifier.imageDecode.width} x ${notifier.imageDecode.height}";
        String imageSize = AppHelper.fileSize(notifier.readFile.lengthInBytes);
        var image = notifier.image;
        List<ImageInfoModel> infos = [
          ImageInfoModel(
            title: "Last modify",
            subtitle: AppHelper.dateFormate(notifier.lastModify) ?? "null",
            iconData: Icons.calendar_today,
          ),
          ImageInfoModel(
            title: image.path.replaceAll(image.parent.path + "/", ""),
            subtitle: imageWH + " - Size: " + imageSize,
            iconData: Icons.file_copy_outlined,
          ),
        ];
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text('Image details'),
            automaticallyImplyLeading: true,
          ),
          body: ListView(
            children: List.generate(
              infos.length,
              (index) => ListTile(
                title: Text(infos[index].title),
                subtitle: Text(infos[index].subtitle),
                leading: Icon(
                  infos[index].iconData,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

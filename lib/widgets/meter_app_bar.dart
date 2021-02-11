import 'package:flutter/material.dart';
import 'package:flutter_image_editor/constants/config_constant.dart';

class MeterAppBar extends PreferredSize {
  const MeterAppBar({
    Key key,
    this.title = "",
    this.statusBarHeight = 24.0,
    @required this.tuneValue,
  }) : super(
          key: key,
          child: const SizedBox(),
          preferredSize: const Size.fromHeight(ConfigConstant.toolbarHeight),
        );

  final String title;
  final double statusBarHeight;
  final double tuneValue;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(tuneValue);
    print("OTHER WIDGT");
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
          tuneValue: tuneValue,
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
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: actionButton,
    );

    return appBar;
  }

  Widget buildMeter({double width, BuildContext context, double tuneValue}) {
    final meters = 4;
    final meterHeight = 4.0;

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
                    width: tuneValue < 0 ? -tuneValue : 0,
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
                    width: tuneValue > 0 ? tuneValue : 0,
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
}

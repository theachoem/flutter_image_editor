import 'package:flutter/material.dart';

class MeterAppBar extends PreferredSize {
  const MeterAppBar({
    Key key,
    this.title = "",
    @required this.tuneValue,
  }) : super(
          key: key,
          child: const SizedBox(),
          preferredSize: const Size.fromHeight(kToolbarHeight),
        );

  final String title;
  final double tuneValue;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var meter = buildMeter(
      width: width,
      context: context,
      tuneValue: tuneValue,
    );

    var actionButton = [
      IconButton(
        icon: const Icon(Icons.flip),
        onPressed: () {},
      )
    ];

    var appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: meter,
      actions: actionButton,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );

    return SafeArea(
      child: appBar,
    );
  }

  Widget buildMeter({double width, BuildContext context, double tuneValue}) {
    final meters = 4;
    final meterHeight = 4.0;

    return Container(
      height: meterHeight * 2.5,
      child: Stack(
        children: [
          Positioned(
            top: 0.5,
            left: 0,
            right: 0,
            height: meterHeight * 2.5,
            child: Wrap(
              children: [
                Container(
                  width: width / 2,
                  alignment: Alignment.centerRight,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    color: Theme.of(context).accentColor,
                    width: tuneValue < 0 ? -tuneValue : 0,
                    height: meterHeight,
                  ),
                ),
                Container(
                  width: width / 2,
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    color: Theme.of(context).accentColor,
                    width: tuneValue > 0 ? tuneValue : 0,
                    height: meterHeight,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: meterHeight * 2.5,
            child: Wrap(
              children: List.generate(
                meters,
                (index) {
                  var isCenter = index + 1 == meters / 2;
                  return Wrap(
                    children: [
                      Container(
                        width: width / meters - 1,
                        height: meterHeight,
                      ),
                      Container(
                        width: 1,
                        height: isCenter ? meterHeight * 2.5 : meterHeight,
                        color: Theme.of(context).disabledColor,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:marrat/styles/ui_helpers.dart';

class AddTimeWidget extends StatefulWidget {
  String prayerName;
  TimeOfDay prayerTime;
  TimeOfDay adhanTime;
  Function onAdhanTimePressed;
  Function onPrayerTimePressed;
  AddTimeWidget({
    Key key,
    @required this.prayerName,
    @required this.prayerTime,
    @required this.adhanTime,
    @required this.onAdhanTimePressed,
    @required this.onPrayerTimePressed,
  }) : super(key: key);
  @override
  _AddTimeWidgetState createState() => _AddTimeWidgetState();
}

class _AddTimeWidgetState extends State<AddTimeWidget> {
  Widget buildPrayerTimeDisplay(
      String label, String displayTime, Function onTimePressed) {
    return Row(
      children: [
        Text(label),
        horizontalSpaceSmall,
        TextButton(
          onPressed: onTimePressed,
          child: Text(displayTime),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(widget.prayerName),
          Column(
            children: [
              buildPrayerTimeDisplay("Adhan Time",
                  widget.adhanTime.format(context), widget.onAdhanTimePressed),
              buildPrayerTimeDisplay(
                  "Prayer Time",
                  widget.prayerTime.format(context),
                  widget.onPrayerTimePressed),
            ],
          )
        ],
      ),
    );
  }
}

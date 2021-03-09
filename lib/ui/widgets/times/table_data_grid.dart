import 'package:flutter/material.dart';

import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/styles/text_styles.dart';

class TimesDataGrid extends StatelessWidget {
  final List<Prayer> prayers;
  // void showTimeOfDayPicker(
  // Function onTimeSelected, context, Prayer prayer, bool isAdhan)
  final Function onPrayerTimePressed;
  final Function setPrayerTime;
  final bool isEdit;
  TimesDataGrid({
    Key key,
    this.setPrayerTime,
    this.isEdit,
    this.prayers,
    this.onPrayerTimePressed,
  }) : super(key: key);
  _getRows(
    context,
  ) {
    List<DataRow> dataRows = [];
    prayers.forEach((element) {
      DataRow row = DataRow(cells: [
        DataCell(Text(element.prayerName)),
        DataCell(
          Text(element.adhanTime.format(context)),
          onTap: isEdit
              ? () async => await onPrayerTimePressed(
                  setPrayerTime, context, element, true)
              : () {},
        ),
        DataCell(
          Text(element.prayerTime.format(context)),
          onTap: isEdit
              ? () async => await onPrayerTimePressed(
                  setPrayerTime, context, element, false)
              : () {},
        )
      ]);
      dataRows.add(row);
    });
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DataTable(
      columns: [
        DataColumn(
            label: Text(
          'Salah',
          style: kcSubHeadingStyle(Colors.black),
        )),
        DataColumn(
            label: Text('Adhan', style: kcSubHeadingStyle(Colors.black))),
        DataColumn(
            label: Text(
          'Prayer',
          style: kcSubHeadingStyle(Colors.black),
        ))
      ],
      rows: _getRows(context),
    ));
  }
}

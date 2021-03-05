import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/input_field.dart';
import 'package:marrat/ui/widgets/mosque_card.dart';
import 'package:marrat/ui/widgets/mosque_tile.dart';
import 'package:marrat/ui/widgets/times/table_data_grid.dart';
import 'package:stacked/stacked.dart';

import 'specific_mosque_viewmodel.dart';

class SpecificMosqueView extends StatelessWidget {
  final Mosque mosque;

  const SpecificMosqueView({Key key, this.mosque}) : super(key: key);
  Widget _buildTempTimesColumn(BuildContext context) {
    DataTable table = DataTable(columns: [
      DataColumn(label: Text('Test')),
      DataColumn(label: Text('Test'))
    ], rows: [
      DataRow(cells: [DataCell(Text('test')), DataCell(Text('test'))])
    ]);

    return table;
  }

  _getRows(
    context,
  ) {
    List<DataRow> dataRows = [];
    mosque.normalPrayerTimes.forEach((element) {
      DataRow row = DataRow(cells: [
        DataCell(Text(element.prayerName)),
        DataCell(Text(element.adhanTime.format(context))),
        DataCell(Text(element.prayerTime.format(context)))
      ]);
      dataRows.add(row);
    });
    return dataRows;
  }

  /*  DataRow _getSalahNames() {
    List<DataCell> tableCells = mosque.normalPrayerTimes
        .map((e) => DataCell(Text(e.prayerName)))
        .toList();
    DataRow dataRow = DataRow(cells: tableCells);
    return dataRow;
  }

  DataRow _getAdhanTimes(context) {
    List<DataCell> tableCells = mosque.normalPrayerTimes
        .map((e) => DataCell(Text(e.adhanTime.format(context))))
        .toList();
    DataRow dataRow = DataRow(cells: tableCells);
    return dataRow;
  }

  DataRow _getPrayerTimes(context) {
    List<DataCell> tableCells = mosque.normalPrayerTimes
        .map((e) => DataCell(Text(e.prayerTime.format(context))))
        .toList();
    DataRow dataRow = DataRow(cells: tableCells);
    return dataRow;
  } */

  Widget build(BuildContext context) {
    return ViewModelBuilder<SpecificMosqueViewModel>.reactive(
        fireOnModelReadyOnce: true,
        builder: (context, SpecificMosqueViewModel model, child) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => model.popBack())
              ],
              title: Text(mosque.mosqueName),
            ),
            body: model.isBusy
                ? Column(children: [])
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        MosqueCard(
                          address: mosque.address,
                          distance: mosque.distance,
                          imageUrl: mosque.mosqueImageUrl,
                          isSearch: true,
                          mosqueName: mosque.mosqueName,
                          onTap: () {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            Text(
                              'Times',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () =>
                                    model.navigateToEditTimes(mosque),
                                child: Text('Edit Times'))
                          ],
                        ),
                        TimesDataGrid(
                          isEdit: false,
                          onPrayerTimePressed: () {},
                          prayers: mosque.normalPrayerTimes,
                          setPrayerTime: () {},
                        )
                      ],
                    ),
                  )),
        viewModelBuilder: () => SpecificMosqueViewModel());
  }
}

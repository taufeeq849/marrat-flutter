import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/ui/widgets/mosque_card.dart';
import 'package:marrat/ui/widgets/times/table_data_grid.dart';
import 'package:stacked/stacked.dart';

import 'specific_mosque_viewmodel.dart';

class SpecificMosqueView extends StatelessWidget {
  final Mosque mosque;

  const SpecificMosqueView({Key key, this.mosque}) : super(key: key);
 
 

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
                          mosqueName: mosque.mosqueName,
                          onTap: () {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Times for this mosque',
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

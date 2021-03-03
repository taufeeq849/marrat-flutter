import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/ui/widgets/mosque_tile.dart';
import 'package:stacked/stacked.dart';

import 'times_viewmodel.dart';

class TimesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimesViewModel>.reactive(
        fireOnModelReadyOnce: true,
        builder: (context, TimesViewModel model, child) => model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.data.length > 0
                ? ListView.builder(
                    itemCount: model.data.length,
                    itemBuilder: (context, index) {
                      Mosque mosque = model.data[index];
                      return MosqueTile(
                        imageUrl: mosque.mosqueImageUrl,
                        mosqueName: mosque.mosqueName,
                        distance: '5km',
                      );
                    })
                : Center(
                    child: Text("Failed to get mosques, try again later"),
                  ),
        viewModelBuilder: () => TimesViewModel());
  }
}

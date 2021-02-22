import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'times_viewmodel.dart';

class TimesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (TimesViewModel model) => model.getLocation(),
        builder: (context, TimesViewModel model, child) =>
            model.userLocation == null
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(model.userLocation.latitude.toString() +
                        model.userLocation.longitude.toString()),
                  ),
        viewModelBuilder: () => TimesViewModel());
  }
}

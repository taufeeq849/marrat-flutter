import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'app_info_viewmodel.dart';

class AppInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, AppInformationViewModel model, child) {
        return Container();
      },
      viewModelBuilder: () => AppInformationViewModel(),
      onModelReady: (AppInformationViewModel model) {},
    );
  }
}

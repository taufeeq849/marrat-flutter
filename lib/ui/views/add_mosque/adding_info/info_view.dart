import 'package:flutter/material.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'info_viewmodel.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (InfoViewModel model) {},
        builder: (context, InfoViewModel model, child) => Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add a mosque for the benefit of your muslim brothers,",
                      style: kcMainHeadingStyle,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceLarge,
                    ElevatedButton(
                        onPressed: () => model.navigateToAddDetails(),
                        child: Text("Get Started"))
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => InfoViewModel());
  }
}

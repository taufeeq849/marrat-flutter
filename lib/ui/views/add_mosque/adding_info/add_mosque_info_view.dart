import 'package:flutter/material.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'add_mosque_info_view_model.dart';

class AddMosqueInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (AddMosqueInfoViewModel model) {},
        builder: (context, AddMosqueInfoViewModel model, child) => Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add a mosque for the benefit of your muslim brothers. ",
                      style: kcMainHeadingStyle,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceLarge,
                    ElevatedButton(
                        onPressed: () => model.navigateToAddMosqueView(),
                        child: Text("Get Started"))
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => AddMosqueInfoViewModel());
  }
}

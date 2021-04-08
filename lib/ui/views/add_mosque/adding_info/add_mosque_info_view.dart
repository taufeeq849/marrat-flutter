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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "To add a new mosque, please complete the following survery. The mosque should then be added in 24 hours.",
                        style: kcMainHeadingStyle,
                        textAlign: TextAlign.center,
                      ),
                      verticalSpaceLarge,
                      ElevatedButton(
                          onPressed: () => model.launchUrl(),
                          child: Text("Get Started"))
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => AddMosqueInfoViewModel());
  }
}

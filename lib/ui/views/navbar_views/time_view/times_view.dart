import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'times_viewmodel.dart';

class TimesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Center(
              child: Text("Discover View"),
            ),
        viewModelBuilder: () => TimesViewModel());
  }
}

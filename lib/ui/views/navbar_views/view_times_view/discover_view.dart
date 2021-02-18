import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'discover_viewmodel.dart';

class DiscoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Center(
              child: Text("Discover View"),
            ),
        viewModelBuilder: () => DiscoverViewModel());
  }
}

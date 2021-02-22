import 'package:flutter/material.dart';
import 'package:marrat/ui/views/navbar_views/add_mosque/add_mosque_view_model.dart';
import 'package:stacked/stacked.dart';

class AddMosqueView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Center(
              child: Text("Add Mosque View"),
            ),
        viewModelBuilder: () => AddMosqueViewModel());
  }
}

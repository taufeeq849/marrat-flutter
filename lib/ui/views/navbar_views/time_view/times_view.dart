import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/input_field.dart';
import 'package:marrat/ui/widgets/mosque_tile.dart';
import 'package:stacked/stacked.dart';

import 'times_viewmodel.dart';

class TimesView extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  Widget _buildSearchBox(TimesViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: InputField(
        controller: searchController,
        placeholder: 'Search for mosques',
        onChanged: (text) async {
          if (text.isNotEmpty) {
            await model.searchForMosques(text);
          } else {
            model.setSearchActive(false);
          }
        },
      ),
    );
  }

  Widget _buildListView(TimesViewModel model) {
    bool isSearch = model.searchActive;
    List<Mosque> mosques = isSearch ? model.searchMosques : model.data;

    if (isSearch && model.busy(model.searchMosques)) {
      return Center(
        child: Text('Searching for mosques'),
      );
    }
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: mosques.length,
        itemBuilder: (context, index) {
          if (mosques.length > 0) {
            Mosque mosque = mosques[index];
            return MosqueTile(
              imageUrl: mosque.mosqueImageUrl,
              mosqueName: mosque.mosqueName,
              distance: isSearch ? '' : mosque.distance.toString() + ' km',
              address: mosque.address,
            );
          } else {
            return Center(
              child: Text(
                  "There are no mosques around you , search for one of them"),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimesViewModel>.reactive(
        fireOnModelReadyOnce: true,
        builder: (context, TimesViewModel model, child) => model.isBusy
            ? Column(children: [
                _buildSearchBox(model),
                verticalSpaceMedium,
                CircularProgressIndicator()
              ])
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSearchBox(model),
                    verticalSpaceLarge,
                    _buildListView(model)
                  ],
                ),
              ),
        viewModelBuilder: () => TimesViewModel());
  }
}

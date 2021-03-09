import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/input_field.dart';
import 'package:marrat/ui/widgets/mosque_card.dart';
import 'package:stacked/stacked.dart';

import 'package:google_fonts/google_fonts.dart';
import 'times_viewmodel.dart';

class TimesView extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  Widget _buildSearchBox(TimesViewModel model) {
    return InputField(
      controller: searchController,
      placeholder: 'Search for mosques',
      onChanged: (text) async {
        if (text.isNotEmpty) {
          await model.searchForMosques(text);
        } else {
          model.setSearchActive(false);
        }
      },
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
            print(mosque.location);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MosqueCard(
                imageUrl: mosque.mosqueImageUrl,
                mosqueName: mosque.mosqueName,
                distance: mosque.distance,
                address: mosque.address,
                onTap: () => model.showTimesBottomSheet(mosque),
              ),
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
            ? Column(
                children: [_buildSearchBox(model), CircularProgressIndicator()])
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Here are the closest mosques to your location',
                            style: kcMainHeadingStyle),
                      ),
                      verticalSpaceMedium,
                      _buildSearchBox(model),
                      _buildListView(model)
                    ],
                  ),
                ),
              ),
        viewModelBuilder: () => TimesViewModel());
  }
}

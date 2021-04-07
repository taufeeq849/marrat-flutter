import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/input_field.dart';
import 'package:marrat/ui/widgets/mosque_card/mosque_card.dart';
import 'package:stacked/stacked.dart';
import 'times_viewmodel.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

  Widget _buildListView(TimesViewModel model, bool isDesktop) {
    bool isSearch = model.searchActive;
    List<Mosque> mosques = isSearch ? model.searchMosques : model.data;
    if (isSearch && model.busy(model.searchMosques)) {
      return Center(
        child: Text('Searching for mosques'),
      );
    }
    if (mosques == null || mosques?.length == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 100,
        ),
        child: Text(
          model.searchActive
              ? "No results found"
              : "There are no mosques near your current location, try searching for a mosque",
          style: kcMainHeadingStyle,
        ),
      );
    }
    if (isDesktop) {
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: mosques == null ? 0 : mosques?.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Mosque mosque = mosques[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MosqueCard(
                isDesktop: isDesktop,
                imageUrl: mosque.mosqueImageUrl,
                mosqueName: mosque.mosqueName,
                distance: mosque.distance,
                address: mosque.address,
                onTap: () => model.showTimesBottomSheet(mosque),
              ),
            );
          });
    }
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: mosques == null ? 0 : mosques?.length,
        itemBuilder: (context, index) {
          Mosque mosque = mosques[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: MosqueCard(
              imageUrl: mosque.mosqueImageUrl,
              mosqueName: mosque.mosqueName,
              distance: mosque.distance,
              address: mosque.address,
              isDesktop: isDesktop,
              onTap: () => model.showTimesBottomSheet(mosque),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimesViewModel>.reactive(
        fireOnModelReadyOnce: true,
        builder: (context, TimesViewModel model, child) => model.isBusy
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Fetching the nearest mosques to you...',
                  textAlign: TextAlign.center,
                  style: kcMainHeadingStyle,
                ),
                verticalSpaceLarge,
                CircularProgressIndicator()
              ])
            : ResponsiveBuilder(builder: (context, sizingInformation) {
                print(sizingInformation.isDesktop);
                return SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Here are the closest mosques to your location',
                          style: kcMainHeadingStyle),
                      verticalSpaceMedium,
                      _buildSearchBox(model),
                      _buildListView(
                          model,
                          sizingInformation.isDesktop ||
                              sizingInformation.isTablet)
                    ],
                  ),
                ));
              }),
        viewModelBuilder: () => TimesViewModel());
  }
}

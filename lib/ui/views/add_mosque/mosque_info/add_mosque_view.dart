import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/styles/app_colors.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/ui/widgets/mosque_card/mosque_card.dart';
import 'package:stacked/stacked.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/busy_button.dart';
import 'package:marrat/ui/widgets/image_uploader.dart';
import 'add_mosque_view_model.dart';

class AddMosqueView extends StatelessWidget {
  TextEditingController mosqueNameController = new TextEditingController();
  TextEditingController mosqueLocationController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Step getNameStep(
    AddMosqueViewModel model,
  ) {
    return Step(
        title: const Text("Name"),
        isActive: model.isStepActive(model.nameStep),
        content: Column(
          children: [
            if (model.nameValidationMessage.length > 0)
              Text(
                model.nameValidationMessage,
                style: TextStyle(color: Colors.red),
              ),
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: mosqueLocationController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(border: OutlineInputBorder())),
              suggestionsCallback: (pattern) async {
                if (pattern != null && pattern.length > 0) {
                  model.setMosqueName(pattern); 
                  return await model.getPlaceSuggestions(pattern);
                }
                return [];
              },
              itemBuilder: (context, suggestion) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                  child: Text(
                    suggestion.name,
                    style: kcSubHeadingStyle(Colors.black),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                model.onPlaceSelected(suggestion);
              },
            ),
            verticalSpaceMedium,
          ],
        ));
  }

  Step getLocationStep(AddMosqueViewModel model) {
    return Step(
      title: Text("Location"),
      isActive: model.isStepActive(model.locationStep),
      content: Column(
        children: [
          model.busy(model.mosque)
              ? Column(
                  children: [
                    Text('Fetching location'),
                    verticalSpaceSmall,
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    )
                  ],
                )
              : TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: mosqueLocationController,
                      style: TextStyle(color: Colors.black),
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) async {
                    if (pattern != null && pattern.length > 0) {
                      return await model
                          .getLocationAutocompleteSuggestions(pattern);
                    }
                    return [];
                  },
                  itemBuilder: (context, suggestion) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 2),
                      child: Text(
                        suggestion.address,
                        style: kcSubHeadingStyle(Colors.black),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    mosqueLocationController.text = suggestion.address;
                  },
                ),
          model.locationValidationMessage != null
              ? Text(
                  "Location is required",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.red),
                )
              : Container()
        ],
      ),
    );
  }

  Widget getConfirmationUI(AddMosqueViewModel model) {
    Mosque mosque = model.mosque;
    return model.busy(mosque)
        ? Column(
            children: [
              Text(
                'Fetching mosque data',
                style: kcMainHeadingStyle,
              ),
              verticalSpaceMedium,
              CircularProgressIndicator(),
            ],
          )
        : Column(
            children: [
              Text(
                'Confirm your entry',
                style: kcMainHeadingStyle,
              ),
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MosqueCard(
                  address: mosque.address,
                  imageUrl: mosque.mosqueImageUrl,
                  mosqueName: mosque.mosqueName,
                  onTap: () {},
                ),
              ),
              verticalSpaceLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => model.editData(),
                      child:
                          Text('Edit', style: kcSubHeadingStyle(Colors.white))),
                  BusyButton(
                    title: 'Proceed ',
                    onPressed: () => model.navigateToAddPrayerTimes(),
                  )
                ],
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, AddMosqueViewModel model, child) {
          List<Step> steps = [
            getNameStep(model),
            getLocationStep(
              model,
            ),
          ];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                'Add a new mosque',
                style: kcBlackMainHeadingStyle,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                model.complete
                    ? Center(child: getConfirmationUI(model))
                    : Expanded(
                        child: Stepper(
                        type: StepperType.vertical,
                        steps: steps,
                        currentStep: model.currentStep,
                        onStepContinue: () => model.next(steps.length,
                            name: mosqueNameController.text,
                            location: mosqueLocationController.text),
                        onStepCancel: model.cancel,
                      ))
              ],
            ),
          );
        },
        viewModelBuilder: () => AddMosqueViewModel());
  }
}

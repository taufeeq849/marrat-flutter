import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/services/location/autocomplete_service.dart';
import 'package:marrat/styles/app_colors.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/ui/widgets/add_time_widget.dart';
import 'package:marrat/ui/widgets/mosque_card.dart';
import 'package:stacked/stacked.dart';

import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/busy_button.dart';
import 'package:marrat/ui/widgets/checkbox_input_field.dart';
import 'package:marrat/ui/widgets/image_uploader.dart';
import 'package:marrat/ui/widgets/input_field.dart';

import 'add_mosque_view_model.dart';

class AddMosqueView extends StatelessWidget {
  TextEditingController mosqueNameController = new TextEditingController();
  TextEditingController mosqueLocationController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Step getImageStep(AddMosqueViewModel model, bool isBusy, selectedIndex,
      imageUrl, uploadImage) {
    return Step(
        isActive: selectedIndex == model.imageStep,
        content: Column(
          children: [
            isBusy
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                  )
                : ImageViewer(
                    imgUrl: imageUrl,
                  ),
            BusyButton(
                title: "Upload a picture (Optional)",
                onPressed: () async {
                  await uploadImage();
                }),
          ],
        ),
        title: Text("Image"));
  }

  Step getNameStep(selectedIndex, AddMosqueViewModel model, validationMessage) {
    return Step(
        title: const Text("Name"),
        isActive: selectedIndex == model.nameStep,
        content: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              controller: mosqueLocationController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(border: OutlineInputBorder())),
          suggestionsCallback: (pattern) async {
            if (pattern != null && pattern.length > 0) {
              return await model.getPlaceSuggestions(pattern);
            }
            return [];
          },
          itemBuilder: (context, suggestion) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
              child: Text(
                suggestion.name,
                style: kcSubHeadingStyle(Colors.black),
              ),
            );
          },
          onSuggestionSelected: (suggestion) {
            model.onPlaceSelected(suggestion);
          },
        ));
  }

  Step getLocationStep(
      bool isBusy,
      selectedIndex,
      AddMosqueViewModel model,
      Function getAutoCompleteSuggestions,
      String locationValidationMessage,
      context) {
    return Step(
      title: Text("Location"),
      isActive: selectedIndex == model.locationStep,
      content: Column(
        children: [
          isBusy
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
                      return await getAutoCompleteSuggestions(pattern);
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
          locationValidationMessage != null
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
    Mosque mosque = model.mosqueData;
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
            getNameStep(model.currentStep, model, model.nameValidationMessage),
            getImageStep(model, model.isBusy, model.currentStep,
                model.mosqueData.mosqueImageUrl, model.uploadImage),
            getLocationStep(
                model.busy(model.mosqueData),
                model.currentStep,
                model,
                model.getAutocompleteSuggestions,
                model.locationValidationMessage,
                context),
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

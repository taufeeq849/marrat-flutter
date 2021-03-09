import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
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
  Step getImageStep(bool isBusy, selectedIndex, imageUrl, uploadImage) {
    return Step(
        isActive: selectedIndex == 0,
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

  Step getNameStep(selectedIndex, mosqueNameController, validationMessage) {
    return Step(
        title: const Text("Name"),
        isActive: selectedIndex == 1,
        content: InputField(
            validationMessage:
                validationMessage == null ? null : validationMessage,
            controller: mosqueNameController,
            placeholder: "Mosque Name"));
  }

  Step getLocationStep(
      bool isBusy,
      selectedIndex,
      Function getAutoCompleteSuggestions,
      String locationValidationMessage,
      context) {
    return Step(
      title: Text("Location"),
      isActive: selectedIndex == 2,
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
                    return Text(suggestion.address);
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
    return Column(
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
                child: Text('Edit', style: kcSubHeadingStyle(Colors.white))),
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
            getImageStep(model.isBusy, model.currentStep,
                model.mosqueData.mosqueImageUrl, model.uploadImage),
            getNameStep(model.currentStep, mosqueNameController,
                model.nameValidationMessage),
            getLocationStep(
                model.busy(model.mosqueData),
                model.currentStep,
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

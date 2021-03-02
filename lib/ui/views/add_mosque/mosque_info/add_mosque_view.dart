import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/ui/views/add_mosque/mosque_info/prayer_times/add_prayer_times_viewmodel.dart';
import 'package:marrat/ui/widgets/add_time_widget.dart';
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
  Step getImageStep(selectedIndex, imageUrl, uploadImage) {
    return Step(
        isActive: selectedIndex == 0,
        content: Column(
          children: [
            ImageViewer(
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

  Step getLocationStep(selectedIndex, Function getAutoCompleteSuggestions,
      String locationValidationMessage, context) {
    return Step(
      title: Text("Location"),
      isActive: selectedIndex == 2,
      content: Column(
        children: [
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: mosqueLocationController,
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(fontStyle: FontStyle.italic),
                decoration: InputDecoration(border: OutlineInputBorder())),
            suggestionsCallback: (pattern) async {
              if (pattern != null) {
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

  Step getAmmenitiesStep(selectedIndex, isLadiesSelected, isWudhuSelected,
      changeLadiesValue, changeWudhuValue) {
    return Step(
      state: StepState.complete,
      isActive: selectedIndex == 3,
      content: Column(
        children: [
          Text("Ammentities"),
          CheckBoxInputField(
            title: "Ladies Facilties",
            isSelected: isLadiesSelected,
            onSelectChanged: changeLadiesValue,
          ),
          verticalSpaceMedium,
          CheckBoxInputField(
            title: "Wudhu Khana",
            isSelected: isWudhuSelected,
            onSelectChanged: changeWudhuValue,
          ),
        ],
      ),
      title: Text("Ammenities"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, AddMosqueViewModel model, child) {
          List<Step> steps = [
            getImageStep(model.currentStep, model.mosqueData.mosqueImageUrl,
                model.uploadImage),
            getNameStep(model.currentStep, mosqueNameController,
                model.nameValidationMessage),
            getLocationStep(model.currentStep, model.getAutocompleteSuggestions,
                model.locationValidationMessage, context),
            getAmmenitiesStep(
                model.currentStep,
                model.mosqueData.hasLadiesFacilities,
                model.mosqueData.hasWudhuKhana,
                model.changeLadiesValue,
                model.changeWudhuValue),
          ];

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                    child:
                        /*  model.complete
                        ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Confirm the data: "),
                            verticalSpaceLarge,
                            BusyButton(
                                title: "Proceed to next step ",
                                onPressed: () =>
                          model.navigateToPrayerTimesStep()) ],
                        ),
                          )
                        : */
                        Stepper(
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

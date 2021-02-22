import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/views/navbar_views/add_mosque/add_mosque_view_model.dart';
import 'package:marrat/ui/widgets/busy_button.dart';
import 'package:marrat/ui/widgets/checkbox_input_field.dart';
import 'package:marrat/ui/widgets/image_uploader.dart';
import 'package:marrat/ui/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

class AddMosqueView extends StatelessWidget {
  TextEditingController mosqueNameController = new TextEditingController();
  TextEditingController mosqueLocationController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, AddMosqueViewModel model, child) =>
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Add A New Mosque"),
                    verticalSpaceMedium,
                    ImageViewer(
                      imgUrl: model.mosqueData.mosqueImageUrl,
                    ),
                    BusyButton(
                        title: "Upload a picture (Optional)",
                        onPressed: () async {
                          model.uploadImage();
                        }),
                    verticalSpaceMedium,
                    Text("Enter the mosque details"),
                    verticalSpaceMedium,
                    InputField(
                        validationMessage: model.nameValidationMessage == null
                            ? null
                            : model.nameValidationMessage,
                        controller: mosqueNameController,
                        placeholder: "Mosque Name"),
                    verticalSpaceSmall,
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: mosqueLocationController,
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontStyle: FontStyle.italic),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) async {
                        if (pattern != null) {
                          return await model
                              .getAutocompleteSuggestions(pattern);
                        }
                        return [];
                      },
                      itemBuilder: (context, suggestion) {
                        return Text(suggestion.address);
                      },
                      onSuggestionSelected: (suggestion) {
                        mosqueLocationController.text = suggestion.address;
                        print(suggestion.address);
                      },
                    ),
                    verticalSpaceMedium,
                    Text("Ammentities"),
                    verticalSpaceMedium,
                    CheckBoxInputField(
                      title: "Ladies Facilties",
                      isSelected: model.mosqueData.hasLadiesFacilities,
                      onSelectChanged: model.changeLadiesValue,
                    ),
                    verticalSpaceMedium,
                    CheckBoxInputField(
                      title: "Wudhu Khana",
                      isSelected: model.mosqueData.hasWudhuKhana,
                      onSelectChanged: model.changeWudhuValue,
                    ),
                    BusyButton(
                        title: "Submit",
                        onPressed: model.onSubmit(mosqueNameController.text,
                            mosqueLocationController.text))
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => AddMosqueViewModel());
  }
}

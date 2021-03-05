import 'package:flutter/material.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/add_time_widget.dart';
import 'package:marrat/ui/widgets/busy_button.dart';
import 'package:marrat/ui/widgets/times/table_data_grid.dart';
import 'package:stacked/stacked.dart';

import 'add_prayer_times_viewmodel.dart';

class AddPrayerTimesView extends StatelessWidget {
  Mosque mosqueData;
  AddPrayerTimesView({@required this.mosqueData});
  Step infoStep(
    selectedIndex,
  ) {
    return Step(
      isActive: selectedIndex == 0,
      content: Column(
        children: [
          Text("One more step, add prayer times"),
          verticalSpaceMedium,
        ],
      ),
      title: Text("Info"),
    );
  }

  Step getNormalPrayerTimeStep(
      AddPrayerTimesViewModel model, selectedIndex, context) {
    List<Prayer> prayers = model.normalPrayers;

    return Step(
      isActive: selectedIndex == 1,
      content: Column(
        children: [
          Text("Add normal prayer times: "),
          verticalSpaceMedium,
          TimesDataGrid(
            prayers: prayers,
            onPrayerTimePressed: showTimeOfDayPicker,  
            setPrayerTime: model.setTimeForPrayer,
            isEdit: true,
          )
        ],
      ),
      title: Text("Normal Prayer Times"),
    );
  }

  Step getAbnormalTimesStep(
      AddPrayerTimesViewModel model, selectedIndex, context) {
    List<Prayer> prayers = model.abnormalPrayers;

    return Step(
      isActive: selectedIndex == 2,
      content: Column(
        children: [
          Text("Add Times for Sundays and public holidays"),
          verticalSpaceMedium,
          ListView.builder(
              shrinkWrap: true,
              itemCount: prayers.length,
              itemBuilder: (BuildContext context, int index) {
                Prayer prayer = prayers[index];
                return AddTimeWidget(
                  adhanTime: prayer.adhanTime,
                  onAdhanTimePressed: () async {
                    showTimeOfDayPicker(
                        model.setTimeForPrayer, context, prayer, true);
                  },
                  onPrayerTimePressed: () async {
                    showTimeOfDayPicker(
                        model.setTimeForPrayer, context, prayer, false);
                  },
                  prayerName: prayer.prayerName,
                  prayerTime: prayer.prayerTime,
                );
              })
        ],
      ),
      title: Text("Prayer Times for sundays and public holidays"),
    );
  }

  void showTimeOfDayPicker(
      Function onTimeSelected, context, Prayer prayer, bool isAdhan) async {
    TimeOfDay result = await showTimePicker(
        context: context,
        initialTime: isAdhan ? prayer.adhanTime : prayer.prayerTime);
    if (result != null) {
      onTimeSelected(prayer, result, isAdhan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (AddPrayerTimesViewModel model) {
          model.setMosqueData(mosqueData);
        },
        builder: (context, AddPrayerTimesViewModel model, child) {
          List<Step> steps = [
            infoStep(model.currentStep),
            getNormalPrayerTimeStep(model, model.currentStep, context),
          //  getAbnormalTimesStep(model, model.currentStep, context)
          ];
          return Scaffold(
            body: model.complete
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "You have succesfully added the data, please confirm the data:"),
                      verticalSpaceLarge,
                      //TODO When you create the view for a mosque, add this in here as well as a edit button

                      Text(model.mosqueData.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BusyButton(
                              title: "Edit",
                              busy: model.isBusy,
                              onPressed: () => model.edit(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BusyButton(
                                title: "Submit",
                                busy: model.isBusy,
                                onPressed: () async => model.submit()),
                          ),
                        ],
                      )
                    ],
                  )
                : Container(
                    child: Stepper(
                    type: StepperType.vertical,
                    steps: steps,
                    currentStep: model.currentStep,
                    onStepContinue: () => model.next(steps.length),
                    onStepCancel: model.cancel,
                  )),
          );
        },
        viewModelBuilder: () => AddPrayerTimesViewModel());
  }
}

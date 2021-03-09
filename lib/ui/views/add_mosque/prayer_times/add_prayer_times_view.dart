import 'package:flutter/material.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/add_time_widget.dart';
import 'package:marrat/ui/widgets/busy_button.dart';
import 'package:marrat/ui/widgets/mosque_card.dart';
import 'package:marrat/ui/widgets/times/table_data_grid.dart';
import 'package:stacked/stacked.dart';

import 'add_prayer_times_viewmodel.dart';

class AddPrayerTimesView extends StatelessWidget {
  final Mosque mosqueData;
  final bool isNewMosque;

  AddPrayerTimesView({@required this.mosqueData, @required this.isNewMosque});

  Step infoStep(
    selectedIndex,
  ) {
    return Step(
      isActive: selectedIndex == 0,
      content: Column(
        children: [
          isNewMosque
              ? Text("One more step, add prayer times")
              : Text('Edit the prayer times for ${mosqueData.mosqueName}'),
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
          Text('Tap on a prayer to edit the time'),
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

//TODO Think about adding configuration for sundays and public holiday times:
/*   Step getAbnormalTimesStep(
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
 */
  void showTimeOfDayPicker(
      Function onTimeSelected, context, Prayer prayer, bool isAdhan) async {
    TimeOfDay result = await showTimePicker(
        context: context,
        initialTime: isAdhan ? prayer.adhanTime : prayer.prayerTime);
    if (result != null) {
      onTimeSelected(prayer, result, isAdhan);
    }
  }

  Widget _buildConfirmationUi(AddPrayerTimesViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("You have succesfully added prayer times, please confirm:"),
        verticalSpaceLarge,
        //TODO When you create the view for a mosque, add this in here as well as a edit button
        TimesDataGrid(
          isEdit: false,
          onPrayerTimePressed: () {},
          prayers: model.mosqueData.normalPrayerTimes,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BusyButton(
                title: "Edit",
                busy: false,
                onPressed: () => model.edit(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BusyButton(
                  title: "Submit",
                  busy: model.isBusy,
                  onPressed: () async => model.submit(isNewMosque)),
            ),
          ],
        )
      ],
    );
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
          ];
          return Scaffold(
            body: model.complete
                ? _buildConfirmationUi(model)
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

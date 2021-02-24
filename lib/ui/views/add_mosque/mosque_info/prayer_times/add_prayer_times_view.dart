import 'package:flutter/material.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/add_time_widget.dart';
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

  Step getNormalPrayerTimeStep(selectedIndex, context) {
    //TODO Delete this later
    Prayer prayer = prayers[0];
    print(prayer.adhanTime.format(context));
    return Step(
      isActive: selectedIndex == 4,
      content: Column(
        children: [
          Text("Add normal prayer times: "),
          verticalSpaceMedium,
          AddTimeWidget(
            adhanTime: prayer.adhanTime,
            onAdhanTimePressed: () async => await showTimePicker(
                context: context, initialTime: prayer.prayerTime),
            onPrayerTimePressed: () => print("pressed"),
            prayerName: prayer.prayerName,
            prayerTime: prayer.prayerTime,
          )
        ],
      ),
      title: Text("Normal Prayer Times"),
    );
  }

  Step getAbnormalTimesStep(model, selectedIndex, context) {
    return Step(
      isActive: selectedIndex == 4,
      content: Column(
        children: [
          Text("Add normal prayer times: "),
          verticalSpaceMedium,
          ListView.builder(
              itemCount: model.tempPrayers.length,
              itemBuilder: (BuildContext context, int index) {
                Prayer prayer = model.tempPrayers[index];
                return AddTimeWidget(
                  adhanTime: prayer.adhanTime,
                  onAdhanTimePressed: () async => await showTimePicker(
                      context: context, initialTime: prayer.prayerTime),
                  onPrayerTimePressed: () => print("pressed"),
                  prayerName: prayer.prayerName,
                  prayerTime: prayer.prayerTime,
                );
              })
        ],
      ),
      title: Text("Normal Prayer Times"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (AddPrayerTimesViewModel model) {},
        builder: (context, AddPrayerTimesViewModel model, child) {
          List<Step> steps = [
            infoStep(model.currentStep),
            getNormalPrayerTimeStep(model.currentStep, context),
            getAbnormalTimesStep(model, model.currentStep, context)
          ];
          return Scaffold(
            body: Container(
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

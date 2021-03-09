import 'package:flutter/material.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddPrayerTimesViewModel extends BaseViewModel {
  int currentStep = 0;
  bool complete = false;
  Mosque mosqueData;
  FirestoreService _firestoreService = locator<FirestoreService>();
  bool isLoading = false;
  DialogService _dialogService = locator<DialogService>();
  List<Prayer> normalPrayers = defaultNormalPrayers;

  List<Prayer> abnormalPrayers = defaultAbnormalPrayers;
  NavigationService _navigationService = locator<NavigationService>();
  static const int infoStep = 0;
  static const int normalTimesStep = 1;
  static const int abnormalTimesStep = 2;
  setTimeForPrayer(Prayer prayer, TimeOfDay time, bool isAdhan) {
    if (isAdhan) {
      prayer.adhanTime = time;
    } else {
      prayer.prayerTime = time;
    }
    return notifyListeners();
  }

  setMosqueData(Mosque mosque) {
    mosqueData = mosque;
    notifyListeners();
  }

  setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future submit(bool isNewMosque) async {
    setBusy(true);
    var result; 
    if (isNewMosque) {
      result = await _firestoreService.uploadMosqueData(mosqueData);
    } else {
      result = await _firestoreService.editMosqueData(mosqueData);
    }
    setBusy(false);
    if (result) {
      await _dialogService.showDialog(
          title: 'Success',
          description:
              'You have succesfully added a mosque, view this on the main page',
          buttonTitle: 'Show Me');
      return _navigationService.navigateTo(Routes.homeView);
    } else {
      return await _dialogService.showDialog(
        title: 'Error ',
        description: 'Failed to add a mosque, try again later',
      );
    }
  }

  next(int length, {String name, location}) {
    /*  if (currentStep + 1 == abnormalTimesStep) {
      abnormalPrayers = normalPrayers;
    } */
    if (currentStep + 1 != length) {
      goTo(currentStep + 1);
    } else {
      complete = true;
      mosqueData.normalPrayerTimes = normalPrayers;
      mosqueData.abnormalPrayerTimes = abnormalPrayers;
    }
    notifyListeners();
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
    notifyListeners();
  }

  goTo(int step) {
    currentStep = step;
    notifyListeners();
  }

  edit() {
    complete = false;
    notifyListeners();
  }
}

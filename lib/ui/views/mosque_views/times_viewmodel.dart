import 'package:flutter/cupertino.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/database/mock_data_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:marrat/ui/setup_services_ui/bottom_sheet_type.dart';
import 'package:marrat/ui/setup_services_ui/setup_bottom_sheet_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TimesViewModel extends FutureViewModel<List<Mosque>> {
  LocationService _locationService = locator<LocationService>();
  MockDataService _mockDataService = locator<MockDataService>();
  NavigationService _navigationService = locator<NavigationService>();
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  bool searchActive = false;

  GeoFlutterFireService _geoFlutterFireService =
      locator<GeoFlutterFireService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  List<Mosque> defaultMosques = [];
  List<Mosque> searchMosques = [];
  UserLocation userLocation;

  Future<List<Mosque>> initiliase() async {
    print('initialising');
    var location = _locationService.currentLocation;
    if (location != null) {
      userLocation = location;
      var result = await _geoFlutterFireService.getMosques(
          userLocation.latitude, userLocation.longitude, mosqueRadius);
      if (result is List<Mosque>) {
        return result;
      }
    }
    return [];
  }

  Future<void> searchForMosques(String text) async {
    if (text.length > 2) {
      searchActive = true;
      setBusyForObject(searchMosques, true);
      var result = await _firestoreService.searchForMosques(text);
      if (result.length >= 0) {
        searchMosques = result;
      }
      setBusyForObject(searchMosques, false);
    }
  }

  navigateToEditTimesView(Mosque mosque) {
    return _navigationService.navigateTo(Routes.addPrayerTimesView,
        arguments: AddPrayerTimesViewArguments(
            mosqueData: mosque, isNewMosque: false));
  }

  @override
  Future<List<Mosque>> futureToRun() async => await initiliase();
  setSearchActive(bool value) {
    searchActive = value;
    notifyListeners();
  }

  Future showTimesBottomSheet(
    Mosque mosque,
  ) async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      isScrollControlled: true,
      variant: BottomSheetType.floating,
      title: 'Times for ${mosque.mosqueName}',
      customData: TimesBottomSheetArguments(
          mosque.normalPrayerTimes, () => navigateToEditTimesView(mosque)),
      description:
          'This sheet is a custom built bottom sheet UI that allows you to show it from any service or viewmodel.',
      mainButtonTitle: 'Edit the times',
      secondaryButtonTitle: 'Dismiss',
    );
  }
}

import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
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
  double searchingDistance = 10;
  Future<List<Mosque>> initiliase() async {
    var location = _locationService.currentLocation;
    var result;
    if (location != null) {
      userLocation = location;
      result = await _geoFlutterFireService.getMosques(
          userLocation.latitude, userLocation.longitude, mosqueRadius);
    } else {
      result = await _firestoreService.getAllMosques();
    }
    if (result is List<Mosque>) {
      return result;
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

  @override
  Future<List<Mosque>> futureToRun() async => await initiliase();

  setSearchActive(bool value) {
    searchActive = value;
    notifyListeners();
  }

  Future showTimesBottomSheet(
    Mosque mosque,
  ) async {
    await _bottomSheetService.showCustomSheet(
      isScrollControlled: true,
      variant: BottomSheetType.floating,
      title: 'Times for ${mosque.mosqueName}',
      customData: TimesBottomSheetArguments(
          mosque.normalPrayerTimes, () => navigateToEditTimesView(mosque)),
      mainButtonTitle: 'Edit the times',
      secondaryButtonTitle: 'Dismiss',
    );
  }

  navigateToEditTimesView(Mosque mosque) {
    return _navigationService.navigateTo(Routes.addPrayerTimesView,
        arguments: AddPrayerTimesViewArguments(
            mosqueData: mosque, isNewMosque: false));
  }
}

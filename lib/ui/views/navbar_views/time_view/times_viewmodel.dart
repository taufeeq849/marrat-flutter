import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/database/mock_data_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TimesViewModel extends FutureViewModel<List<Mosque>> {
  LocationService _locationService = locator<LocationService>();
  MockDataService _mockDataService = locator<MockDataService>();
  NavigationService _navigationService = locator<NavigationService>();
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

  navigateToMosqueView(Mosque mosque) {
    return _navigationService.navigateTo(Routes.specificMosqueView,
        arguments: SpecificMosqueViewArguments(mosque: mosque));
  }

  @override
  Future<List<Mosque>> futureToRun() async => await initiliase();
  setSearchActive(bool value) {
    searchActive = value;
    notifyListeners();
  }
}

import 'package:marrat/app/locator.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/database/mock_data_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:stacked/stacked.dart';

class TimesViewModel extends FutureViewModel<List<Mosque>> {
  LocationService _locationService = locator<LocationService>();
  MockDataService _mockDataService = locator<MockDataService>();
  GeoFlutterFireService _geoFlutterFireService =
      locator<GeoFlutterFireService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  List<Mosque> mosques = [];
  UserLocation userLocation;
  void getLocation() {}

  Future<List<Mosque>> initiliase() async {
    print('initialising');
    var location = _locationService.currentLocation;
    if (location != null) {
      userLocation = location;
      var result = await _firestoreService.getNearbyMosques(
          userLat: location.latitude, userLong: location.longitude);
      if (result is List<Mosque>) {
        return result;
      } else {
        return [];
      }
    }
  }

  @override
  Future<List<Mosque>> futureToRun() async => await initiliase();

  uploadMockData() async {
    var result = await _mockDataService.uploadMockData();
    if (result) {
      print('succesfully added data ');
    } else {
      print('did not succesfully added data ');
    }
  }
}

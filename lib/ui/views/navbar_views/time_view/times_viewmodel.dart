import 'package:marrat/app/locator.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:stacked/stacked.dart';

class TimesViewModel extends BaseViewModel {
  LocationService _locationService = locator<LocationService>();
  UserLocation userLocation;
  void getLocation() {
    var location = _locationService.currentLocation;
    if (location != null) {
      userLocation = location;
    }
  }
}

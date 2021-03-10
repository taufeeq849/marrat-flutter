import 'package:location/location.dart';
import 'package:marrat/models/user/user_location.dart';

class LocationService {
  UserLocation currentLocation;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  var location = Location();

  Future getLocation() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      currentLocation = UserLocation(
          latitude: _locationData.latitude, longitude: _locationData.longitude);
      return currentLocation;
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
      return e.toString();
    }
  }
}

import 'package:location/location.dart';
import 'package:marrat/models/user/user_location.dart';

class LocationService {
  UserLocation currentLocation;

  var location = Location();

  Future getLocation() async {
    try {
      var userLocation = await location.getLocation();
      currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
      return e.toString();
    }

    return currentLocation;
  }
}

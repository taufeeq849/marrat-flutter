import 'package:geocoder/geocoder.dart';

class GeocoderService {
  getLatLngFromAddress(String address) async {
    try {
      var addresses = await Geocoder.local.findAddressesFromQuery(address);
      var first = addresses.first;
      return first.coordinates;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

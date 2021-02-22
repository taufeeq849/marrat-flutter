import 'package:geocoder/geocoder.dart';
import 'package:marrat/models/mosque/mosque_location.dart';

class GeocoderService {
  getAddressFromLocation(String address) async {
    try {
      var addresses = await Geocoder.local.findAddressesFromQuery(address);
      var first = addresses.first;
      return MosqueLocation(
          latitude: first.coordinates.latitude,
          longitude: first.coordinates.longitude);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

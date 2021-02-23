import 'package:geoflutterfire/geoflutterfire.dart';

class GeoHashService {
  final geo = Geoflutterfire();
  getGeoHashFromCoords({double lat, double long}) {
    GeoFirePoint location = geo.point(latitude: lat, longitude: long);
    return location;
  }
}

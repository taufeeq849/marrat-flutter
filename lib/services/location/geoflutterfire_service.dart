import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeoFlutterFireService {
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;
  getGeoHashFromCoords({double lat, double long}) {
    GeoFirePoint location = geo.point(latitude: lat, longitude: long);
    return location;
  }

  getGeohashRange({double userLat, double userLong, double distance}) {
    double lat = 0.0144927536231884; // degrees latitude per mile
    double lon = 0.0181818181818182; //
    double lowerLat = userLat - lat * distance;
    double lowerLon = userLong - lon * distance;

    double upperLat = userLat + lat * distance;
    double upperLon = userLong + lon * distance;
    GeoFirePoint lower = geo.point(latitude: lowerLat, longitude: lowerLon);
    GeoFirePoint upper = geo.point(latitude: upperLat, longitude: upperLon);
    return Range(lower: lower.hash, upper: upper.hash);
  }
}

class Range {
  String lower;
  String upper;
  Range({this.lower, this.upper});
}

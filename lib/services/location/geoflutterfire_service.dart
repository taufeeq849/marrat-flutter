import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';

class GeoFlutterFireService {
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;
  getGeoHashFromCoords({double lat, double long}) {
    GeoFirePoint location = geo.point(latitude: lat, longitude: long);
    return location;
  }

  Future<List<Mosque>> getMosques(
      double lat, double long, double radius) async {
    GeoFirePoint center = geo.point(latitude: lat, longitude: long);
    var collectionReference = _firestore.collection('mosques');
    String field = 'location.geohash';
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(
            center: center,
            radius: mosqueRadius,
            field: field,
            strictMode: true);
    List<DocumentSnapshot> documents = await stream.first;
    if (documents.isNotEmpty) {
      List<Mosque> mosques = documents.map((e) {
        double lat = e.data()['location']['latitude'];
        double longitude = e.data()['location']['longitude'];
        double distance = center.distance(lat: lat, lng: longitude);
        return Mosque.fromMap(e.data(), distance: distance);
      }).toList();
      return mosques;
    } else {
      return [];
    }
  }

  getGeohashRange({double userLat, double userLong, double distance}) {
    final GeoFirePoint center =
        geo.point(latitude: userLat, longitude: userLong);
    final double radiusInM = distance * 1000;
    return Range(lower: 'djhskjd', upper: 'djhskjd');
  }
}

class Range {
  String lower;
  String upper;
  Range({this.lower, this.upper});
}

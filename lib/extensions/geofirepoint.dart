import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

extension GeoFirePointExtension on Geoflutterfire {
  static fromMap(map) {
    var geohashObject = map['geohash'];
    var geohash = geohashObject['geohash'];
    var geopoint = geohashObject['geopoint'];
  }
}

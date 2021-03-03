import 'dart:convert';

import 'package:geoflutterfire/geoflutterfire.dart';

class MosqueLocation {
  GeoFirePoint geohash;
  double latitude;
  double longitude;
  MosqueLocation({
    this.geohash,
    this.latitude,
    this.longitude,
  });

  MosqueLocation copyWith({
    var geohash,
    double latitude,
    double longitude,
  }) {
    return MosqueLocation(
      geohash: geohash ?? this.geohash,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'geohash': geohash?.data,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory MosqueLocation.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MosqueLocation(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MosqueLocation.fromJson(String source) =>
      MosqueLocation.fromMap(json.decode(source));

  @override
  String toString() =>
      'MosqueLocation(geohash: $geohash, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MosqueLocation &&
        o.geohash == geohash &&
        o.latitude == latitude &&
        o.longitude == longitude;
  }

  @override
  int get hashCode => geohash.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}

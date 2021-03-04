import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:marrat/constants/constants.dart';

import 'mosque_location.dart';
import 'prayer.dart';

class Mosque {
  String mosqueName;
  String mosqueImageUrl;
  String docID;
  List<Prayer> normalPrayerTimes;
  List<Prayer> abnormalPrayerTimes;
  MosqueLocation location;
  bool hasLadiesFacilities;
  bool hasWudhuKhana;
  String address;
  double distance;

  Mosque(
      {this.mosqueName,
      this.mosqueImageUrl = placeHolderImageUrl,
      this.docID,
      this.normalPrayerTimes,
      this.abnormalPrayerTimes,
      this.hasLadiesFacilities = false,
      this.hasWudhuKhana = false,
      this.address,
      this.distance,
      this.location});

  Mosque copyWith({
    String mosqueName,
    String mosqueImageUrl,
    String docID,
    List<Prayer> normalPrayerTimes,
    List<Prayer> abnormalPrayerTimes,
    bool hasLadiesFacilities,
    bool hasWudhuKhana,
  }) {
    return Mosque(
      mosqueName: mosqueName ?? this.mosqueName,
      mosqueImageUrl: mosqueImageUrl ?? this.mosqueImageUrl,
      docID: docID ?? this.docID,
      normalPrayerTimes: normalPrayerTimes ?? this.normalPrayerTimes,
      abnormalPrayerTimes: abnormalPrayerTimes ?? this.abnormalPrayerTimes,
      hasLadiesFacilities: hasLadiesFacilities ?? this.hasLadiesFacilities,
      hasWudhuKhana: hasWudhuKhana ?? this.hasWudhuKhana,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mosqueName': mosqueName,
      'mosqueImageUrl': mosqueImageUrl,
      'docID': docID,
      'normalPrayerTimes': normalPrayerTimes?.map((x) => x?.toMap())?.toList(),
      'abnormalPrayerTimes':
          abnormalPrayerTimes?.map((x) => x?.toMap())?.toList(),
      'hasLadiesFacilities': hasLadiesFacilities,
      'hasWudhuKhana': hasWudhuKhana,
      'address': address,
      'location': location.toMap(),
    };
  }

  factory Mosque.fromMap(Map<String, dynamic> map, {double distance = -1000}) {
    if (map == null) return null;

    return Mosque(
        mosqueName: map['mosqueName'],
        mosqueImageUrl: map['mosqueImageUrl'],
        docID: map['docID'],
        normalPrayerTimes: List<Prayer>.from(
            map['normalPrayerTimes']?.map((x) => Prayer.fromMap(x))),
        abnormalPrayerTimes: List<Prayer>.from(
            map['abnormalPrayerTimes']?.map((x) => Prayer.fromMap(x))),
        hasLadiesFacilities: map['hasLadiesFacilities'],
        hasWudhuKhana: map['hasWudhuKhana'],
        address: map['address'],
        distance: distance);
  }

  String toJson() => json.encode(toMap());

  factory Mosque.fromJson(String source) => Mosque.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Mosque(mosqueName: $mosqueName, mosqueImageUrl: $mosqueImageUrl, docID: $docID, normalPrayerTimes: $normalPrayerTimes, abnormalPrayerTimes: $abnormalPrayerTimes, hasLadiesFacilities: $hasLadiesFacilities, hasWudhuKhana: $hasWudhuKhana)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Mosque &&
        o.mosqueName == mosqueName &&
        o.mosqueImageUrl == mosqueImageUrl &&
        o.docID == docID &&
        listEquals(o.normalPrayerTimes, normalPrayerTimes) &&
        listEquals(o.abnormalPrayerTimes, abnormalPrayerTimes) &&
        o.hasLadiesFacilities == hasLadiesFacilities &&
        o.hasWudhuKhana == hasWudhuKhana;
  }

  @override
  int get hashCode {
    return mosqueName.hashCode ^
        mosqueImageUrl.hashCode ^
        docID.hashCode ^
        normalPrayerTimes.hashCode ^
        abnormalPrayerTimes.hashCode ^
        hasLadiesFacilities.hashCode ^
        hasWudhuKhana.hashCode;
  }
}

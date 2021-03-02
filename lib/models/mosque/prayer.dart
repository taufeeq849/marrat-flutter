import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/extensions/time_of_day.dart';
import 'package:marrat/services/context_service.dart';

class Prayer {
  String prayerName;
  TimeOfDay prayerTime;
  TimeOfDay adhanTime;

  Prayer({
    this.prayerName,
    this.prayerTime,
    this.adhanTime,
  }) {
    if (prayerTime != null && adhanTime == null) {
      this.adhanTime = prayerTime.subtractMinutes(15);
    }
  }

  Prayer copyWith({
    String prayerName,
    TimeOfDay prayerTime,
    TimeOfDay adhanTime,
  }) {
    return Prayer(
      prayerName: prayerName ?? this.prayerName,
      prayerTime: prayerTime ?? this.prayerTime,
      adhanTime: adhanTime ?? this.adhanTime,
    );
  }

  String formatTimeOfDay(TimeOfDay time) {
    String initialTime = time.toString();
    String formattedTime = initialTime.substring(
        initialTime.indexOf('(') + 1, initialTime.lastIndexOf(')'));
    return formattedTime;
  }

  Map<String, dynamic> toMap() {
    return {
      'prayerName': prayerName,
      'prayerTime': formatTimeOfDay(prayerTime),
      'adhanTime': formatTimeOfDay(adhanTime)
    };
  }

  factory Prayer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prayer(
      //TODO Figure out how to convert the time of day from the map, depending on how it is stored.
      prayerName: map['prayerName'],
      prayerTime: map['prayerTime'],
      adhanTime: map['adhanTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Prayer.fromJson(String source) => Prayer.fromMap(json.decode(source));

  @override
  String toString() =>
      'Prayer(prayerName: $prayerName, prayerTime: $prayerTime, adhanTime: $adhanTime)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prayer &&
        o.prayerName == prayerName &&
        o.prayerTime == prayerTime &&
        o.adhanTime == adhanTime;
  }

  @override
  int get hashCode =>
      prayerName.hashCode ^ prayerTime.hashCode ^ adhanTime.hashCode;
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marrat/extensions/time_of_day.dart';

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
      prayerName: map['prayerName'],
      prayerTime: TimeOfDay(
          hour: int.parse(map['prayerTime'].split(":")[0]),
          minute: int.parse(map['prayerTime'].split(":")[1])),
      adhanTime: TimeOfDay(
          hour: int.parse(map['adhanTime'].split(":")[0]),
          minute: int.parse(map['adhanTime'].split(":")[1])),
    );
  }

  TimeOfDay timeConvert(String s) {
    TimeOfDay time = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    return time;
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/prayer.dart';

final int posts_limit = 10;
const placeHolderImageUrl = 'https://i.imgur.com/sUFH1Aq.png';

//List for prayers, manually hard coded at the moment:
Prayer fajr = Prayer(
  prayerName: 'Fajr',
  prayerTime: TimeOfDay(hour: 05, minute: 00),
);
Prayer zuhr = Prayer(
  prayerName: 'zuhr',
  prayerTime: TimeOfDay(hour: 13, minute: 00),
);
Prayer asr = Prayer(
  prayerName: 'asr',
  prayerTime: TimeOfDay(hour: 17, minute: 00),
);
Prayer maghrib = Prayer(
  prayerName: 'maghrib',
  prayerTime: TimeOfDay(hour: 19, minute: 00),
);
Prayer esha = Prayer(
  prayerName: 'esha',
  prayerTime: TimeOfDay(hour: 20, minute: 30),
);
Prayer jummah = Prayer(
  prayerName: 'jummah',
  prayerTime: TimeOfDay(hour: 12, minute: 30),
);
List<Prayer> prayers = [fajr, zuhr, asr, maghrib, esha, jummah];

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marrat/models/mosque/prayer.dart';

const placeHolderImageUrl = 'https://i.imgur.com/sUFH1Aq.png';
double mosqueRadius = 10;
//List for prayers, manually hard coded at the moment:
Prayer fajr = Prayer(
  prayerName: 'Fajr',
  prayerTime: TimeOfDay(hour: 05, minute: 00),
);
Prayer zuhr = Prayer(
  prayerName: 'Zuhr',
  prayerTime: TimeOfDay(hour: 13, minute: 00),
);
Prayer asr = Prayer(
  prayerName: 'Asr',
  prayerTime: TimeOfDay(hour: 17, minute: 00),
);
Prayer maghrib = Prayer(
  prayerName: 'Maghrib',
  prayerTime: TimeOfDay(hour: 19, minute: 00),
);
Prayer esha = Prayer(
  prayerName: 'Esha',
  prayerTime: TimeOfDay(hour: 20, minute: 30),
);
Prayer jummah = Prayer(
  prayerName: 'Jummah',
  prayerTime: TimeOfDay(hour: 12, minute: 30),
);
List<Prayer> defaultNormalPrayers = [fajr, zuhr, asr, maghrib, esha, jummah];
List<Prayer> defaultAbnormalPrayers = [fajr, zuhr, asr, maghrib, esha, jummah];

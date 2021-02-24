import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  // Ported from org.threeten.bp;
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = this.hour * 60 + this.minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }

  TimeOfDay subtractMinutes(int minutes) {
    if (minutes == 0)
      return this;
    else {
      int newHour;
      int newMinutes;

      if (this.minute == 0) {
        newHour = this.hour - 1;
        newMinutes = 60 - minutes;
      } else if (this.minute <= minutes) {
        newHour = this.hour - 1;
        newMinutes = (this.minute - minutes) + 60;
      } else {
        newHour = this.hour;
        newMinutes = this.minute - 15;
      }
      return TimeOfDay(hour: newHour, minute: newMinutes);
    }
  }
}

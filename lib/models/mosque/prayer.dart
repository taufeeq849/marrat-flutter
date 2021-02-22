import 'dart:convert';

class Prayer {
  String prayerName;
  DateTime prayerTime;
  Prayer({
    this.prayerName,
    this.prayerTime,
  });

  Prayer copyWith({
    String prayerName,
    DateTime prayerTime,
  }) {
    return Prayer(
      prayerName: prayerName ?? this.prayerName,
      prayerTime: prayerTime ?? this.prayerTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prayerName': prayerName,
      'prayerTime': prayerTime?.millisecondsSinceEpoch,
    };
  }

  factory Prayer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Prayer(
      prayerName: map['prayerName'],
      prayerTime: DateTime.fromMillisecondsSinceEpoch(map['prayerTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Prayer.fromJson(String source) => Prayer.fromMap(json.decode(source));

  @override
  String toString() => 'Prayer(prayerName: $prayerName, prayerTime: $prayerTime)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Prayer &&
      o.prayerName == prayerName &&
      o.prayerTime == prayerTime;
  }

  @override
  int get hashCode => prayerName.hashCode ^ prayerTime.hashCode;
}

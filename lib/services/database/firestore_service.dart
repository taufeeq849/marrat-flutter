import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';

class FirestoreService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  GeoFlutterFireService _geoFlutterFireService =
      locator<GeoFlutterFireService>();
  Future<bool> uploadMosqueData(Mosque mosqueData) async {
    try {
      await _firebaseFirestore.collection('mosques').add(mosqueData.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getNearbyMosques({double userLat, double userLong}) async {
    Range range = _geoFlutterFireService.getGeohashRange(
        userLat: userLat, userLong: userLong, distance: mosqueRadius);
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('mosques')
        /*     .where("location.geohash",
            isGreaterThanOrEqualTo: range.upper,
            isLessThanOrEqualTo: range.lower) */
        .get();
    print(querySnapshot.docs.length);

    List<Mosque> mosques = querySnapshot.docs.map((e) {
      print(e.data());
      return Mosque.fromMap(e.data());
    }).toList();
    return mosques;
  }
}

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
      var docId = await _firebaseFirestore.collection('mosques').doc().id;
      await _firebaseFirestore
          .collection('mosques')
          .doc(docId)
          .set(mosqueData.toMap(paramDocID: docId));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> editMosqueData(Mosque mosqueData) async {
    try {
      await _firebaseFirestore
          .collection('mosques')
          .doc(mosqueData.docID)
          .update(mosqueData.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<Mosque>> getAllMosques() async {
    var querySnapshot =
        await _firebaseFirestore.collection('mosques').limit(10).get();
    if (querySnapshot.docs.isNotEmpty) {
      List<Mosque> mosques = querySnapshot.docs.map((e) {
        return Mosque.fromMap(e.data());
      }).toList();
      return mosques;
    }
    return [];
  }

  Future<List<Mosque>> searchForMosques(String query) async {
    var querySnapshot = await _firebaseFirestore
        .collection('mosques')
        .where(
          'mosqueName',
          isGreaterThanOrEqualTo: query,
        )
        .where('mosqueName',
            isLessThanOrEqualTo: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<Mosque> mosques = querySnapshot.docs.map((e) {
        print(e.data());
        return Mosque.fromMap(e.data());
      }).toList();
      return mosques;
    }
    print('is empty');
    return [];
  }
}

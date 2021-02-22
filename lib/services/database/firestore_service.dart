import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marrat/models/mosque/mosque.dart';

class FirestoreService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> uploadMosqueData(Mosque mosqueData) async {
    try {
      await _firebaseFirestore
          .collection('mosques')
          .add(mosqueData.toMap())
          .then((value) {
        return true;
      }).catchError((error) {
        print(error.toString());
        return false;
      });
    } catch (e) {
      return false;
    }
  }
}

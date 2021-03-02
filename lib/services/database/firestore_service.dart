import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marrat/models/mosque/mosque.dart';

class FirestoreService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> uploadMosqueData(Mosque mosqueData) async {
    try {
      await _firebaseFirestore.collection('mosques').add(mosqueData.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

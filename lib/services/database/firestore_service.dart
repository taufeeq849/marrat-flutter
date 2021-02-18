import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  CollectionReference _videoCollectionReference =
      FirebaseFirestore.instance.collection("videos");
}

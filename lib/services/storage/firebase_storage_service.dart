import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseStorageService {
  final _firebaseStorageInstance = FirebaseStorage.instance;
  Future uploadImage(File file) async {
    try {
      var snapshot = await _firebaseStorageInstance
          .ref()
          .child('mosqueImages/${UniqueKey().toString()}')
          .putFile(file)
          .onComplete;
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}

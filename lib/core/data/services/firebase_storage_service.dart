//Firebase Storage Service
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(String path, File file) async {
    try {
      final ref = _firebaseStorage.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImage(String path) async {
    try {
      final ref = _firebaseStorage.ref().child(path);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }
}

//Firebase Auth Service
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:waterhero/core/data/network/firebase_rest.dart';
import 'package:waterhero/core/data/services/firebase_storage_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseRest _firebaseRest = FirebaseRest();
  final FirebaseStorageService _storage = FirebaseStorageService();

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    File profilePicture,
    String serviceCode, //import dart:io File
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        final resultLoad = await _storage.uploadImage(
          'profilePictures/${result.user!.uid}',
          profilePicture,
        );
        await _firebaseRest.addData('users', {
          'uid': result.user!.uid,
          'email': email,
          'name': name,
          'profilePicture': resultLoad,
          'createdAt': DateTime.now().toIso8601String(),
          'code': serviceCode,
        });
        //update userCredential
        await result.user!.updateDisplayName(name);
        await result.user!.updatePhotoURL(resultLoad);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User> getCurrentUser() async {
    return _auth.currentUser!;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;
    await user!.updatePassword(password);
  }

  Future<void> updateEmail(String email) async {
    final user = _auth.currentUser;
    await user!.verifyBeforeUpdateEmail(email);
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    await user!.delete();
  }

  Future<void> reauthenticate(String password) async {
    final user = _auth.currentUser;
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }
}

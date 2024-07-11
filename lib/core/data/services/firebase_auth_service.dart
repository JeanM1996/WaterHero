//Firebase Auth Service
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/core/data/exceptions/unauthorized_exception.dart';
import 'package:waterhero/core/data/network/firebase_rest.dart';
import 'package:waterhero/core/data/network/http_client.dart';
import 'package:waterhero/core/data/services/firebase_storage_service.dart';

final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseRest _firebaseRest = FirebaseRest();
  final FirebaseStorageService _storage = FirebaseStorageService();

  Future<HttpServiceResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        final sharedPreference = await SharedPreferences.getInstance();
        await sharedPreference.setString('token', result.user!.uid);
        return HttpServiceResponse(
          success: true,
          message: 'User logged in successfully',
        );
      }
      throw UnauthorizedException();
    } catch (e) {
      rethrow;
    }
  }

  Future<HttpServiceResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String lastName,
    String serviceCode, //import dart:io File
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await _firebaseRest.addDataWithId('users', result.user!.uid, {
          'uid': result.user!.uid,
          'email': email,
          'name': name,
          'createdAt': DateTime.now().toIso8601String(),
          'code': serviceCode,
        });
        //update userCredential
        await result.user!.updateDisplayName(name);
        final sharedPreference = await SharedPreferences.getInstance();
        await sharedPreference.setString('token', result.user!.uid);
      }

      return HttpServiceResponse(
        success: true,
        message: 'User created successfully',
      );
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

  Future<HttpServiceResponse> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return HttpServiceResponse(
      success: true,
      message: 'Email sent successfully',
    );
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

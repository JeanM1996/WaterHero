import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';
import 'package:waterhero/core/data/services/firebase_auth_service.dart';

final loginDataSourceProvider =
    Provider<LoginDataSource>((ref) => LoginDataSourceImpl(HttpClient()));

abstract class LoginDataSource {
  Future<HttpServiceResponse> login(
    String email,
    String password,
  );
}

class LoginDataSourceImpl extends LoginDataSource {
  LoginDataSourceImpl(this.httpClient);
  final HttpClient httpClient;

  @override
  Future<HttpServiceResponse> login(
    String email,
    String password,
  ) async {
    return firebaseAuthService.signInWithEmailAndPassword(
      email,
      password,
    );
  }
}

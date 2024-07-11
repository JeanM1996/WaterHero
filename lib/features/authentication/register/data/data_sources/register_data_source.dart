import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';
import 'package:waterhero/core/data/services/firebase_auth_service.dart';

final registerDataSourceProvider =
    Provider<RegisterDataSource>((ref) => RegisterDataSourceImpl(HttpClient()));

abstract class RegisterDataSource {
  Future<HttpServiceResponse> register(
    String email,
    String password,
    String name,
    String lastName,
    String serviceCode,
  );
}

class RegisterDataSourceImpl extends RegisterDataSource {
  RegisterDataSourceImpl(this.httpClient);
  final HttpClient httpClient;

  @override
  Future<HttpServiceResponse> register(
    String email,
    String password,
    String name,
    String lastName,
    String serviceCode,
  ) async {
    return firebaseAuthService.signUpWithEmailAndPassword(
      email,
      password,
      name,
      lastName,
      serviceCode,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final loginDataSourceProvider =
    Provider<LoginDataSource>((ref) => LoginDataSourceImpl(HttpClient()));

abstract class LoginDataSource {
  Future<HttpServiceResponse> login(
      String email, String password, String oneSignal);
}

class LoginDataSourceImpl extends LoginDataSource {
  final HttpClient httpClient;

  LoginDataSourceImpl(this.httpClient);

  @override
  Future<HttpServiceResponse> login(
      String email, String password, String oneSignal) async {
    return httpClient.post(
      endpoint: '/auth',
      body: {"email": email, "password": password, "oneSignal": oneSignal},
    );
  }
}

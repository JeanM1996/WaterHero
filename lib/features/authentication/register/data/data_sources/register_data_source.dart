import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final registerDataSourceProvider =
    Provider<RegisterDataSource>((ref) => RegisterDataSourceImpl(HttpClient()));

abstract class RegisterDataSource {
  Future<HttpServiceResponse> register(
    String email,
    String password,
  );
}

class RegisterDataSourceImpl extends RegisterDataSource {
  RegisterDataSourceImpl(this.httpClient);
  final HttpClient httpClient;

  @override
  Future<HttpServiceResponse> register(
    String email,
    String password,
  ) async {
    return httpClient.post(
      endpoint: '/auth',
      body: {
        'email': email,
        'password': password,
      },
    );
  }
}

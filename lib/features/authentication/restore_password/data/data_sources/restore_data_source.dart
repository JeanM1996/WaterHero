import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';

final restoreDataSourceProvider =
    Provider<RestoreDataSource>((ref) => RestoreDataSourceImpl(HttpClient()));

abstract class RestoreDataSource {
  Future<HttpServiceResponse> restore(
    String email,
    String password,
    String oneSignal,
  );
}

class RestoreDataSourceImpl extends RestoreDataSource {
  RestoreDataSourceImpl(this.httpClient);
  final HttpClient httpClient;

  @override
  Future<HttpServiceResponse> restore(
    String email,
    String password,
    String oneSignal,
  ) async {
    return httpClient.post(
      endpoint: '/auth',
      body: {'email': email, 'password': password, 'oneSignal': oneSignal},
    );
  }
}

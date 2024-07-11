import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/core/data/network/http_client.dart';
import 'package:waterhero/core/data/services/firebase_auth_service.dart';

final restoreDataSourceProvider =
    Provider<RestoreDataSource>((ref) => RestoreDataSourceImpl(HttpClient()));

abstract class RestoreDataSource {
  Future<HttpServiceResponse> restore(
    String email,
  );
}

class RestoreDataSourceImpl extends RestoreDataSource {
  RestoreDataSourceImpl(this.httpClient);
  final HttpClient httpClient;

  @override
  Future<HttpServiceResponse> restore(
    String email,
  ) async {
    return firebaseAuthService.sendPasswordResetEmail(email);
  }
}

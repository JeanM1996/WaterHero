import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/login/data/data_sources/login_data_source.dart';
import 'package:waterhero/features/authentication/login/domain/repositories/login_repository.dart';

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepositoryImpl(ref.read(loginDataSourceProvider)),
);

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this.dataSource);

  final LoginDataSource dataSource;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterhero/features/authentication/register/data/data_sources/register_data_source.dart';
import 'package:waterhero/features/authentication/register/domain/repositories/register_repository.dart';

final registerRepositoryProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepositoryImpl(ref.read(registerDataSourceProvider)),
);

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this.dataSource);

  final RegisterDataSource dataSource;
}
